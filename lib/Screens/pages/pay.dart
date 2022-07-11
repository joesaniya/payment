import 'package:flutter/material.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class PayMoney extends StatefulWidget {
  const PayMoney({Key? key}) : super(key: key);

  @override
  State<PayMoney> createState() => _PayMoneyState();
}

class _PayMoneyState extends State<PayMoney> {
  String _errorMessage = "";
  final _formKey = GlobalKey<FormState>();

  Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
  }

  void openCheckout(){
    print('open checkout');
    var options = {
      "key" : "rzp_test_Zpx9zpp0byhtjD",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "Sample App",
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "2323232323",
        "email" : "shdjsdh@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
      razorpay!.open(options);

    }catch(e){
      print(e.toString());
    }

  }

  void handlerPaymentSuccess(){
    print("Pament success");
    Toast.show("Pament success");
    // Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error");
    // Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet");
    // Toast.show("External Wallet", context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Pay Money', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView
      (
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [

            Form
            (
              child: Column
              (
                key: _formKey,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: 
                [
                  Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 400,
                    height: 200,
                      decoration: BoxDecoration(
                        color: Appcolor.card,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: Center(
                            child: TextFormField(
                              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              controller: textEditingController,
                              validator: (input) {
                              if (input!.isEmpty) return 'Enter amount';
                            },
                              decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Enter Amount',
                              labelStyle: TextStyle
                              (
                                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700,
                              )
                            )),
                          )))),
                   Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Appcolor.secondary,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a Snackbar.
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                          openCheckout();
                        }
                      },
                      child: Text(
                        'Pay Money',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Appcolor.secondary)),
                    ),
                  )),
                ],
              )
            )
    
          ],
        ),
      ),
    );
  }
}
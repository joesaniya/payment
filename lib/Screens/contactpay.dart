import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:payment_app/Screens/pages/homepage.dart';
import 'package:payment_app/theme/theme.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class ContactPay extends StatefulWidget {
  // const ContactPay({Key? key}) : super(key: key);
  final String name;
  final String avatar;
  const ContactPay({ Key? key, required this.name, required this.avatar }) : super(key: key);

  @override
  State<ContactPay> createState() => _ContactPayState();
}

class _ContactPayState extends State<ContactPay> {

  var amount = TextEditingController(text: "0.00");
    Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();



  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);

    getAmount();

    _focusNode.addListener(onFocusChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
    amount.dispose();
  }

  Future openCheckout()async{
    print('open checkout');
    var options = {
      "key" : "rzp_test_Zpx9zpp0byhtjD",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : widget.name,
      "description" : 'paid',
      "prefill" : {
        "contact" : "9876543210",
        "email" : "estherjenslin@gmail.com"
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
    // Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
    // Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
    // Toast.show("External Wallet", context);
  }

    bool _validate = false;

  FocusNode _focusNode = new FocusNode();
  TextEditingController _editingController = new TextEditingController();
  bool isFocused = false;

  List<String> _feedbacks = [
    'For Banking Loan',
    'For Grocceries',
    'For EB Bill',
    'For Bike Insurance',
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   _focusNode.addListener(onFocusChanged);
  // }

  void onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    print('focus changed.');
  }

    var detamt;
  var Total;

  var tranfered;

getAmount() async
{
  print('getamount-->pay');
  DocumentSnapshot variable = await FirebaseFirestore.instance.collection('payment').doc
  (
    // 'f13LicFOzzfMeYtVzxfe'
    'payment_details'
  ).get();
  // doc('MzdflPYy2CCoJI2A2ZgL').get();//only one document value will be get
  print('Sample Data 2 : ${variable['deptamt']}');//de
  print('Sample Data 1 : ${variable['totamt']}');
  setState(() {
     detamt=variable['totamt'];
     Total=variable['deptamt'];
    print('dedamt:${detamt}');
    
    // tranfered=variable['totamt']-variable['deptamt'];
    // print('tranfered:${tranfered}');

    // int sum =(variable['totamt']) - (variable['totamt']);
    // res = sum.toString();
    // log('res+$res');
  });
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Send Money', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              FadeInDown(
                from: 100,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Appcolor.secondary,
                    // color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(widget.avatar,fit: BoxFit.cover,height: 130,width: 130,)
                    ),
                ),
              ),
              SizedBox(height: 50,),
              FadeInUp(
                from: 60,
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 1000),
                child: Text("Send Money To", style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 10,),
              FadeInUp(
                from: 30,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: Text(
                  // 'Sample Money Transaction',
                  widget.name, 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
              SizedBox(height: 20,),
              FadeInUp(
                from: 40,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                    // controller: textEditingController,
                    controller: amount,
                    
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                    onSubmitted: (value) {
                      setState(() {
                        amount.text = "\₹" + value + ".00";
                        // textEditingController.text = "\₹" + value + ".00";
                      });
                    },
                    onTap: () {
                      setState(() {
                        if (amount.text == "0.00") {
                          amount.text = "";
                        } else {
                          amount.text = amount.text.replaceAll(RegExp(r'.00'), '');
                        }
                      });
                    },
                    inputFormatters: [
                      ThousandsFormatter()
                    ],
                    decoration: InputDecoration(
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // note textfield
              FadeInUp(
                from: 60,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isFocused ? Colors.indigo.shade400 : Colors.grey.shade200, width: 2),
                    // // boxShadow: 
                  ),
                  child: TextField(
                    maxLines: 3,
                    focusNode: _focusNode,
                    controller: _editingController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      hintText: "Message ...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FadeInUp(
                from: 60,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _feedbacks.length,
                    itemBuilder: (context, index) {
                      return FadeInRight(
                        from: 100,
                        delay: Duration(milliseconds: index * 500),
                        duration: Duration(milliseconds: 1000),
                        child: BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () {
                            _editingController.text = _feedbacks[index];
                            _focusNode.requestFocus();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200, width: 2),
                            ),
                            child: Center(
                              child: Text(_feedbacks[index], style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 50,),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Appcolor.secondary,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        setState(() {
                          amount.text.isEmpty ? _validate = true : _validate = false;
                        });
                        var totalAMount=int.parse(detamt)-int.parse(amount.text);

                        
                        Map <String,dynamic> data=
                          {
                            // "deptamt":totalAMount.toString(),
                            "totamt":totalAMount.toString(),
                          };

                          // print(data);
                          openCheckout().then((value) =>
                                                  FirebaseFirestore.instance.collection('payment').doc('payment_details').update(data).then((value) => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomePage()),
                              (route) => false) )

                    )
                        //update
                        // (
                        //   (data) 
                        //   {
                        //     log('successsQQ');
                        //   // print(data);
                        //   // print("Success!!");
                        
                        // }
                        // )
                        // (
                        //   {
                        //     'deptamt':'textEditingController.text',
                        //     // openCheckout().
                        //   }
                        // )
                        
                        .catchError((onError)
                        {
                          print('error');
                        }
                        );
                        log('processing');
                      },
                      // onPressed: () {
                      //   Navigator.of(context).pushReplacementNamed('/');
                      // },
                      minWidth: double.infinity,
                      height: 50,
                      child: Text("Send", style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
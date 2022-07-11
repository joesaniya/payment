
import 'package:flutter/material.dart';

import '../dialogs/exit_confirm.dart';

class DialogHelper {

  static exit(context) => showDialog(context: context, builder: (context) => ExitConfirmationDialog());
}
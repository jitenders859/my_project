import 'package:fluttertoast/fluttertoast.dart';

void toastWidget(msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
  );
}

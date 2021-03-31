import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String text, {
  gravity: ToastGravity.BOTTOM,
  toastLength: Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    fontSize: 16.0,
  );
}

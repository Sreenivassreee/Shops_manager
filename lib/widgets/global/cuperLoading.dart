import 'package:flutter/cupertino.dart';
import 'package:shops_manager/export.dart';

Widget cuperLoading() {
  return Center(
    child: Container(
      height: 100,
      width: 100,
      child: Card(
        elevation: 0.0,
        child: CupertinoActivityIndicator(),
      ),
    ),
  );
}

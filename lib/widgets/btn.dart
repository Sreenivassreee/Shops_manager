import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class btn extends StatelessWidget {
  @required
  final String? btnTitle;
  @required
  final VoidCallback? action;
  const btn({Key? key, this.action, this.btnTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: CupertinoButton(
          child: Text(btnTitle ?? " "),
          color: CupertinoColors.black,
          onPressed: action,
        ),
      ),
    );
    //   Container(
    //     height: 45,
    //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //     child: ElevatedButton(
    //       style: ElevatedButton.styleFrom(primary: Colors.black),
    //       child: Text(btnTitle ?? " "),
    //       onPressed: action,
    //     ),
    //   );
  }
}

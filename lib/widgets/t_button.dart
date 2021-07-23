import 'package:flutter/material.dart';

class tBtn extends StatelessWidget {
  @required
  final String? btnTitle;
  @required
  final VoidCallback? action;
  const tBtn({Key? key, this.action, this.btnTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: OutlinedButton(
        onPressed: () {},
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(btnTitle ?? ""),
      ),
    );
  }
}

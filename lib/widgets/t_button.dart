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
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 3,
              ),
            ),
          ),
        ),
        child: Text(
          btnTitle ?? " ",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: action,
      ),
    );
  }
}


// ButtonStyle(
//   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.zero,
//       borderSide: BorderSide(
//         color: Colors.black,
//         style: BorderStyle.solid,
//         width: 5,
//       ),
//     )
//   )

// ButtonStyle(
//   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//     RoundedRectangleBorder(
//       borderRadius: BorderRadius.zero,
//       side: BorderSide(color: Colors.red)
//     )
//   )
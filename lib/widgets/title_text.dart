import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String? title;

  const TitleText({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Text(
          title ?? " ",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

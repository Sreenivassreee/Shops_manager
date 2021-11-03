import 'package:shops_manager/export.dart';

PreferredSizeWidget app_bar({title, actionText}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    actions: [
      Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            actionText ?? " ",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      )
    ],
    title: TitleText(
      title: title ?? "",
    ),
  );
}

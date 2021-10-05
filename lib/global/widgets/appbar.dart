import 'package:shops_manager/export.dart';

PreferredSizeWidget app_bar({title, actionText}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          actionText ?? "",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
    title: TitleText(
      title: title ?? "",
    ),
  );
}

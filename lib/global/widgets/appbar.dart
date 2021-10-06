import 'package:shops_manager/export.dart';

PreferredSizeWidget app_bar({title, actionText}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    actions: [
      TitleText(
        title: actionText ?? "",
      ),
    ],
    title: TitleText(
      title: title ?? "",
    ),
  );
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_url_image_load_fail/flutter_url_image_load_fail.dart';
import 'package:shops_manager/globalcode/date.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    print(getDate());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: "https://cdn.dribbble.com/users/733202/screenshots/15793600/media/e5a416d19d4c015287dfcada0040e5fb.gif",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

      )

    );
  }
}

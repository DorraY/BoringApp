import 'package:flutter/cupertino.dart';

mixin MediaQueryUtil {

  Size screenSize(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.viewInsets.deflateSize(mediaQueryData.size);
  }

  Orientation screenOrientation(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.orientation;
  }
}
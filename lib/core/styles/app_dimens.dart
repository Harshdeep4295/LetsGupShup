import 'package:flutter_screenutil/flutter_screenutil.dart';

double width(num width) {
  return ScreenUtil().setWidth(width) * 1.3;
}

double height(num height) {
  return ScreenUtil().setHeight(height) * 1.3;
}

double fontValue(num fontSize, {bool? allowFontScalingSelf}) {
  return ScreenUtil().setSp(
    fontSize,
  );
}

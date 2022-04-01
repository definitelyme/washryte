import 'dart:math' as math;

import 'package:washryte/manager/locator/locator.dart';
import 'package:washryte/manager/router/export.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumX<T extends num> on T {
  num roundUp(int places) {
    var mod = math.pow(10.0, places).toDouble();
    return ((toDouble() * mod).round().toDouble() / mod);
  }

  num roundDown(int places) {
    final _isNegative = isNegative;
    final mod = math.pow(10.0, places);
    final roundDown = (((abs() * mod).floor()) / mod);
    return _isNegative ? -roundDown : roundDown;
  }

  bool isBtw(num from, num to) => from < this && to > this;

  bool get isInteger => this is int || this == roundToDouble();

  double get toMB => (this / 1e+6).roundToDouble();

  /// Multiple of screen width
  double get w => MediaQuery.of(getIt<AppRouter>().navigatorKey.currentContext!).size.width * this;

  /// Multiple of screen height
  double get h => MediaQuery.of(getIt<AppRouter>().navigatorKey.currentContext!).size.height * this;

  ///[ScreenUtil.radius]
  double get r => ScreenUtil().radius(this);

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this);

  /// Shortest screen-side width
  double get sw => MediaQuery.of(getIt<AppRouter>().navigatorKey.currentContext!).size.shortestSide * this;

  /// Longest screen-side height
  double get sh => MediaQuery.of(getIt<AppRouter>().navigatorKey.currentContext!).size.longestSide * this;
}

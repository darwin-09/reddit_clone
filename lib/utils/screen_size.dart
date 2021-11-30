import 'package:flutter/material.dart';

class ScreenSize {
  BuildContext context;

  // gets the context of the nearest widget
  ScreenSize(this.context);

  final kMobileMaxWidth = 550.0;
  final kTabletMaxWidth = 800.0;
  final kDesktopMaxWidth = 1080.0;
  final kLargeDesktopMaxWidth = 1440.0;

  double get height => MediaQuery.of(context).size.height;

  double get width => MediaQuery.of(context).size.width;

  bool get isMobileView => width < kMobileMaxWidth;

  bool get isTabletView =>
      isMobileView ? false : width < kTabletMaxWidth;

  bool get isDesktopView => !(isMobileView || isTabletView);

  bool get isDesktopMaxWidth => width >= kDesktopMaxWidth;

  bool get isLargeDesktopMaxWidth =>
      width >= kLargeDesktopMaxWidth;

  double get scrollWidth => 900;
}

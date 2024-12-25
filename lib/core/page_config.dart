import 'package:flutter/cupertino.dart';

class PageConfig {
  const PageConfig({
    required this.pageName,
    required this.child,
  });

  final String pageName;
  final Widget child;
}

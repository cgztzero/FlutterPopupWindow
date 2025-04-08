import 'package:flutter/cupertino.dart';

///function:PopupWindow基类
///@author:zhangteng
///@date:2025/4/8

abstract class PopupWindow {
  final BuildContext context;
  final Widget child;
  final double? width;
  final double? height;
  final double anchorY;
  final double? anchorWidgetHeight;
  final PopupWindowPosition position;
  final bool barrierDismissible;
  final Color? barrierColor;
  final Offset offset;
  final VoidCallback? onDismiss;
  final bool autoChange;

  const PopupWindow({
    required this.context,
    required this.child,
    this.width,
    this.height,
    this.anchorY = 0,
    this.anchorWidgetHeight = 0,
    this.barrierDismissible = true,
    this.position = PopupWindowPosition.bottom,
    this.barrierColor,
    this.offset = Offset.zero,
    this.onDismiss,
    this.autoChange = true,
  });

  void show();

  @mustCallSuper
  void dismiss() {
    onDismiss?.call();
  }
}

enum PopupWindowPosition { top, bottom }

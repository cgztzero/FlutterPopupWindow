import 'package:flutter/cupertino.dart';
import 'package:flutter_popupwindow/default_popup_window.dart';
import 'package:flutter_popupwindow/popup_window.dart';

///function:
///@author:zhangteng
///@date:2025/4/8

typedef CreatePopupWindow = PopupWindow Function({
  required BuildContext context,
  required Widget child,
  PopupWindowPosition position,
  double? width,
  double? height,
  bool barrierDismissible,
  Color? barrierColor,
  Offset offset,
  VoidCallback? onDismiss,
  bool autoChange,
});

// ignore: must_be_immutable
class PopupWindowWrapper extends StatelessWidget {
  final Widget child;
  final PopupWindowController? controller;
  final Widget windowContent;
  final double? windowWidth;
  final double? windowHeight;
  final PopupWindowPosition windowPosition;
  final bool windowBarrierDismissible;
  final Color? windowBarrierColor;
  final Offset windowOffset;
  final VoidCallback? onDismiss;
  final PopupWindow? popupWindow;
  final CreatePopupWindow? createPopupWindow;
  final bool autoChange;

  PopupWindowWrapper({
    super.key,
    required this.child,
    required this.windowContent,
    this.controller,
    this.windowWidth,
    this.windowHeight,
    this.windowPosition = PopupWindowPosition.bottom,
    this.windowBarrierDismissible = true,
    this.windowBarrierColor,
    this.windowOffset = Offset.zero,
    this.onDismiss,
    this.popupWindow,
    this.createPopupWindow,
    this.autoChange = true,
  });

  PopupWindowController? _defaultController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _updatePopWindow(context);
        _defaultController?.switchStatus();
      },
      child: child,
    );
  }

  void _updatePopWindow(BuildContext context) {
    _defaultController ??= controller ?? PopupWindowController();

    if (popupWindow != null) {
      _defaultController?.popupWindow = popupWindow;
    } else if (createPopupWindow != null) {
      _defaultController?.popupWindow = createPopupWindow?.call(
        context: context,
        child: child,
        position: windowPosition,
        width: windowWidth,
        height: windowHeight,
        barrierDismissible: windowBarrierDismissible,
        barrierColor: windowBarrierColor,
        offset: windowOffset,
        autoChange: autoChange,
        onDismiss: onDismiss,
      );
    } else {
      final renderObject = context.findRenderObject();
      if (renderObject == null) {
        return;
      }
      final renderBox = renderObject as RenderBox;
      if (!renderBox.hasSize) {
        return;
      }
      _defaultController?.popupWindow =
          _createDefaultPopupWindow(context, renderBox, _defaultController);
    }
  }

  PopupWindow _createDefaultPopupWindow(
    BuildContext context,
    RenderBox renderBox,
    PopupWindowController? tempController,
  ) {
    final Offset anchorOffset;

    final Offset bottomOffset = renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero));
    final Offset topOffset = renderBox.localToGlobal(Offset.zero);
    final double anchorWidgetHeight = bottomOffset.dy - topOffset.dy;
    if (windowPosition == PopupWindowPosition.bottom) {
      anchorOffset = bottomOffset;
    } else {
      anchorOffset = topOffset;
    }

    return DefaultPopupWindow(
      context: context,
      position: windowPosition,
      anchorY: anchorOffset.dy,
      anchorWidgetHeight: anchorWidgetHeight,
      offset: windowOffset,
      barrierColor: windowBarrierColor,
      height: windowHeight,
      width: windowWidth,
      barrierDismissible: windowBarrierDismissible,
      onDismiss: () {
        tempController?.isShow = false;
        onDismiss?.call();
      },
      autoChange: autoChange,
      child: windowContent,
    );
  }
}

class PopupWindowController {
  PopupWindow? popupWindow;
  bool isShow = false;

  void show() {
    if (isShow) {
      return;
    }
    popupWindow?.show();
    isShow = true;
  }

  void dismiss() {
    if (!isShow) {
      return;
    }
    popupWindow?.dismiss();
    isShow = false;
  }

  void switchStatus() {
    if (isShow) {
      dismiss();
    } else {
      show();
    }
  }
}

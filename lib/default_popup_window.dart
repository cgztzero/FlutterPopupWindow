import 'package:flutter/material.dart';
import 'package:flutter_popupwindow/default_popup_window_child_widget.dart';
import 'package:flutter_popupwindow/popup_window.dart';

///function:
///@author:zhangteng
///@date:2025/4/8

class DefaultPopupWindow extends PopupWindow {
  _PopupWindowOverlayRoute? _overlayRoute;

  DefaultPopupWindow({
    required super.context,
    required super.child,
    super.width,
    super.height,
    super.barrierDismissible = true,
    super.position = PopupWindowPosition.bottom,
    super.barrierColor,
    super.anchorY,
    super.anchorWidgetHeight,
    super.offset,
    super.onDismiss,
    super.autoChange,
  });

  @override
  void dismiss() {
    super.dismiss();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void show() {
    _overlayRoute = _PopupWindowOverlayRoute(
      isBarrierDismissible: barrierDismissible,
      onPop: () => onDismiss?.call(),
      builder: (BuildContext context) {
        return DefaultPopupWindowChildWidget(
          width: width,
          height: height,
          position: position,
          anchorY: anchorY,
          anchorWidgetHeight: anchorWidgetHeight,
          offset: offset,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          onBarrierTap: () {
            dismiss();
          },
          autoChange: autoChange,
          child: child,
        );
      },
    );
    Navigator.of(context).push(_overlayRoute!);
  }
}

class _PopupWindowOverlayRoute extends ModalRoute<void> {
  final WidgetBuilder builder;
  final VoidCallback? onPop;
  final bool isBarrierDismissible;

  _PopupWindowOverlayRoute({
    required this.builder,
    this.isBarrierDismissible = true,
    this.onPop,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 50);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isBarrierDismissible;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return WillPopScope(
      onWillPop: () async {
        if (isBarrierDismissible) {
          onPop?.call();
          return true;
        }
        return false;
      },
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

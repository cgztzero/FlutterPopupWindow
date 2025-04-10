import 'package:flutter/material.dart';
import 'package:flutter_popupwindow/popup_window.dart';

///function:
///@author:zhangteng
///@date:2025/4/8

class DefaultPopupWindowChildWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final PopupWindowPosition position;
  final double anchorY;
  final double? anchorWidgetHeight;
  final Color? barrierColor;
  final Widget child;
  final Offset offset;
  final bool barrierDismissible;
  final VoidCallback? onBarrierTap;
  final bool autoChange;

  const DefaultPopupWindowChildWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.position = PopupWindowPosition.bottom,
    this.anchorY = 0,
    this.anchorWidgetHeight,
    this.barrierColor,
    this.offset = Offset.zero,
    this.barrierDismissible = true,
    this.onBarrierTap,
    this.autoChange = true,
  });

  @override
  State<DefaultPopupWindowChildWidget> createState() => _DefaultPopupWindowChildWidgetState();
}

class _DefaultPopupWindowChildWidgetState extends State<DefaultPopupWindowChildWidget> {
  BuildContext? _context;
  bool _useOriginalDirection = true;

  @override
  void initState() {
    super.initState();
    if (widget.autoChange) {
      _autoChange();
    }
  }

  void _autoChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_context == null) {
        return;
      }
      final RenderBox renderBox = _context!.findRenderObject() as RenderBox;
      final Size size = renderBox.size;
      double childHeight = size.height;
      double screenHeight = _screenHeight();

      final lastStatus = _useOriginalDirection;
      if (widget.position == PopupWindowPosition.bottom) {
        if (widget.anchorY + widget.offset.dy + childHeight > screenHeight) {
          _useOriginalDirection = false;
        } else {
          _useOriginalDirection = true;
        }
      } else {
        if (widget.anchorY - widget.offset.dy - childHeight <= 0) {
          _useOriginalDirection = false;
        } else {
          _useOriginalDirection = true;
        }
      }
      if (_useOriginalDirection != lastStatus) {
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(covariant DefaultPopupWindowChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoChange) {
      _autoChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        verticalDirection: _getVerticalDirection(),
        children: [
          _getOffsetWidget(),
          Builder(
            builder: (context) {
              _context = context;
              return widget.child;
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.barrierDismissible) {
                  widget.onBarrierTap?.call();
                }
              },
              child: Container(
                width: double.infinity,
                color: widget.barrierColor ?? Colors.black38,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getOffsetWidget() {
    if (_useOriginalDirection) {
      if (widget.position == PopupWindowPosition.bottom) {
        return SizedBox(height: widget.anchorY + widget.offset.dy);
      } else {
        return SizedBox(height: _screenHeight() - widget.anchorY + widget.offset.dy);
      }
    } else {
      if (widget.position == PopupWindowPosition.bottom) {
        return SizedBox(
            height: _screenHeight() -
                widget.anchorY -
                -(widget.anchorWidgetHeight ?? 0) +
                widget.offset.dy);
      } else {
        return SizedBox(
            height: widget.anchorY + (widget.anchorWidgetHeight ?? 0) + widget.offset.dy);
      }
    }
  }

  VerticalDirection _getVerticalDirection() {
    if (_useOriginalDirection) {
      return widget.position == PopupWindowPosition.bottom
          ? VerticalDirection.down
          : VerticalDirection.up;
    } else {
      return widget.position == PopupWindowPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down;
    }
  }

  double _screenHeight() {
    return MediaQuery.of(context).size.height;
  }
}

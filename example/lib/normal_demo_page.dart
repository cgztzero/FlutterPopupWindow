import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popupwindow/default_popup_window.dart';
import 'package:flutter_popupwindow/popup_window.dart';

///function:PopupWindow basic function
///@author:zhangteng
///@date:2025/4/8

class NormalDemoPage extends StatefulWidget {
  const NormalDemoPage({super.key});

  @override
  State<NormalDemoPage> createState() => _NormalDemoPageState();
}

class _NormalDemoPageState extends State<NormalDemoPage> {
  PopupWindow? _aboveWindow;
  PopupWindow? _underWindow;
  final GlobalKey _aboveKey = GlobalKey();
  final GlobalKey _underKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('basic function')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: _aboveKey,
              child: const Text('show above the button'),
              onPressed: () => _showAboveWindow(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: _underKey,
              child: const Text('show under the button'),
              onPressed: () => _showUnderWindow(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboveWindow() {
    final renderBox = _aboveKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final offset = renderBox.localToGlobal(Offset.zero);
    _aboveWindow ??= DefaultPopupWindow(
      context: context,
      position: PopupWindowPosition.top,
      anchorY: offset.dy,
      offset: Offset.zero,
      barrierColor: Colors.yellow.withOpacity(0.5),
      child: GestureDetector(
        onTap: () => _aboveWindow?.dismiss(),
        child: Material(
          child: Container(
            color: Colors.red,
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'This is the PopupWindow Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
    _aboveWindow?.show();
  }

  void _showUnderWindow() {
    final renderBox = _underKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final offset = renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero));
    _underWindow ??= DefaultPopupWindow(
      context: context,
      position: PopupWindowPosition.bottom,
      anchorY: offset.dy,
      offset: const Offset(0, 15),
      barrierDismissible: false,
      onDismiss: () {
        debugPrint('popup window dismiss');
      },
      barrierColor: Colors.yellow.withOpacity(0.5),
      child: GestureDetector(
        onTap: () => _underWindow?.dismiss(),
        child: Material(
          child: Container(
            color: Colors.red,
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'This is the PopupWindow Content',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
    _underWindow?.show();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_popupwindow/popup_window.dart';
import 'package:flutter_popupwindow/popup_window_wrapper.dart';

///function:PopupWindow easy way
///@author:zhangteng
///@date:2025/4/8

class EasyDemoPage extends StatefulWidget {
  const EasyDemoPage({super.key});

  @override
  State<EasyDemoPage> createState() => _EasyDemoPageState();
}

class _EasyDemoPageState extends State<EasyDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('easy way')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupWindowWrapper(
              windowPosition: PopupWindowPosition.top,
              windowContent: Material(
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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: const Text('show above the button'),
              ),
            ),
            const SizedBox(height: 20),
            PopupWindowWrapper(
              controller: _controller,
              windowPosition: PopupWindowPosition.bottom,
              windowBarrierDismissible: false,
              windowContent: Material(
                child: GestureDetector(
                  onTap: () => _controller.switchStatus(),
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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: const Text('show under the button'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final PopupWindowController _controller = PopupWindowController();
}

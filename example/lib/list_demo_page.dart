import 'package:flutter/material.dart';
import 'package:flutter_popupwindow/popup_window_wrapper.dart';

///function:
///@author:zhangteng
///@date:2025/4/8

class ListDemoPage extends StatefulWidget {
  const ListDemoPage({super.key});

  @override
  State<ListDemoPage> createState() => _ListDemoPageState();
}

class _ListDemoPageState extends State<ListDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('list demo')),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (cxt, index) {
          return PopupWindowWrapper(
            windowContent: Material(
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: const Text(
                  'This is the PopupWindow Content',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'No.${index + 1}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

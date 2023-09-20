import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SavolPage extends StatefulWidget {
  SavolPage({Key? key}) : super(key: key);

  @override
  State<SavolPage> createState() => _SavolPageState();
}

class _SavolPageState extends State<SavolPage> {
  final List<int> data = [1, 2, 3, 4, 5];
  final List<String> taskData = [
    "TO DO",
    "IN PROGRESS",
    "TESTING",
    "RELEASE",
    "DISCUSSING"
  ];

  bool addButtonShowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO PLATFORM"),
      ),
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length + 1,
          itemBuilder: (context, i) {
            if (i == data.length) {
              return TextButton(onPressed: () {}, child: const Text("+"));
            }
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: double.infinity,
                width: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Text(taskData[i]);
                    } else {
                      return index == data.length
                          ? TextButton(onPressed: () {}, child: Text("+"))
                          : const Text("Hello");
                    }
                  },
                  itemCount: data.length + 1,
                ),
              ),
            );
          }),
    );
  }
}

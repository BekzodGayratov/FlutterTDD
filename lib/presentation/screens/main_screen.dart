import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController? _scrollController;
  double textHeight = 24.0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {
        if (textHeight > 24.0) {
          textHeight = 24.0;
        }
        if (_scrollController!.position.pixels > 13 &&
            _scrollController!.position.pixels <= 27) {
          textHeight = textHeight -= 0.5;
        } else if (_scrollController!.position.pixels < 1 &&
            _scrollController!.position.pixels >= -24.0) {
          textHeight = textHeight += 0.5;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://i.pinimg.com/originals/17/aa/40/17aa40cc5530dfb653e172cbe086f6ee.gif",
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              "Main Screen",
              style: TextStyle(fontSize: textHeight),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
            return const ListTile(
              title: Text("Hello"),
            );
          }))
        ],
      ),
    );
  }
}

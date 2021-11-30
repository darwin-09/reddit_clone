import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:reddit_clone/widgets/navbar.dart';

class HomePage extends HookWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMainAppBar(),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {

  final String title;
  final Widget contents;
  final List<Widget>? appBarActions;
  final FloatingActionButton? floatingActionButton;

  CustomScaffold({
    required this.title,
    required this.contents,
    this.appBarActions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(title),
        centerTitle: true,
        actions: appBarActions,
      ),
      body: SafeArea(
        child: contents,
      ),
    );
  }

}

import "package:flutter/material.dart";

class HWFScreen extends StatelessWidget {
  const HWFScreen({
    super.key,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
  });

  final AppBar appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return body;
  }
}

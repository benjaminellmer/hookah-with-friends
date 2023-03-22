import "package:flutter/material.dart";

class HookahWithFriendsApp extends StatelessWidget {
  const HookahWithFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hookah with friends",
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hookah with friends"),
          backgroundColor: Colors.black54,
        ),
        body: const Center(
          child: Text("Welcome to Hookah with friends"),
        ),
      ),
    );
  }
}

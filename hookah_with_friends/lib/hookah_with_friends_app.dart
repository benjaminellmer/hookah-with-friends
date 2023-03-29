import "package:flutter/material.dart";

import "util/hwf_screen.dart";
import "util/hwf_tab_navigation.dart";

class HookahWithFriendsApp extends StatelessWidget {
  const HookahWithFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hookah with friends",
      theme: ThemeData(),
      home: HWFTabNavigation(
        screens: <HWFScreen>[
          HWFScreen(
            appBar: AppBar(
              title: const Text("Sessions"),
            ),
            body: const Center(
              child: Text("Sessions"),
            ),
          ),
          HWFScreen(
            appBar: AppBar(
              title: const Text("Tobaccos"),
            ),
            body: const Center(
              child: Text("Tobaccos"),
            ),
          ),
          HWFScreen(
            appBar: AppBar(
              title: const Text("Profile"),
            ),
            body: const Center(
              child: Text("Profile"),
            ),
          ),
        ],
      ),
    );
  }
}

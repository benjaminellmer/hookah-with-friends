import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hookah_with_friends/util/colors.dart";

import "util/hwf_screen.dart";
import "util/hwf_tab_navigation.dart";

class HookahWithFriendsApp extends StatelessWidget {
  const HookahWithFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hookah with friends",
      theme: ThemeData(
        scaffoldBackgroundColor: HWFColors.background,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.poppins().fontFamily,
              bodyColor: Colors.white,
            ),
      ),
      home: HWFTabNavigation(
        screens: <HWFScreen>[
          HWFScreen(
            appBar: AppBar(
              title: const Text("Sessions"),
              backgroundColor: HWFColors.appbar,
            ),
            body: const Center(
              child: Text("Sessions"),
            ),
          ),
          HWFScreen(
            appBar: AppBar(
              title: const Text("Tobaccos"),
              backgroundColor: HWFColors.appbar,
            ),
            body: const Center(
              child: Text("Tobaccos"),
            ),
          ),
          HWFScreen(
            appBar: AppBar(
              title: const Text("Profile"),
              backgroundColor: HWFColors.appbar,
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

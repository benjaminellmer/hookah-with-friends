import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hookah_with_friends/util/colors.dart";

import "login_screen.dart";

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

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
      home: LoginScreen(),
    );
  }
}

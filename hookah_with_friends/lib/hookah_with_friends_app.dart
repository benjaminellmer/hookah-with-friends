import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";

import "bloc/auth/auth_bloc.dart";
import "components/texts/heading_text.dart";
import "screens/login_screen.dart";
import "screens/profile_screen.dart";
import "screens/sessions_screen.dart";
import "screens/tobaccos_screen.dart";
import "util/colors.dart";
import "util/hwf_screen.dart";
import "util/hwf_tab_navigation.dart";

class HookahWithFriendsApp extends StatelessWidget {
  const HookahWithFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hookah with friends",
        theme: ThemeData(
          scaffoldBackgroundColor: HWFColors.background,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: GoogleFonts.poppins().fontFamily,
                bodyColor: Colors.white,
              ),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: buildHomeScreen(state),
            );
          },
        ),
      ),
    );
  }

  Widget buildHomeScreen(final AuthState state) {
    if (state is AuthAuthenticated) {
      return HWFTabNavigation(
        screens: <HWFScreen>[
          HWFScreen(
              appBar: AppBar(
                title: HeadingText("Hookah with friends"),
                backgroundColor: HWFColors.appBar,
              ),
              body: const SessionsScreen()),
          HWFScreen(
            appBar: AppBar(
              title: HeadingText("Hookah with friends"),
              backgroundColor: HWFColors.appBar,
            ),
            body: const TobaccosScreen(),
          ),
          HWFScreen(
              appBar: AppBar(
                title: HeadingText("Hookah with friends"),
                backgroundColor: HWFColors.appBar,
              ),
              body: const ProfileScreen()),
        ],
      );
    } else {
      return LoginScreen();
    }
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

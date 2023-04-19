import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hookah_with_friends/screens/create_session_screen.dart";

import "bloc/auth/auth_bloc.dart";
import "components/texts/heading_text.dart";
import "screens/profile_screen.dart";
import "screens/sessions_screen.dart";
import "screens/tobaccos_screen.dart";
import "screens/welcome_screen.dart";
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
              child: buildHomeScreen(state, context),
            );
          },
        ),
      ),
    );
  }

  Widget buildHomeScreen(final AuthState state, final BuildContext context) {
    if (state is AuthAuthenticated) {
      return HWFTabNavigation(
        screens: <HWFScreen>[
          HWFScreen(
              appBar: AppBar(
                title: Center(child: HeadingText("Hookah with friends")),
                backgroundColor: HWFColors.appBar,
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: HWFColors.button,
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            CreateSessionScreen()),
                  );
                },
              ),
              body: const SessionsScreen()),
          HWFScreen(
            appBar: AppBar(
              title: Center(child: HeadingText("Hookah with friends")),
              backgroundColor: HWFColors.appBar,
            ),
            body: const TobaccosScreen(),
          ),
          HWFScreen(
              appBar: AppBar(
                title: Center(child: HeadingText("Hookah with friends")),
                backgroundColor: HWFColors.appBar,
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogout());
                    },
                    icon: const Icon(Icons.logout),
                    color: HWFColors.heading,
                  )
                ],
              ),
              body: const ProfileScreen()),
        ],
      );
    } else {
      return WelcomeScreen();
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

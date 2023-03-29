import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "bloc/navigation/navigation_cubit.dart";
import "util/colors.dart";

class HookahWithFriendsApp extends StatelessWidget {
  const HookahWithFriendsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hookah with friends",
      theme: ThemeData(scaffoldBackgroundColor: HWFColors.background),
      home: BlocProvider<NavigationCubit>(
        create: (BuildContext context) => NavigationCubit(),
        child: BlocBuilder<NavigationCubit, NavigationSelected>(
          builder: (BuildContext context, NavigationSelected state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Hookah with friends"),
                backgroundColor: HWFColors.appbar,
              ),
              body: Column(
                children: <Widget>[
                  const Center(child: Text("Welcome to Hookah with friends")),
                  Container(width: 100, height: 50, color: HWFColors.button)
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: "Sessions",
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: "Tobaccos",
                    icon: Icon(Icons.open_in_new_rounded),
                  ),
                  BottomNavigationBarItem(
                    label: "Profile",
                    icon: Icon(Icons.open_in_new_rounded),
                  ),
                ],
                currentIndex: state.selectedIndex,
                onTap: (int index) {
                  context.read<NavigationCubit>().select(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

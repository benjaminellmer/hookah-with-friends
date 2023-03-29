import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/navigation/navigation_cubit.dart";
import "colors.dart";
import "hwf_screen.dart";

class HWFTabNavigation extends StatelessWidget {
  const HWFTabNavigation({super.key, required this.screens});

  final List<HWFScreen> screens;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (BuildContext context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationSelected>(
        builder: (BuildContext context, NavigationSelected state) {
          return Scaffold(
            body: screens[state.selectedIndex].body,
            appBar: screens[state.selectedIndex].appBar,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: HWFColors.appbar,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "Sessions",
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: "Tabaccos",
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
    );
  }
}
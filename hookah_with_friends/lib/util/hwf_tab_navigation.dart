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
            floatingActionButton:
                screens[state.selectedIndex].floatingActionButton,
            bottomNavigationBar: SizedBox(
              height: 85,
              child: Row(
                children: <Widget>[
                  _HWFTab(
                    label: "Sessions",
                    imagePath: "lib/assets/hookah_white.png",
                    isSelected: state.selectedIndex == 0,
                    index: 0,
                  ),
                  _HWFTab(
                    isSelected: state.selectedIndex == 1,
                    label: "Tobaccos",
                    imagePath: "lib/assets/tobacco.png",
                    index: 1,
                  ),
                  _HWFTab(
                    label: "Profile",
                    imagePath: "lib/assets/profile_white.png",
                    isSelected: state.selectedIndex == 2,
                    index: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HWFTab extends StatelessWidget {
  const _HWFTab(
      {required this.isSelected,
      required this.index,
      required this.imagePath,
      required this.label});

  final bool isSelected;
  final int index;
  final String imagePath;
  final String label;

  Color get backgroundColor {
    return isSelected ? HWFColors.appBarSelected : HWFColors.appBar;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: () {
            context.read<NavigationCubit>().select(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imagePath,
                  width: 25, height: 25, color: HWFColors.heading),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: HWFColors.heading),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

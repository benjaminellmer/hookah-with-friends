import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/profile/profile_cubit.dart";
import "../components/cards/profile_info_card.dart";
import "../components/cards/user_card.dart";
import "friends_screen.dart";
import "invites_screen.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit()..loadUser(),
      child: Builder(builder: (BuildContext context) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProfileCubit>().loadUser();
          },
          child: Center(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (BuildContext context, ProfileState state) {
                    if (state is ProfileLoaded) {
                      return ListView(
                        children: <Widget>[
                          const UserCard(),
                          const SizedBox(height: 30),
                          ProfileInfoCard(
                            info:
                                "Friends (${state.currentUser.friends.length})",
                            route: const FriendsScreen(),
                          ),
                          ProfileInfoCard(
                            info: "Invites (${state.numberOfInvitations})",
                            route: const InvitesScreen(),
                          ),
                          // const ProfileInfoCard(
                          //   info: "Sessions",
                          //   route: HistoryScreen(),
                          // ),
                          // const ProfileInfoCard(
                          //   info: "Settings",
                          //   route: SettingsScreen(),
                          // ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

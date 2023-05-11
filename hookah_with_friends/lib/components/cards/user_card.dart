import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../../services/user_service.dart";
import "../../util/colors.dart";
import "../../util/locator.dart";
import "../../util/testdata/testdata.dart";

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        SizedBox(
          height: 80,
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: HWFColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Center(
                    child: Transform.scale(
                      scale: 0.5,
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          "lib/assets/profile_white.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getIt.get<UserService>().currentUser?.userName ??
                          "Unknown",
                      style: TextStyle(
                        color: HWFColors.heading,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '"${TestData.activeUser.motto}"',
                      style: TextStyle(
                        color: HWFColors.heading,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

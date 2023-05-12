import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

import "../components/appbars/back_and_title_app_bar.dart";
import "../components/cards/primary_card.dart";
import "../components/cards/profile_info_card.dart";
import "../components/texts/primary_text.dart";
import "../services/image_service.dart";
import "../util/colors.dart";
import "change_password_screen.dart";
import "change_username_screen.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAndTitleAppBar(title: "Settings"),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const ProfileInfoCard(
                info: "Change Username",
                route: ChangeUsernameScreen(),
              ),
              const ProfileInfoCard(
                info: "Reset Password",
                route: ChangePasswordScreen(),
              ),
              PrimaryCard(
                child: Row(
                  children: <Widget>[
                    PrimaryText("Change Profile Picture", fontSize: 16),
                    const Spacer(),
                    PrimaryText(">", fontSize: 20)
                  ],
                ),
                onTap: () {
                  pickImage(context);
                },
              ),
            ],
          )),
    );
  }

  void pickImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: HWFColors.cardBackground,
            content: SizedBox(
              height: 200,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PrimaryText("Select image source:", fontSize: 22,),
                  const SizedBox(height: 30,),
                  ListTile(
                    onTap: () {
                      ImageService().pickCameraImage(context);
                      Navigator.pop(context);

                    },
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera, color: HWFColors.text, size: 30,),
                          const SizedBox(width: 8), // Adjust the spacing between the icon and the title
                          PrimaryText("Camera", fontSize: 20),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      ImageService().pickGalleryImage(context);
                    },
                    title: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.image, color: HWFColors.text, size: 30,),
                          const SizedBox(width: 8), // Adjust the spacing between the icon and the title
                          PrimaryText("Gallery", fontSize: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

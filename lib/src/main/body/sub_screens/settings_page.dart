import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stario/src/core/auth/authentication_page.dart';
import 'package:stario/src/core/auth/login/login_page.dart';
import 'package:stario/src/main/song_bottom_sheet.dart';
import 'package:stario/src/route_transitions/route_transitions.dart';
import 'package:stario/src/shared_prefs/shared_prefs.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSettingsTileButton(
              text: 'Privacy',
              icon: Icons.lock_outline_rounded,
              nextScreen: Scaffold(),
            ),
            ProfileSettingsTileButton(
              text: 'Manage Account',
              icon: Icons.person_outline_outlined,
              nextScreen: Scaffold(),
            ),
            ProfileSettingsTileButton(
              text: 'Notifications',
              icon: Icons.notifications_none_outlined,
              nextScreen: Scaffold(),
            ),
            ProfileSettingsTileButton(
              text: 'Saved',
              icon: Icons.bookmark_border_rounded,
              nextScreen: Scaffold(),
            ),
            ProfileSettingsTileButton(
              text: 'Help',
              icon: Icons.help_outline,
              nextScreen: Scaffold(),
            ),
            ProfileSettingsTileButton(
              text: 'About',
              icon: Icons.info_outline_rounded,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationVersion: '0.0.1',
                  applicationName: 'stario App',
                );
              },
            ),
            Spacer(),
            ProfileSettingsTileButton(
              text: 'Log Out',
              textStyle: TextStyle(color: Colors.red),
              icon: Icons.logout,
              iconColor: Colors.red,
              onTap: () async {
                //removes the username from shared prefs onces logged out
                SharedPrefs.instance.removeUsername();

                //TODO: stop playing audio when exit

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticationPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSettingsTileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget nextScreen;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color iconColor;

  ProfileSettingsTileButton(
      {this.text, this.icon, this.nextScreen, this.onTap, this.textStyle, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: nextScreen != null
          ? () {
              Scaffold.of(context).openDrawer();
              Navigator.push(
                  context,
                  RouteTransitions().slideRightToLeftTransitionType(
                    nextScreen,
                  ));
            }
          : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

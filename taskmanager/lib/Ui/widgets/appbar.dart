import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/controller/auth_controller.dart';
import 'package:taskmanager/Ui/screens/login.dart';
import 'package:taskmanager/Ui/screens/profile_update_screen.dart';

class TmAppbar extends StatefulWidget implements PreferredSizeWidget {
  const TmAppbar({super.key, this.fromUpdateProfile});

  final bool? fromUpdateProfile;

  @override
  State<TmAppbar> createState() => _TmAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TmAppbarState extends State<TmAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        spacing: 8,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.fromUpdateProfile ?? false) {
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileUpdateScreen()),
              );
            },
            child: CircleAvatar(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userModel?.fullName ?? '',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),

              Text(
                AuthController.userModel?.email ?? '',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
      actions: [IconButton(onPressed: _signout, icon: Icon(Icons.logout))],
    );
  }

  Future<void> _signout() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (predicate) => false,
    );
  }
}

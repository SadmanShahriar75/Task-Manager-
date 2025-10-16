import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/screens/canselled_screen.dart';
import 'package:taskmanager/Ui/screens/complected_screen.dart';
import 'package:taskmanager/Ui/screens/new_task_screen.dart';

import 'package:taskmanager/Ui/screens/progress.dart';
import 'package:taskmanager/Ui/widgets/appbar.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  static const String name = '/dashboard';

  @override
  State<MainNavBarHolderScreen> createState() => _BottomNavState();
}

class _BottomNavState extends State<MainNavBarHolderScreen> {
  int _selected = 0;

  final List<Widget> _sreens = [
    NewTaskScreen(),
    ProgressScreen(),
    CanselledScreen(),
    ComplectedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),

      body: _sreens[_selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selected,
        onDestinationSelected: (int index) {
          _selected = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: "new",
          ),
          NavigationDestination(
            icon: Icon(Icons.refresh_sharp),
            label: "Progress",
          ),
          NavigationDestination(icon: Icon(Icons.close), label: "Canselled"),
          NavigationDestination(icon: Icon(Icons.done), label: "Complected"),
        ],
      ),
    );
  }
}

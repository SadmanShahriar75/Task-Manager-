import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/widgets/taskcard.dart';

class CanselledScreen extends StatelessWidget {
  const CanselledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 0,
        itemBuilder: (context, index) {
          List _newTaskList = [];
          return TaskCard(taskModel: _newTaskList[index], refreshParent: () {});
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }
}

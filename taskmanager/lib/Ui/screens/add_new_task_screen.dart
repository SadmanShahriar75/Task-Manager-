import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/widgets/appbar.dart';
import 'package:taskmanager/Ui/widgets/progress_indicator.dart';
import 'package:taskmanager/Ui/widgets/screen_background.dart';
import 'package:taskmanager/Ui/widgets/snack_bar.dart';
import 'package:taskmanager/data/service/api_caller.dart';
import 'package:taskmanager/data/utils/base_url.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool addnewtaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TmAppbar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Add new task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if ((value?.trim().isEmpty ?? true)) {
                        return 'Enter your title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if ((value?.trim().isEmpty ?? true)) {
                        return 'Enter your describtion';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: addnewtaskInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTabAddButton,
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabAddButton() {
    if (_formKey.currentState!.validate()) {
      addNewTask();
    }
  }

  Future<void> addNewTask() async {
    addnewtaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestbody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestbody,
    );

    if (response.isSuccess) {
      clearTask();
      showSnackBarMessage(context, "task added succesfully");
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    addnewtaskInProgress = false;
    setState(() {});
  }

  void clearTask() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}

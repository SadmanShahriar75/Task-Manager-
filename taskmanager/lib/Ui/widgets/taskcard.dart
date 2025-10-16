import 'package:flutter/material.dart';
import 'package:taskmanager/Ui/widgets/snack_bar.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/service/api_caller.dart';
import 'package:taskmanager/data/utils/base_url.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.refreshParent,
  });

  final TaskModel taskModel;
  final VoidCallback refreshParent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;
  bool _deleteinprogress = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(widget.taskModel.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(widget.taskModel.description),
          Text(
            'Date: ${widget.taskModel.createdDate}',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Row(
            children: [
              Chip(
                backgroundColor: Colors.blue,
                label: Text(widget.taskModel.status),
                labelStyle: TextStyle(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Spacer(),
              Visibility(
                visible: _deleteinprogress == false,
                replacement: CircularProgressIndicator(),
                child: IconButton(
                  onPressed: () {
                    print("delete.....");
                    // delete....
                    _deletetaskFun();
                  },
                  icon: Icon(Icons.delete, color: Colors.grey),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _changeStatus('New');
                },
                title: Text('New'),
                trailing: widget.taskModel.status == 'New'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Progress');
                },
                title: Text('Progress'),
                trailing: widget.taskModel.status == 'Progress'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Cancelled');
                },
                title: Text('Cancelled'),
                trailing: widget.taskModel.status == 'Cancelled'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Completed');
                },
                title: Text('Completed'),
                trailing: widget.taskModel.status == 'Completed'
                    ? Icon(Icons.done)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  /// update
  Future<void> _changeStatus(String status) async {
    if (status == widget.taskModel.status) {
      return;
    }

    Navigator.pop(context);

    _changeStatusInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );
    _changeStatusInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      widget.refreshParent();
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  ///  delete api...
  Future<void> _deletetaskFun() async {
    _deleteinprogress = true;
    setState(() {});

    ApiResponse response = await ApiCaller.getRequest(
      url: Urls.deletestatusUrl(widget.taskModel.id),
    );

    if (response.isSuccess) {
      widget.refreshParent();
    }

    _deleteinprogress = false;
    setState(() {});
  }
}

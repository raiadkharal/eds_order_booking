import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Dialog Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showProgressDialog(context),
          child: const Text('Show Progress Dialog'),
        ),
      ),
    );
  }

  Future<void> _showProgressDialog(BuildContext context) async {
    final int totalTasks = 5;
    final ProgressDialog progressDialog =
        ProgressDialog(totalTasks: totalTasks);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return progressDialog;
      },
    );

    for (int i = 0; i < totalTasks; i++) {
      await Future.delayed(const Duration(seconds: 1)); // Simulate a task
      progressDialog.createState().updateProgress('Task ${i + 1}', i + 1);
    }

    Navigator.of(context).pop(); // Close the dialog when all tasks are done
  }
}

class ProgressDialog extends StatefulWidget {
  final int totalTasks;

  const ProgressDialog({Key? key, required this.totalTasks}) : super(key: key);

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  final RxInt _completedTasks = 0.obs;
  final RxString _currentTask = "".obs;

  void updateProgress(String currentTask, int completedTasks) {
    _currentTask(currentTask);
    _completedTasks(completedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Progress"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Text("Current Task: $_currentTask"),
              ),
              SizedBox(height: 10),
              Obx(
                () => LinearProgressIndicator(
                  value: widget.totalTasks > 0
                      ? _completedTasks / widget.totalTasks
                      : 0,
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () =>
                    Text("Completed: $_completedTasks / ${widget.totalTasks}"),
              ),
            ],
          ),
        );
      },
    );
  }
}

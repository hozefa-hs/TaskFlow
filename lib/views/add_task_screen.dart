import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../view_models/task_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final Task? task;

  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        backgroundColor: CupertinoColors.systemBlue,
        title: Text(
          widget.task == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                filled: true,
                fillColor: Colors.grey[200],
                // Light background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded edges
                  borderSide: BorderSide.none, // Remove default border
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Task Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                hintText: 'Enter task description',
                filled: true,
                fillColor: Colors.grey[200],
                // Light background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded edges
                  borderSide: BorderSide.none, // Remove default border
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Make button full width
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final desc = _descController.text.trim();

                  if (title.isEmpty || desc.isEmpty) return;

                  final newTask = Task(
                    id: widget.task?.id,
                    title: title,
                    description: desc,
                    isCompleted: widget.task?.isCompleted ?? false,
                    createdAt: DateTime.now().toString(),
                  );

                  if (widget.task == null) {
                    ref.read(taskProvider.notifier).addTask(newTask);
                  } else {
                    ref.read(taskProvider.notifier).updateTask(newTask);
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.task == null ? 'Add Task' : 'Update Task',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

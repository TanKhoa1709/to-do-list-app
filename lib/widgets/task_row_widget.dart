import 'package:flutter/material.dart';

import 'check_box_widget.dart';

class TaskRow extends StatefulWidget {
  const TaskRow({super.key, required this.taskName});

  final String taskName;

  @override
  State<TaskRow> createState() => _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.inversePrimary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyCheckbox(),
          Text(
            widget.taskName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

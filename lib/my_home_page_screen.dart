import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tasks = ['Task 1', 'Task 2', 'Task 3'];
  List<bool> taskIsChecked = [false, false, false];
  int countTaskCheckedVar = 0;

  void countTaskChecked() {
    int count = 0;
    for (var element in taskIsChecked) {
      if (element == true) {
        ++count;
      }
    }
    countTaskCheckedVar = count;
  }

  void addTask() {
    setState(() {
      tasks.add('Empty Task');
      taskIsChecked.add(false);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void editTask(int index) {
    TextEditingController textEditingController =
        TextEditingController(text: tasks[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa nội dung'),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(hintText: 'Nhập nội dung mới'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index] = textEditingController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void pushTaskUp(int index) {
    setState(() {
      String tmp = tasks[index - 1];
      tasks[index - 1] = tasks[index];
      tasks[index] = tmp;
    });
  }

  void pushTaskDown(int index) {
    setState(() {
      String tmp = tasks[index + 1];
      tasks[index + 1] = tasks[index];
      tasks[index] = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Text(
            '$countTaskCheckedVar/${taskIsChecked.length}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Theme.of(context).colorScheme.inversePrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              leading: Checkbox(
                checkColor: Colors.white,
                value: taskIsChecked[index],
                onChanged: (bool? value) {
                  setState(() {
                    taskIsChecked[index] = value!;
                    countTaskChecked();
                  });
                },
              ),
              title: TextButton(
                onPressed: () => editTask(index),
                child: Text(
                  tasks[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => pushTaskUp(index),
                    icon: const Icon(Icons.arrow_upward),
                  ),
                  IconButton(
                    onPressed: () => pushTaskDown(index),
                    icon: const Icon(Icons.arrow_downward),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteTask(index),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

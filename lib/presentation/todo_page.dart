import 'package:flutter/material.dart';
import 'package:tdd/domain/model/task_model.dart';
import 'package:tdd/domain/sqldb/sql_db_helper.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _pathController = TextEditingController();

  final TextEditingController _isFinishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: _pathController,
                  decoration: const InputDecoration(hintText: "Path"),
                ),
                TextField(
                  controller: _isFinishController,
                  decoration: const InputDecoration(hintText: "isFinish"),
                )
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: SqlDBHelper().getAllData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else {
                      var data = snapshot.data as List<TaskModel>;
                      return data.isEmpty
                          ? Center(
                              child: Text('DATA NOT FOUND'),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(data[index].title.toString()),
                                  subtitle: Text(data[index].path.toString()),
                                  trailing:
                                      Text(data[index].isFinish.toString()),
                                );
                              },
                              itemCount: data.length,
                            );
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await SqlDBHelper().insertData(TaskModel(
                title: _titleController.text,
                path: _isFinishController.text,
                isFinish: int.parse(_isFinishController.text)));
          },
          label: const Text("Saqlash")),
    );
  }
}

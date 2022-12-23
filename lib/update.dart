import 'package:flutter/material.dart';
import 'package:folong201todo/Home.dart';
import 'package:folong201todo/de_handler.dart';
import 'package:get/get.dart';
import 'model.dart';

class addTask extends StatefulWidget {
  bool? update;
  int? todId;
  String? toTitle;
  String? todDescription;
  addTask({this.todId, this.toTitle, this.todDescription, this.update});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  DBHelper? dbHelper;
  late Future<List<Todo>> todoList;
  late String? option;
  var title;
  var description;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    setState(() {
      option = "add";
    });
    loadData();
  }

  loadData() async {
    todoList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    String appBarTitle; // = widget.update ? "Update" : "add";

    if (widget.update == true) {
      appBarTitle = "Update";
      titleController = TextEditingController(text: widget.toTitle);
      descriptionController =
          TextEditingController(text: widget.todDescription);
    } else {
      appBarTitle = "Add";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle.toString()),
        centerTitle: true,
        elevation: 0,
        actions: [Icon(Icons.help_outline_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Entrer un titre",
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "veiller entre un titre";
                        }
                        setState(() {
                          title = value;
                        });
                        return null;
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: descriptionController,
                      maxLines: null,
                      minLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Entrer une description",
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "veiller entre une description";
                        }
                        setState(() {
                          description = value;
                        });
                        return null;
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: Get.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print("saved button");

                              if (_formKey.currentState!.validate()) {
                                print(widget.update);
                                if (widget.update == true) {
                                  dbHelper?.update(Todo(
                                      title: titleController.text,
                                      description: description,
                                      id: widget.todId));
                                  print("data updated");
                                  titleController.clear();
                                  descriptionController.clear();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                                } else {
                                  dbHelper?.insert(Todo(
                                      title: title, description: description));
                                  print("data added");
                                  titleController.clear();
                                  descriptionController.clear();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));

                                  // Get.toNamed('/home');
                                }
                              }
                            },
                            child: Text('Save'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              titleController.clear();
                              descriptionController.clear();
                              print("data cleared");
                            },
                            child: Text('clear'),
                          ),
                        ]),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}

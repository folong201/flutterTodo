import 'package:flutter/material.dart';
import 'package:folong201todo/de_handler.dart';
import 'package:folong201todo/model.dart';
import 'package:folong201todo/update.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBHelper? dbHelper;
  late Future<List<Todo>> todoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    todoList = dbHelper!.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        title: Text("Folong201 Todo"),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 8),
            child: GestureDetector(
              child: Icon(Icons.help_outline_outlined),
              onTap: () {
                print("you cliked on the info");
                Get.toNamed('/info');
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return InfoPage();
                // }));
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: todoList,
            builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text("null data or not"),
                );
              } else if (snapshot.data!.length == 0) {
                return Center(
                  child: Text('ENpty  length =0'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      int todId = snapshot.data![index].id!.toInt();
                      String todtitle = snapshot.data![index].title.toString();
                      String toddescription =
                          snapshot.data![index].description.toString();
                      return Dismissible(
                        key: ValueKey<int>(todId),
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                autofocus: mounted,
                                title: Text(
                                  todtitle,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                subtitle: Text(toddescription,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                              ),
                              Container(
                                color: Colors.black,
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            print("delteing direcction");
                            Get.snackbar('Ok', "Task Delete with success");
                            setState(() {
                              dbHelper!.delete(todId);
                              todoList = dbHelper!.getDataList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          } else {
                            print("updatint direcction");

                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return addTask(
                                  update: true,
                                  todId: todId,
                                  toTitle: todtitle,
                                  todDescription: toddescription,
                                );
                              }));
                              todoList = dbHelper!.getDataList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          }
                        },
                      );
                    });
              }
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addTask(update: false);
          }));

          // Get.toNamed('/edit');
        },
        child: Icon(Icons.add),
        tooltip: 'add Task',
      ),
    );
  }
}

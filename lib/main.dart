import 'package:flutter/material.dart';
import 'package:folong201todo/Home.dart';
import 'package:folong201todo/info.dart';
import 'package:folong201todo/update.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: '/info',
            page: () {
              return InfoPage();
            }),
        GetPage(
          name: '/edit',
          page: () {
            return addTask(
              update: false,
            );
          },
        ),GetPage(name: '/home', page: () => Home(),)
      ],
      debugShowCheckedModeBanner: false,
      title: 'Folong201 Todo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(),
    );
  }
}

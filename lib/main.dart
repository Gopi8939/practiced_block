import 'package:block_test/features/home/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String title = "Flutter Home Page";
  // int count = 0;
  // // updateTitleMethod() {
  // //   setState(() {
  // //     count++;
  // //     title = "New Flutter Home page $count";
  // //   });
  // // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Home(),
      // home: MyHomePage(
      //   title: title,
      //   onPressed: updateTitleMethod,
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:render_object/render_object/home_view.dart';
import 'package:render_object/test_demo/view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double? dollar;

  @override
  void initState() {
    super.initState();

    dollar = ViewModel().convertToDollar(1200);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(), //Text
    );
  }
}

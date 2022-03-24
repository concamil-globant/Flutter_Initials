import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_pages.dart';
import 'package:newsapp/src/theme/my_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Material App',
      theme: myTheme,
      home: const TabsScreen(),
    );
  }
}

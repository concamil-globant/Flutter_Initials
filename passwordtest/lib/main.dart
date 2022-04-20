import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:passwordtest/tropicalization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  Scaffold(
            appBar:  AppBar(
              title: const Text("Flutter Pw Validator"),
            ),
            body:  AppHome()));
  }
}

class AppHome extends StatelessWidget {
  final TextEditingController controller =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.5),
        child: Column(
          children: [
            const Flexible(flex: 5, child:  FlutterLogo(size: 200)),
            Flexible(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: TextField(
                        controller: controller,
                        decoration:  const InputDecoration(
                            hintText: "Password",
                            border:  OutlineInputBorder(
                                borderSide: BorderSide()))),
                  ),
                  FlutterPwValidator(
                    strings: Tropicalization(),
                    controller: controller,
                    minLength: 8,
                    uppercaseCharCount: 2,
                    numericCharCount: 3,
                    specialCharCount: 1,
                    normalCharCount: 3,
                    width: 400,
                    height: 150,
                    onSuccess: () {
                      print("MATCHED");
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          content:  Text("Password is matched")));
                    },
                    onFail: () {
                      print("NOT MATCHED");
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ]);
  }
}

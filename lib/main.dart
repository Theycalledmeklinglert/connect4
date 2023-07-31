import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nao_connect_4/core/bindings/main_bindings.dart';
import 'package:nao_connect_4/screens/game_screen/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBindings(),
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => GameScreen()),
      ],
    );
  }
}


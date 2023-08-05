import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udp_socket_chat/home/view.dart';
import 'package:udp_socket_chat/login/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Liberty Net - the first beta?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
    );
  }
}

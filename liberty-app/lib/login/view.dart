import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Image.asset('assets/chat_logo.png'),
                ),
                Row(
                  children: const [
                    Text(
                      'Liberty Net - Beta',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.chat,
                      color: Colors.grey,
                    )
                  ],
                ),
                TextField(
                  controller: logic.destinationIpController,
                  decoration: const InputDecoration(
                      label: Text('Destination IP Address')),
                ),
                TextField(
                  controller: logic.portController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Port Number')),
                ),
                TextField(
                  controller: logic.usernameController,
                  decoration: const InputDecoration(
                      label: Text('Username')),
                ).paddingOnly(bottom: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/home', arguments: {
                      'ip': logic.destinationIpController.text,
                      'port': logic.portController.text,
                      'username':logic.usernameController.text
                    });
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

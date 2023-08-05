import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udp_socket_chat/models/Message.dart';

class HomeLogic extends GetxController {
  var username = Get.arguments['username'];
  var ip = Get.arguments['ip'];
  var port = Get.arguments['port'];
  var newMessage = TextEditingController();
  var messages = <Message>[].obs;
  RawDatagramSocket? socket ;

  @override
  void onReady() {
    receiveMessage(1234);
  }

  void sendMessage(String ip, int port, String message) {
    try {
      List<int> data = utf8.encode('$username,$message');
      socket?.send(data, InternetAddress(ip), port);
    }catch(exception){
      debugPrint(exception.toString());
    }
  }

  Future<void> receiveMessage(int port) async {
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    await socket?.forEach((event) {
        if(event == RawSocketEvent.read){
          Datagram? datagram = socket?.receive();
          var data = datagram?.data;
          var user = utf8.decode(data!).split(',')[0];
          var mess = utf8.decode(data).split(',')[1];
          messages.add(Message(userName: user, message: mess));
        }
    });
  }


  
}

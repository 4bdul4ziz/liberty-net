import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/Message.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${logic.username}'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: logic.messages.length,
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection:
                            logic.messages[index].userName == logic.username
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                logic.messages[index].userName,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(.6),
                                border:
                                    Border.all(color: Colors.amber, width: 1),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      logic.messages[index].userName ==
                                              logic.username
                                          ? 20
                                          : 0),
                                  topRight: Radius.circular(
                                      logic.messages[index].userName ==
                                              logic.username
                                          ? 0
                                          : 20),
                                  bottomLeft: const Radius.circular(20),
                                  bottomRight: const Radius.circular(20),
                                ),
                              ),
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  logic.messages[index].message,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 5),
                      );
                    });
              }),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: logic.newMessage,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none),
                  ).paddingSymmetric(horizontal: 10)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.grey,
                        size: 30,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                        onPressed: () {
                          logic.sendMessage(logic.ip, int.parse(logic.port),
                              logic.newMessage.text);
                          logic.messages.add(Message(
                            userName: logic.username,
                            message: logic.newMessage.text,
                          ));
                          logic.newMessage.text = '';
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 30,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

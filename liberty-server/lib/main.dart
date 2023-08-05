import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liberty Net',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Liberty Net - Server'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var portController = TextEditingController();
  //Uint8List? data;
  RawDatagramSocket? udpSocket;
  List<String> receivedMessages = <String>[];

  Future<void> listenForUdpPackets(int port) async {
    try {
      // udp socket bind it to the specified port
      udpSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);

      // incoming packets
      await udpSocket?.forEach((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          // read the incoming packet
          Datagram? dg = udpSocket?.receive();
          var message = dg?.data;
          setState(() {
            if (message != null) {
              // data = message;
              receivedMessages.add(utf8.decode(message));
            }
          });
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: Text(
                    'Listening Port ',
                    style: TextStyle(
                        backgroundColor: Colors.lightGreen, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: portController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: '1234',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        )),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          listenForUdpPackets(int.parse(portController.text));
                          setState(() {
                            /* data = utf8.encode(
                                    'Socket is listening to port ${portController.text} ')
                                as Uint8List?;*/
                            receivedMessages.add(
                                'Socket is listening to port ${portController.text} \nWaiting for incoming messages.. ');
                          });
                        },
                        child: const Text('Start Binding'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (udpSocket != null) {
                            udpSocket?.close();
                            setState(() {
                              /*data =
                                  utf8.encode('Socket Closed !') as Uint8List?;*/
                              receivedMessages.add('Socket Closed !');
                            });
                          }
                        },
                        child: const Text('Close Socket'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (udpSocket != null) {
                            udpSocket?.close();
                            setState(() {
                              receivedMessages = [];
                            });
                          }
                        },
                        child: const Text('Clear The List'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 300,
              child: ListView.separated(
                itemBuilder: (context, index){
                  return Text(receivedMessages[index]);
                },
                separatorBuilder: (context, sepIndex){
                  return const Divider();
                },
                itemCount: receivedMessages.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

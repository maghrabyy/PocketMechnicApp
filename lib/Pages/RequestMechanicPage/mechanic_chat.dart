import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class MechanicChat extends StatefulWidget {
  const MechanicChat({Key? key}) : super(key: key);

  @override
  State<MechanicChat> createState() => _MechanicChatState();
}

class _MechanicChatState extends State<MechanicChat> {
  List<Widget> chatBubbles = [];
  TextEditingController textMessage = TextEditingController();
  Widget sendButtons = Container();
  Widget defaultSendButtons = Row(
    children: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.camera_alt,
            size: 35,
          )),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.mic,
            size: 35,
          ))
    ],
  );

  sendClientMessage(String chatMsg) {
    chatBubbles.add(Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: RoundedContainer(
                  boxColor: Colors.blue,
                  boxChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(chatMsg),
                  )),
            ),
            const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 32,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 52.0),
          child: Text('${_auth.currentUser!.displayName}'),
        ),
      ],
    ));
  }

  sendMechanicMessage(String chatMsg) {
    chatBubbles.add(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(
                Icons.person,
                size: 32,
              ),
            ),
            Expanded(
              child: RoundedContainer(
                  boxColor: Colors.deepPurple,
                  boxChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(chatMsg),
                  )),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 52.0),
          child: Text('Mechanic'),
        ),
      ],
    ));
  }

  @override
  void initState() {
    sendButtons = defaultSendButtons;
    sendMechanicMessage(
        'Hello, This is pocket Mechanic representative agent serving you, How can i help you today?');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget msgSendButton = ElevatedButton(
        onPressed: () {
          setState(() {
            sendClientMessage(textMessage.text);
            sendButtons = defaultSendButtons;
          });
          FocusScope.of(context).unfocus();
          textMessage.clear();
        },
        child: const Text('Send'));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: RoundedContainer(
        boxChild: SingleChildScrollView(
          child: Column(
            children: chatBubbles,
          ),
        ),
      )),
      Row(
        children: [
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.send,
              onChanged: (value) {
                setState(() {
                  sendButtons = msgSendButton;
                });
              },
              controller: textMessage,
              decoration:
                  const InputDecoration(hintText: 'Type a message here...'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: sendButtons,
          )
        ],
      )
    ]);
  }
}

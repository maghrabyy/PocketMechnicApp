import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Components/rounded_container.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _fireStore = FirebaseFirestore.instance;

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

  @override
  void initState() {
    sendButtons = defaultSendButtons;
    chatBubbles.add(const MessageBubble(
      chatMsg:
          'Hello, This is pocket Mechanic representative agent serving you, How can i help you today?',
      isMe: false,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget msgSendButton = ElevatedButton(
        onPressed: () async {
          final loggedInEmail = _auth.currentUser!.email;
          String userEmail = '';
          await _fireStore
              .collection('Users')
              .doc(_auth.currentUser!.uid)
              .get()
              .then(
                (value) => userEmail = value['Email'],
              );

          setState(() {
            chatBubbles.add(MessageBubble(
              chatMsg: textMessage.text,
              isMe: loggedInEmail == userEmail.toLowerCase(),
            ));

            sendButtons = defaultSendButtons;
          });
          FocusScope.of(context).unfocus();
          textMessage.clear();
        },
        child: const Text('Send'));
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: ListView(reverse: true, children: [
          Column(
            children: chatBubbles,
          ),
        ]),
      ),
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

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.chatMsg, required this.isMe})
      : super(key: key);

  final String chatMsg;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          children: isMe
              ? [
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
                ]
              : [
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
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
        Padding(
          padding: isMe
              ? const EdgeInsets.only(right: 52.0)
              : const EdgeInsets.only(left: 52.0),
          child: Text(isMe ? '${_auth.currentUser!.displayName}' : 'Mechanic'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_pod/Model/chatMessageModel.dart';
import 'package:gemini_pod/bloc/blocEvent.dart';
import 'package:gemini_pod/bloc/chatBloc.dart';
import 'package:gemini_pod/bloc/chatState.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController promptController = TextEditingController();
  final ChatBloc = chatBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<chatBloc, blocState>(
        bloc: ChatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(children: [
                  Container(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Space Pod",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.deepPurple.shade500),
                                child: Text(
                                  messages[index].parts.first.text,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                          );
                        }),
                  ),
                  if (ChatBloc.generatingText)
                    Center(child: CircularProgressIndicator()),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: promptController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  hintText: "Enter prompt......",
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              if (promptController.text.isNotEmpty) {
                                String text = promptController.text;
                                promptController.clear();
                                ChatBloc.add(chatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.deepPurple,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}

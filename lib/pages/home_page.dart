import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spell_speak/bloc/chat_bloc.dart';
import 'package:spell_speak/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  final ChatBloc chatBloc = ChatBloc();
  bool isInputSelected = true; // Set this boolean based on the selection status

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.3,
                          image: AssetImage("assets/mrpotter.jpg"),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black.withOpacity(
                            0.5), // Adjust the opacity value as needed
                        padding: EdgeInsets.all(10),
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Spell Speaks 🪄️",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                fontFamily: 'HarryP',
                                color: Colors.amber,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image_search,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 12, left: 16, right: 16),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messages[index].role == "user"
                                                ? "Muggle🔮"
                                                : "Gemini - The Potter Head🧙🏻‍♂️",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: messages[index].role ==
                                                        "user"
                                                    ? Colors.amber
                                                    : Colors.yellow),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            messages[index].parts.first.text,
                                            style: TextStyle(height: 1.2),
                                          ),
                                        ]));
                              })),
                      if (chatBloc.generating)
                        Row(
                          children: [
                            Container(
                                height: 80,
                                width: 150,
                                child: Lottie.asset("assets/animation.json")),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Loading...",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: textEditingController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "        Ask Something to the AI...",
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 17),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide(
                                    color: isInputSelected
                                        ? Colors.amber
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  String text = textEditingController.text;
                                  textEditingController.clear();
                                  chatBloc.add(ChatGenerateNewMessageEvent(
                                      inputMessage: text));
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(
                                    0.3), // Set the desired transparency here
                                radius: 30,
                                child: Center(
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
                    ],
                  ),
                );

              default:
                return SizedBox(
                  child: Text("Oops! Error Occured!:/"),
                );
            }
          },
        ),
      ),
    );
  }
}

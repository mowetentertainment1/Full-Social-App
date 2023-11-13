import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';
import 'package:social_app/shared/styles/color.dart';

import '../../models/user_model.dart';

class ChatDetails extends StatelessWidget {
  // const ChatDetails({Key? key}) : super(key: key);
  static const screenRoute = '/ChatDetails';

  // UserModel userModel ;
  //
  // ChatDetails({required this.userModel});
  @override
  Widget build(BuildContext context) {
    var modalRoute =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var userModel = modalRoute['model'];
    var messageController = TextEditingController();
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${userModel.username}',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  )),
              body: ConditionalBuilder(
                //condition: SocialCubit.get(context).messages.isNotEmpty,
                condition: 2 > 1,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModelData!.uId ==
                                  message.senderId)
                                return buildMyMessage(message);
                              return buildReceiverMessage(message);
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount:
                                SocialCubit.get(context).messages.length),
                      ),
                      SizedBox(height: 20),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                //clipBehavior: Clip.antiAliasWithSaveLayer,
                                height: 40,
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here ...',
                                      contentPadding: EdgeInsets.all(10),
                                      hintStyle: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: AppColor.mainColor,
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                  messageController.text = '';
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Text(model.text!),
        ),
      );

  Widget buildReceiverMessage(MessageModel model) => Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: Text(model.text!),
        ),
      );
}

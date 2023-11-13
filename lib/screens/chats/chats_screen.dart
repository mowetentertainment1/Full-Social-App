import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';

import '../../models/user_model.dart';
import 'chat_details.dart';

class ChatsScreen extends StatelessWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  static const screenRoute = '/ChatsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Chats ",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.black),
            ),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: SocialCubit.get(context).users.length,
            ),
            fallback: (context) => Center(
              child: Lottie.asset('assets/images/loading2.json'),
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          Navigator.pushNamed(context, ChatDetails.screenRoute,
              arguments: {'model': model});
          //Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatDetails(userModel: model) ,));
        },
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image!),
              ),
              const SizedBox(width: 10),
              Text(model.username!),
            ],
          ),
        ),
      );
}

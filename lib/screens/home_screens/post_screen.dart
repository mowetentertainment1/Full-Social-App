import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';
import 'package:social_app/shared/styles/color.dart';

import '../layout.dart';
import 'feeds_screen.dart';

class PostScreen extends StatelessWidget {
  //const PostScreen({Key? key}) : super(key: key);
  static const screenRoute = '/PostScreen';
  var postController = TextEditingController();


  String dateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is CreatePostSuccessState)
          {
            showToast(msg: 'Post uploaded Successfully ');

            postController.text = '' ;
            SocialCubit.get(context).removePostImage();
          }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defaultAppBar(
            context,
            title: 'Create Post ',
            onLeadingPressed: () {
              Navigator.pop(context);
              // Navigator.pushReplacementNamed(context,   Layout.screenRoute );
            },
            actions: [
              TextButton(
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      username:
                          SocialCubit.get(context).userModelData!.username!,
                      dateTime: dateTime.toString(),
                      postText: postController.text,
                    );
                  } else {
                    SocialCubit.get(context).createPostWithImage(
                      username:
                          SocialCubit.get(context).userModelData!.username!,
                      dateTime: dateTime.toString(),
                      postText: postController.text,
                    );
                  }
                  FocusScope.of(context).unfocus();
                },
                child: Text(
                  'Post',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColor.mainColor),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
              condition:SocialCubit.get(context).userModelData !=null ,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is CreatePostLoadingState )
                      const LinearProgressIndicator(),
                    if(state is CreatePostLoadingState )
                      const SizedBox(height: 25),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModelData!.image}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('${SocialCubit.get(context).userModelData!.username}'),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: postController,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                          hintText: 'What is on your mind ... ',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (state is UploadPostImageSuccessState)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image(
                            image: FileImage(
                              SocialCubit.get(context).postImage!,
                            ),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          InkWell(
                            onTap:(){
                              SocialCubit.get(context).removePostImage();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: CircleAvatar(
                                backgroundColor: AppColor.mainColor,
                                radius:16,
                                child:Icon(Icons.close , color: Colors.white,) ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              SocialCubit.get(context).picPostImage();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                  ),
                                  SizedBox(width: 8),
                                  Text('Add Photo'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '#Tags',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              fallback:(context) => Center(child: Lottie.asset('assets/images/loading2.json')),
          )
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/screens/login_screen.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/widgets/post_item.dart';
import '../../../shared/home_cubit/social_cubit.dart';
import '../../../shared/home_cubit/social_states.dart';
import '../../../shared/styles/color.dart';
import '../../layout.dart';
import 'edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  static const screenRoute = '/SettingsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModelData;

        return Scaffold(
          body: SafeArea(
            child: ConditionalBuilder(
              //condition: state is! GetDataLoadingState,
              condition: state is! GetDataLoadingState && userModel != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 181.0,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 140,
                              child: Align(
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    userModel!.cover!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 140,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: CircleAvatar(
                                radius: 63,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage(userModel.image!),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        userModel.username!,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        userModel.bio!,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          profileStatistics(context,
                              onTap: () {}, count: '100', title: 'posts'),
                          profileStatistics(context,
                              onTap: () {}, count: '265', title: 'Photos'),
                          profileStatistics(context,
                              onTap: () {}, count: '10K', title: 'Followers'),
                          profileStatistics(context,
                              onTap: () {}, count: '77', title: 'Followings'),
                          Container(),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Add Photos',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: AppColor.mainColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditProfile.screenRoute);
                            },
                            child: const Icon(
                              Icons.edit,
                              color: AppColor.mainColor,
                            ),
                          ),

                        ],
                      ),
                      // if(SocialCubit.get(context).myPosts.isNotEmpty &&SocialCubit.get(context).numberOfLikes.isNotEmpty )
                      //
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const BouncingScrollPhysics(),
                      //   itemBuilder:(context , index)=>  PostItem(model: SocialCubit.get(context).posts[index] ,postIndex: index),
                      //   itemCount: SocialCubit.get(context).myPosts.length,
                      // ),
                    ],
                  ),
                ),
              ),
              fallback: (context) =>
                  Center(child: Lottie.asset('assets/images/loading2.json')),
            ),
          ),
        );
      },
    );
  }
}

Widget profileStatistics(
  context, {
  required Function() onTap,
  required String count,
  required String title,
}) =>
    InkWell(
      borderRadius: BorderRadius.circular(5.0),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(count, style: Theme.of(context).textTheme.displayLarge),
            Text(title, style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );

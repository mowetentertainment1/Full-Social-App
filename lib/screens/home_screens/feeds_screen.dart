import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/screens/home_screens/settings_screens/settings_screen.dart';
import 'package:social_app/screens/home_screens/users_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';
import 'package:social_app/shared/styles/color.dart';

import '../../widgets/post_item.dart';

class FeedsScreen extends StatelessWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  static const screenRoute = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   leading:  Padding(
          //     padding:const EdgeInsets.only(left: 8),
          //     child: CircleAvatar(
          //       radius: 25,
          //       backgroundImage: NetworkImage(
          //         SocialCubit.get(context).userModelData!.image!,
          //       ),
          //     ),
          //   ),
          //   title: InkWell(
          //     onTap: () {
          //       Navigator.pushNamed(context, SettingsScreen.screenRoute);
          //       // if (state is ChangeSocialNewsPostState)
          //       //   {
          //       //     SocialCubit.get(context).currentIndex = 4 ;
          //       //
          //       //   }
          //     },
          //     child:Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //          SocialCubit.get(context).userModelData!.username!,
          //           style: TextStyle(color: Colors.black, fontSize: 18),
          //         ),
          //         Text(
          //           'See your profile ',
          //           style: TextStyle(
          //             height: 1.2,
          //             color: AppColor.textColor,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   actions: const [
          //     Icon(Icons.search),
          //     SizedBox(width: 15),
          //     Icon(Icons.notifications_none),
          //     SizedBox(width: 15),
          //   ],
          // ),
          body: BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return ConditionalBuilder(
         condition:SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModelData !=null ,
              //condition: state is GetAllPostsSuccessState ,
              //condition: SocialCubit.get(context).posts.isNotEmpty ,
                builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          PostItem(model: SocialCubit.get(context).posts[index] ,postIndex: index),
                      itemCount: SocialCubit.get(context).posts.length,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              fallback: (context) => Center(
              child: Lottie.asset('assets/images/loading2.json')),
              );
            },
          ),
        );
      },
    );
  }
}

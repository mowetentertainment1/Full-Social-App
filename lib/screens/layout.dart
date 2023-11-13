import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/home_screens/post_screen.dart';
import 'package:social_app/shared/styles/IconBroken.dart';
import '../shared/home_cubit/social_cubit.dart';
import '../shared/home_cubit/social_states.dart';
import '../shared/styles/color.dart';
import 'home_screens/users_screen.dart';

class Layout extends StatelessWidget {
  // const Layout({Key? key}) : super(key: key);
  static const screenRoute = '/Layout';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is ChangeSocialNewsPostState) {
        Navigator.pushNamed(context, PostScreen.screenRoute);
      }
    }, builder: (context, state) {
      var cubitObject = SocialCubit.get(context);
      return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          color: AppColor.mainColor,
          animationDuration: const Duration(milliseconds: 300),
          index: cubitObject.currentIndex,
          onTap: (index) {
            cubitObject.changeBottomNavigationBar(index);
          },
          items: const [
            Icon(
              Icons.upload_file,
              color: Colors.white,
            ),
            Icon(
              Icons.mark_unread_chat_alt,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ],
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   selectedItemColor: AppColor.mainColor,
        //   currentIndex: cubitObject.currentIndex,
        //   type: BottomNavigationBarType.fixed,
        //   onTap: (index) {
        //     cubitObject.changeBottomNavigationBar(index);
        //   },
        //   items: const [
        //
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.upload_file),
        //       label: 'Post',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.mark_unread_chat_alt,),
        //       label: 'Chats',
        //     ),
        //
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.settings), label: 'Settings'),
        //   ],
        // ),
        body: cubitObject.screens[cubitObject.currentIndex],
      );
    });
  }
}

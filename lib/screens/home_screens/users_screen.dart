import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/login_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/home_cubit/social_cubit.dart';
import '../../shared/home_cubit/social_states.dart';
class UsersScreen extends StatelessWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  static const screenRoute = '/UsersScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  CacheHelper.removeUIdFromSharedPref(key: 'uId');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: const Text('Back to Login'),
              ),
            )
          ),
        );
      },
    );
  }
}


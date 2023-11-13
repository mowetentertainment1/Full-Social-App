import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_app/shared/registration_cubit/registration_states.dart';

import '../shared/registration_cubit/registration_cubit.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: socialMediaIcon(
                  icon: 'assets/images/googleicon.png',
                  onTap: () {
                    RegistrationCubit.get(context).signInWithGoogle(context);
                  }),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: socialMediaIcon(
                icon: 'assets/images/facbookicon.png',
                onTap: () {
                  RegistrationCubit.get(context).signInWithFacebook(context);
                },
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: socialMediaIcon(
                  icon: 'assets/images/twittericon.png',
                  onTap: () {
                    RegistrationCubit.get(context).signInWithTwitter(context);
                  }),
            ),
          ],
        );
      },
    );
  }
}

Widget socialMediaIcon({required String icon, required Function() onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      height: 55,
      //width: 90,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 7)
        ],
      ),
      child: Image.asset(
        icon,
        height: 30,
      ),
    ),
  );
}

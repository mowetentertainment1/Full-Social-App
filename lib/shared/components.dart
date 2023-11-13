import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import 'styles/color.dart';

Widget AppIcon({double height = 200}) => Center(
      child: Lottie.asset(
        'assets/images/login animation.json',
        height: height,
      ),
    );

Future<bool?> showToast({required String msg}) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColor.mainColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );

AppBar defaultAppBar(
  BuildContext context, {
  required String title,
  Function()? onLeadingPressed,
  List<Widget>? actions,
}) =>
    AppBar(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: Colors.black),
      ),
      titleSpacing: 1,
      leading: IconButton(
        onPressed: onLeadingPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
      actions: actions,
    );

import 'package:flutter/material.dart';

import '../shared/styles/color.dart';

class DefaultButton extends StatelessWidget {
  // const DefaultButton({Key? key}) : super(key: key);

  final String text;

  final Function() onTap;

  final double width;

  final double height;

  final double fontSize;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 55,
    this.width = double.maxFinite,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 8)
          ],
        ),
        child: Text(text,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.white,
                  fontSize: fontSize,
                )),
      ),
    );
  }
}

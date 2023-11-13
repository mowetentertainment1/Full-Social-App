import 'package:flutter/material.dart';
import '../shared/styles/color.dart';

class DefaultTextFormField extends StatelessWidget {
  //const DefaultTextFormField({Key? key}) : super(key: key);

  final String hintText;

  TextEditingController? controller;

  String? Function(String?)? validator;

  Function(String)? onChange;

  Function(String)? onFieldSubmitted;

  Function()? suffixOnPressed;

  IconData? prefixIcon;
  IconData? suffixIcon;
  TextInputType? keyboardType;
  bool isSecure;

  DefaultTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.onChange,
    this.validator,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    this.keyboardType,
    this.isSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.7),
        //     blurRadius: 6
        //   )
        // ]
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChange,
        onFieldSubmitted: onFieldSubmitted,
        style: const TextStyle(letterSpacing: 1.3, fontWeight: FontWeight.w400),
        obscureText: isSecure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(letterSpacing: 1.4),
          contentPadding: EdgeInsets.only(
              // bottom: 10
              ),
          prefixIcon: Icon(prefixIcon, color: AppColor.mainColor),
          suffixIcon: IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(
              suffixIcon,
              color: !isSecure ? AppColor.mainColor : Colors.grey,
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/screens/home_screens/feeds_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/shared/registration_cubit/registration_states.dart';
import '../shared/components.dart';
import '../shared/registration_cubit/registration_cubit.dart';
import '../widgets/SocialMediaLinks.dart';
import '../widgets/default_button.dart';
import '../widgets/default_textformfield.dart';
import 'layout.dart';

class RegisterScreen extends StatelessWidget {
  //const RegisterScreen({Key? key}) : super(key: key);
  static const screenRoute = '/RegisterScreen';
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessfullyState) {
            Navigator.pushReplacementNamed(context, LoginScreen.screenRoute);
            showToast(msg: 'Registration Done Successfully');
          } else if (state is RegisterErrorState) {
            if (state.error.code == 'weak-password') {
              showToast(msg: 'The password provided is too weak.');
            } else if (state.error.code == 'email-already-in-use') {
              showToast(msg: 'The account already exists for that email.');
            } else if (state.error.code == 'invalid-email') {
              showToast(msg: 'The email address is badly formatted.');
            } else if (state.error.code == 'email-already-in-use') {
              showToast(
                  msg:
                      'The email address is already in use by another account.');
            } else {
              showToast(msg: '${state.error}');
            }
          }
        },
        builder: (context, state) {
          var cubitObject = RegistrationCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: state is! RegisterLoadingState,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppIcon(height: 150),
                        Text(
                          'Create your Account',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 20),
                        DefaultTextFormField(
                          prefixIcon: Icons.person,
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          hintText: 'Username',
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return 'Username required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        DefaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icons.email,
                          hintText: 'Email',
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return 'Email required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.phone,
                          hintText: 'Phone',
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return 'Phone required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        DefaultTextFormField(
                          prefixIcon: Icons.lock,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          suffixIcon: cubitObject.suffixIcon,
                          suffixOnPressed: cubitObject.changeSuffixIcon,
                          isSecure: cubitObject.isPassword,
                          validator: (inputValue) {
                            if (inputValue!.isEmpty) {
                              return 'Password required';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubitObject.userRegister(
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        DefaultButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubitObject.userRegister(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  username: usernameController.text,
                                );
                              }
                            }),
                        const SizedBox(height: 30),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '-Or sign up with -',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const SocialMediaLinks(),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) =>
                  Center(child: Lottie.asset('assets/images/loading2.json')),
            ),
          );
        },
      ),
    );
  }
}

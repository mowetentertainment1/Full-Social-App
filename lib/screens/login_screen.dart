import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/const.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/screens/register_screen.dart';
import '../shared/components.dart';
import '../shared/home_cubit/social_cubit.dart';
import '../shared/registration_cubit/registration_cubit.dart';
import '../shared/registration_cubit/registration_states.dart';
import '../shared/styles/color.dart';
import '../widgets/SocialMediaLinks.dart';
import '../widgets/default_button.dart';
import '../widgets/default_textformfield.dart';
import 'home_screens/feeds_screen.dart';
import 'layout.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);
  static const screenRoute = '/LoginScreen';
  bool isEmpty = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationStates>(
        listener: (context, state) {
          if (state is LoginSuccessfullyState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              print('My Uid IS ${state.uId}');

              Navigator.pushReplacementNamed(context, Layout.screenRoute);
            });

            showToast(msg: 'Login Done Successfully');
          } else if (state is LoginErrorState) {
            if (state.error.code == 'invalid-email') {
              showToast(msg: 'The email address is badly formatted.');
            } else if (state.error.code == 'wrong-password') {
              showToast(msg: 'Wrong password provided for that user.');
            } else if (state.error.code == 'user-not-found') {
              showToast(msg: 'No user found for that email.');
            } else {
              showToast(msg: '${state.error.code}');
            }
          }
        },
        builder: (context, state) {
          var cubitObject = RegistrationCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
                condition: state is! LoginLoadingState,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              AppIcon(),
                              Text(
                                'Login to your Account',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(height: 15),
                              DefaultTextFormField(
                                prefixIcon: Icons.email,
                                controller: emailController,
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return 'Email required';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 15),
                              DefaultTextFormField(
                                prefixIcon: Icons.lock,
                                controller: passwordController,
                                isSecure: cubitObject.isPassword,
                                validator: (inputValue) {
                                  if (inputValue!.isEmpty) {
                                    return 'Password required';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                hintText: 'Password',
                                suffixIcon: cubitObject.suffixIcon,
                                suffixOnPressed: cubitObject.changeSuffixIcon,
                                onFieldSubmitted: (value) {
                                  if (formKey.currentState!.validate()) {
                                    cubitObject.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              DefaultButton(
                                key: GlobalKey<FormState>(),
                                text: 'Sign In',
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubitObject.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              const SizedBox(height: 30),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '-Or sign in with -',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                    Center(child: Lottie.asset('assets/images/loading2.json'))),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.screenRoute);
                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: AppColor.mainColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

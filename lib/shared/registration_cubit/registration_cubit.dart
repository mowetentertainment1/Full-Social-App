import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/registration_cubit/registration_states.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../const.dart';
import '../../screens/layout.dart';

class RegistrationCubit extends Cubit<RegistrationStates> {
  RegistrationCubit() : super(InitialStates());

  static RegistrationCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility;

  bool isPassword = true;

  changeSuffixIcon() {
    isPassword
        ? suffixIcon = Icons.visibility_off
        : suffixIcon = Icons.visibility;
    isPassword = !isPassword;
    emit(ChangeSuffixIconState());
  }

  void userRegister({
    //required String image,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreateData(
        uId: value.user!.uid,
        username: username,
        phone: phone,
        email: email,
      );
      // emit(RegisterSuccessfullyState());
    }).catchError((error) {
      emit(RegisterErrorState(error: error));
    });
  }

  void userCreateData({
    required String uId,
    required String username,
    required String email,
    required String phone,
  }) {
    UserModel userModel = UserModel(
      uId: uId,
      image:
          'https://img.freepik.com/free-photo/portrait -happy-smiley-man_23-2149022620.jpg?w=1380&t=st=1698816294~exp=1698816894~hmac=83f99147bc48b4b75074daba66f0232bb36b51e9e05ef04f6ff626e8bf91f695',
      cover:
          'https://www.herofincorp.com/public/admin_assets/upload/blog/64b91a06ab1c8_food%20business%20ideas.webp',
      bio: 'write your bio...',
      username: username,
      email: email,
      phone: phone,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessfullyState());
    }).catchError((error) {
      emit(CreateUserErrorState(error: error));
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginSuccessfullyState(uId: value.user!.uid));
      print('Error From Login Cubit ${value.user!.uid}');
    }).catchError((error) {
      emit(LoginErrorState(error: error));
    });
  }

  Future signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(LoginSuccessfullyState(uId: value.user!.uid));
    });
  }

  //
  Future signInWithFacebook(context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      emit(LoginSuccessfullyState(uId: value.user!.uid));
    });

    //Navigator.pushReplacementNamed(context, Layout.screenRoute);
  }

  Future signInWithTwitter(context) async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
      apiKey: 'VrQLQN8ZQ66IcmXpf1wLpBhyk',
      apiSecretKey: 'QoaGSPTSWK3l4MRrNO8AcX4WiAyf6R2Zm7SnRV0mQ8f2H8kz5A',
      redirectURI: 'flutter-twitter-login://',
      // redirectUri: "https://[yourProjectId].firebaseapp.com/__/auth/handler"),
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(twitterAuthCredential)
        .catchError((error) {
      print('error from twitter is ${error.toString()}');
    });
    Navigator.pushReplacementNamed(context, Layout.screenRoute);
  }

//
// bool isEmpty = false ;
//
//   changeFormFieldHeight(inputValue)
//   {
//     if (inputValue!.isEmpty) {
//       print(isEmpty) ;
//       isEmpty = true ;
//       emit(ChangeFormFieldHeightState());
//       return 'Password required';
//
//     } else {
//       return null;
//     }
//   }
}

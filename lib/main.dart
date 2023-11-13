import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/network/remote/fcm_helper.dart';
import 'package:social_app/screens/home_screens/feeds_screen.dart';
import 'package:social_app/screens/home_screens/settings_screens/edit_profile.dart';
import 'package:social_app/screens/home_screens/settings_screens/settings_screen.dart';
import 'package:social_app/screens/home_screens/users_screen.dart';
import 'package:social_app/screens/login_screen.dart';
import 'package:social_app/screens/splash_screen.dart';
import 'package:social_app/shared/registration_cubit/registration_cubit.dart';
import 'package:social_app/shared/registration_cubit/registration_states.dart';
import 'const.dart';
import 'screens/chats/chat_details.dart';
import 'screens/home_screens/post_screen.dart';
import 'screens/layout.dart';
import 'screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'shared/bloc_observer.dart';
import 'shared/home_cubit/social_cubit.dart';
import 'shared/home_cubit/social_states.dart';
import 'shared/styles/theme.dart';

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifiaction();
  uId = CacheHelper.getData(key: 'uId');
  print('My uId Is $uId');

  Widget? startWidget;

  if (uId == null) {
    startWidget = const SplashScreen();
  } else {
    startWidget = Layout();
  }

  runApp(MyApp(startScreen: startWidget));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  Widget startScreen;

  MyApp({required this.startScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegistrationCubit()),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getAllPosts(),
        ),
      ],
      child: BlocConsumer<RegistrationCubit, RegistrationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Social App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            //home: RegisterScreen(),

            routes: {
              '/': (context) => startScreen,
              LoginScreen.screenRoute: (context) => LoginScreen(),
              RegisterScreen.screenRoute: (context) => RegisterScreen(),
              Layout.screenRoute: (context) => Layout(),
              FeedsScreen.screenRoute: (context) => FeedsScreen(),
              UsersScreen.screenRoute: (context) => UsersScreen(),
              SettingsScreen.screenRoute: (context) => SettingsScreen(),
              EditProfile.screenRoute: (context) => EditProfile(),
              PostScreen.screenRoute: (context) => PostScreen(),
              ChatDetails.screenRoute: (context) => ChatDetails(),
            },
          );
        },
      ),
    );
  }
}


import 'package:chat_app_2/screen/chat/view/chat_screen.dart';
import 'package:chat_app_2/screen/contact/view/contact_screen.dart';
import 'package:chat_app_2/screen/profile/view/profile_screen.dart';
import 'package:chat_app_2/screen/singin/view/singin_screen.dart';
import 'package:chat_app_2/screen/singup/view/singup_screen.dart';
import 'package:chat_app_2/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

import '../screen/home/view/home_screen.dart';

Map<String,WidgetBuilder>app_routs={
   "/":(context) => const SplashScreen(),
  "signin":(context) => const SingInScreen(),
   "singup":(context) => const SingUpScreen(),
   "home":(context) => const HomeScreen(),
   "profile":(context) => const ProfileScreen(),
  "contact":(context) => const ContactScreen(),
  "chat":(context) => const ChatScreen(),

};

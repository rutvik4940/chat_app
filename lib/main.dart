import 'package:chat_app_2/screen/home/controller/home_controller.dart';
import 'package:chat_app_2/utils/app_routs.dart';
import 'package:chat_app_2/utils/helper/fcm_helper.dart';
import 'package:chat_app_2/utils/service/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  HomeController controller = Get.put(HomeController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationHelper.helper.initNotification();
  FCMHelper.fcm.receiveMessage();
  runApp(
    Obx(
      () {
        controller.getData();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: app_routs,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.mode.value,
        );
      },
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../utils/helper/share_helper.dart';



class HomeController extends GetxController
{
  Rx<IconData> icon = Icons.light_mode.obs;
  RxBool Theme = false.obs;
  Rx<ThemeMode> mode = ThemeMode.light.obs;
  Rx<DateTime>date=DateTime.now().obs;
  Rx<TimeOfDay>time=TimeOfDay.now().obs;
  RxBool isHide=true.obs;

  Future<void> setData(bool theme) async {
    ShareHelper.helper.setTheme(theme);
    Theme.value = (await ShareHelper.helper.getTheme())!;
    if (Theme.value == true) {
      icon.value = Icons.light_mode;
      mode.value = ThemeMode.dark;
    } else {
      icon.value = Icons.dark_mode;
      mode.value = ThemeMode.light;
    }
  }

  Future<void> getData() async {
    if (await ShareHelper.helper.getTheme() != null) {
      Theme.value = (await ShareHelper.helper.getTheme())!;
      setData(Theme.value);
    } else {
      Theme.value = false;
      setData(Theme.value);
    }
  }
  void hidePassword()
  {
    isHide.value=!isHide.value;
  }

}

import 'dart:io';

import 'package:app_widgets_example/config/app_loader.dart';
import 'package:app_widgets_example/config/extension/space_extension.dart';
import 'package:app_widgets_example/config/helpers/date_helper.dart';
import 'package:app_widgets_example/config/res.dart';
import 'package:app_widgets_example/config/theme/color_extension.dart';
import 'package:app_widgets_example/config/theme/theme_controller.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_appbar.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_button.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_checkbox.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_dropdown_menu.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_image_picker_dialog.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_language_dialog.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_language_switch.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_network_image.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_radio_button.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_text.dart';
import 'package:app_widgets_example/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/helpers/logging_helper.dart';
import 'notifications/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textEditingController = TextEditingController();
  GlobalKey<AppTextFormFieldState> textFormState =
      GlobalKey<AppTextFormFieldState>();

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: AppAppbar(
        title: 'Flutter Common Widgets',
        actions: [
          GestureDetector(
            onTap: () async {
              await Get.find<ThemeController>().toggleAppTheme();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'Change Theme',
                color: context.kColorOnPrimary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: AppText(
                  text: '''This application is made for testing
                     and developing common widgets
                     shared in different applications apps.''',
                ),
              ),
              Row(
                children: [
                  AppButton(
                    onPressed: () {
                      Get.to(() => const NotificationsScreen());
                    },
                    text: 'Paginated ListView',
                  ),
                  10.pw,
                  AppButton(
                    onPressed: () {
                      AppLogger.log('This is a  new log message');
                    },
                    text: 'Log message',
                  ),
                ],
              ),
              AppDropDownMenu(
                hint: 'Select Country',
                items: const [
                  'Egypt',
                  'USA',
                  'UK',
                  'KSA',
                  'US',
                ],
                onChanged: (String? value) {},
              ),
              Row(
                children: [
                  AppButton(
                    onPressed: () async {
                      AppLoader.loading();
                      await Future.delayed(const Duration(seconds: 3));
                      AppLoader.dismiss();
                    },
                    text: 'Show Loading',
                  ),
                  10.pw,
                  const AppLanguageSwitch(),
                ],
              ),
              AppButton(
                text: 'change language',
                onPressed: () {
                  showAppLanguageDialog(context: context);
                },
              ),
              AppNetworkImage(
                isCircular: true,
                localFile: image,
                imageUrl:
                    'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
              ),
              AppButton(
                text: 'Choose Picture',
                onPressed: () {
                  showAppImageDialog(
                      context: context,
                      onFilePicked: (File? file) {
                        setState(() {
                          image = file;
                        });
                      });
                },
              ),
              AppCheckbox(
                text: 'Agree to Continue',
                value: true,
                onChange: (bool? value) {},
              ),
              AppTextFormField(
                key: textFormState,
                controller: textEditingController,
                hintText: 'email',
                appFieldType: AppFieldType.email,
                prefixIcon: Res.emailIcon,
                suffixText: '@gmail.com',
              ),
              AppButton(
                text: 'Validate',
                onPressed: () {
                  textFormState.currentState?.shake();
                  textFormState.currentState
                      ?.updateHelperText('Email in no longer valid');
                },
              ),
              Row(
                children: [
                  AppButton(
                    text: 'Get Time',
                    onPressed: () {
                      String time = DateHelper()
                          .getTimeFromDateString('2024-09-06 07:35:40');
                      AppLogger.log(time);
                    },
                  ),
                  10.pw,
                  AppButton(
                    text: 'Get Date',
                    onPressed: () {
                      String time = DateHelper()
                          .getDateFromDateString('2024-09-06 07:35:40');
                      AppLogger.log(time);
                    },
                  ),
                ],
              ),
              AppRadioButton<String>(
                options: const [
                  'Option 1',
                  'Option 2',
                  'Option 3',
                  'Option 4',
                  'Option 5',
                ],
                onChanged: (String? value) {
                  AppLogger.log(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

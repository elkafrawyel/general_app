import 'dart:io';

import 'package:flutter/material.dart';
import 'package:general_app/config/app_loader.dart';
import 'package:general_app/config/extension/space_extension.dart';
import 'package:general_app/config/helpers/date_helper.dart';
import 'package:general_app/config/helpers/time_debuncer.dart';
import 'package:general_app/config/helpers/url_launcher_helper.dart';
import 'package:general_app/config/information_viewer.dart';
import 'package:general_app/config/res.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/config/theme/theme_controller.dart';
import 'package:general_app/screens/form/form_screen.dart';
import 'package:general_app/screens/hooks/hooks_screen.dart';
import 'package:general_app/screens/messages/controller/messages_binding.dart';
import 'package:general_app/screens/messages/messages_screen.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/app_bottom_nav.dart';
import 'package:general_app/widgets/app_widgets/app_button.dart';
import 'package:general_app/widgets/app_widgets/app_carousel_slider.dart';
import 'package:general_app/widgets/app_widgets/app_checkbox.dart';
import 'package:general_app/widgets/app_widgets/app_chips_multi_choice.dart';
import 'package:general_app/widgets/app_widgets/app_chips_single_choice.dart';
import 'package:general_app/widgets/app_widgets/app_dialogs/logout_dialog.dart';
import 'package:general_app/widgets/app_widgets/app_dropdown_menu.dart';
import 'package:general_app/widgets/app_widgets/app_image_picker_dialog.dart';
import 'package:general_app/widgets/app_widgets/app_language/app_language_dialog.dart';
import 'package:general_app/widgets/app_widgets/app_language/app_language_segment.dart';
import 'package:general_app/widgets/app_widgets/app_language/app_language_switch.dart';
import 'package:general_app/widgets/app_widgets/app_list_tile.dart';
import 'package:general_app/widgets/app_widgets/app_modal_bottom_sheet.dart';
import 'package:general_app/widgets/app_widgets/app_network_image.dart';
import 'package:general_app/widgets/app_widgets/app_radio_button.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';
import 'package:general_app/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:general_app/widgets/app_widgets/app_webview.dart';
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
      resizeToAvoidBottomInset: false,
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
      bottomNavigationBar: AppBottomNav(
        navBarItems: [
          NavBarItem(text: 'Home', assetName: Res.emailIcon),
          NavBarItem(text: 'Messages', assetName: Res.emailIcon),
          NavBarItem(text: 'Orders', assetName: Res.emailIcon),
          NavBarItem(text: 'Notifications', assetName: Res.emailIcon),
          NavBarItem(text: 'Menu', assetName: Res.emailIcon),
        ],
        onTap: (int index) {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const AppCarouselSlider(),
              AppListTile(
                leading: AppNetworkImage(
                  isCircular: true,
                  localFile: image,
                  imageUrl:
                      'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
                ),
                title: 'New Tile Title',
                onTap: () {
                  InformationViewer.showSuccessToast(msg: 'List Tile Clicked');
                },
                body: 'New Tile body for the list tile title ',
              ),
              AppButton(
                text: 'Form Screen',
                onPressed: () {
                  Get.to(() => const FormScreen());
                },
              ),
              AppButton(
                text: 'Hooks Screen',
                onPressed: () {
                  Get.to(() => const HooksScreen());
                },
              ),
              AppButton(
                text: 'Show Bottom Sheet',
                onPressed: () {
                  _showBottomSheet(context);
                },
              ),
              Row(
                children: [
                  AppButton(
                    text: 'Call',
                    onPressed: () {
                      UrlLauncherHelper.makePhoneCall('01019744661');
                    },
                  ),
                  10.pw,
                  AppButton(
                    text: 'Launch Url',
                    onPressed: () {
                      UrlLauncherHelper.openLink('https://www.google.com');
                    },
                  ),
                  10.pw,
                  AppButton(
                    text: 'Open Url',
                    onPressed: () {
                      Get.to(
                        () => const AppWebview(
                            title: 'Google', url: 'https://www.google.com'),
                      );
                    },
                  ),
                ],
              ),
              AppChipsMultiChoice<String>(
                choices: const [
                  'Google',
                  'Facebook',
                  'Twitter',
                  'tiktok',
                ],
                onSelectedChoicesChanged: (List<String> selectedChoices) {
                  AppLogger.log(selectedChoices);
                },
              ),
              AppChipsSingleChoice<String>(
                choices: const [
                  'Google',
                  'Facebook',
                  'Twitter',
                  'tiktok',
                ],
                onSelectedChoiceChanged: (String? selectedChoice) {
                  AppLogger.log(selectedChoice);
                },
              ),
              Row(
                children: [
                  AppButton(
                    text: 'logOut',
                    onPressed: () {
                      showLogoutAlertDialog(context, () {
                        Get.back();
                        InformationViewer.showSuccessToast(
                            msg: 'Logging out of the application');
                      });
                    },
                  ),
                  10.pw,
                  AppButton(
                    text: 'delete account',
                    onPressed: () {
                      showDeleteAccountAlertDialog(context, () {
                        Get.back();
                        InformationViewer.showSuccessToast(
                            msg: 'Deleting your account');
                      });
                    },
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: AppText(
                  text: '''This application is made for testing
                     and developing common widgets
                     shared in different applications apps.''',
                ),
              ),
              AppButton(
                text: 'Messages',
                onPressed: () {
                  Get.to(
                    () => const MessagesScreen(),
                    binding: MessagesBinding(),
                  );
                },
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
                      TimeDebuncer.instance.debounce(
                        const Duration(seconds: 3),
                        () {
                          // AppLogger.log('This is a  new log message');
                          AppLogger.getxLog('Timer Debouncer');
                        },
                      );
                    },
                    text: 'Log message',
                  ),
                ],
              ),
              AppDropDownMenu(
                hint: 'Select Country',
                // leading: Image.network(
                // 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Canada.svg/2560px-Flag_of_Canada.svg.png',
                // ),
                items: const [
                  'Egypt',
                  'USA',
                  'UK',
                  'KSA',
                  'US',
                ],
                bordered: true,
                expanded: true,
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
              const AppLanguageSegment(),
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

  _showBottomSheet(BuildContext context) {
    showAppModalBottomSheet(
      context: context,
      maxChildSize: 0.6,
      initialChildSize: 0.3,
      minChildSize: 0.2,
      builder: (context, scrollerController) {
        final TextEditingController textEditingController =
            TextEditingController();
        return Container(
          color: context.kBackgroundColor,
          child: SingleChildScrollView(
            controller: scrollerController,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: 'Please Type rejection reason.',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  AppTextFormField(
                    controller: textEditingController,
                    hintText: 'Email',
                  ),
                  10.ph,
                  AppTextFormField(
                    controller: textEditingController,
                    hintText: 'Rejection Reason',
                  ),
                  10.ph,
                  Center(
                    child: AppButton(
                      text: 'Submit',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

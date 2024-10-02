import 'package:flutter/material.dart';
import 'package:general_app/widgets/app_widgets/app_appbar.dart';
import 'package:general_app/widgets/app_widgets/app_button.dart';
import 'package:general_app/widgets/app_widgets/app_text_field/app_text_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<AppTextFormFieldState> passwordKey = GlobalKey();
  GlobalKey<AppTextFormFieldState> confirmPasswordKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppbar(
        title: 'Form Screen',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              AppTextFormField(
                controller: phoneController,
                hintText: 'Phone',
                appFieldType: AppFieldType.phone,
              ),
              AppTextFormField(
                controller: emailController,
                hintText: 'Email',
                appFieldType: AppFieldType.email,
              ),
              AppTextFormField(
                key: passwordKey,
                controller: passwordController,
                hintText: 'Password',
              ),
              AppTextFormField(
                key: confirmPasswordKey,
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
              ),
              AppButton(
                text: 'Validate',
                onPressed: validate,
              )
            ],
          ),
        ),
      ),
    );
  }

  validate() {}
}

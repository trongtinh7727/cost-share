import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/common/error_message.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cost_share/presentation/common/app_text_input_field.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/string_ext.dart';
import 'package:cost_share/presentation/authentication/bloc/authenticate_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isChecked = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticateBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.localization.signUp,
          style: AppTextStyles.title3,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  context.localization.signUp,
                  style: AppTextStyles.title2
                      .copyWith(color: AppColors.colorDark100),
                ),
              ),
              const SizedBox(height: 12),
              AppTextInputField(
                controller: _nameController,
                hintText: context.localization.name,
                onChanged: authBloc.onChangeFullName,
                validator: (value) => value.isEmpty
                    ? context.localization.nameCannotBeEmpty
                    : null,
              ),
              const SizedBox(height: 20),
              AppTextInputField(
                controller: _emailController,
                hintText: context.localization.email,
                onChanged: authBloc.onChangeEmail,
                validator: (value) => value.isValidEmail()
                    ? null
                    : context.localization.invalidEmail,
              ),
              const SizedBox(height: 20),
              AppTextInputField(
                controller: _passwordController,
                hintText: context.localization.password,
                isPasswordField: true,
                onChanged: authBloc.onPassChanged,
                validator: (value) => value.isValidPassword()
                    ? null
                    : context.localization.invalidPassword,
              ),
              const SizedBox(height: 12),
              AppTextInputField(
                controller: _confirmPasswordController,
                hintText: context.localization.confirmPassword,
                isPasswordField: true,
                validator: (value) => value == _passwordController.text
                    ? null
                    : context.localization.passwordMismatch,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      context.localization.policy,
                      style: AppTextStyles.body1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: StreamBuilder<bool>(
                  stream: context.read<AuthenticateBloc>().loadingStream,
                  builder: (context, snapshot) {
                    final isLoading = snapshot.data ?? false;
                    return MyAppButton(
                      onPressed: isLoading || !_isChecked
                          ? null
                          : () async {
                              await context.read<AuthenticateBloc>().signUp();
                              await context.read<UserManager>().loadUser();
                              final user =
                                  context.read<UserManager>().currentUser;
                              if (user != null) {
                                Navigator.pushReplacementNamed(
                                    context, RouteName.intro);
                              }
                            },
                      message: context.localization.signUp,
                      isLoading: isLoading,
                      isPrimary: true,
                    );
                  },
                ),
              ),
              Padding(
                  child: ErrorMessage(
                      error: context.read<AuthenticateBloc>().errorStream),
                  padding: EdgeInsets.symmetric()),
              SizedBox(height: 20),
              Center(child: Text("Or with", style: TextStyle(fontSize: 14))),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Assets.icon.svg.iconGoogle.svg(),
                label: Text(
                  context.localization.googleSignUp,
                  style: AppTextStyles.title3
                      .copyWith(color: AppColors.colorDark50),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.localization.alreadyHaveAccount,
                      style: AppTextStyles.body1
                          .copyWith(color: AppColors.colorDark25),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.signIn);
                      },
                      child: Text(
                        context.localization.login,
                        style: AppTextStyles.body1
                            .copyWith(color: AppColors.colorViolet100),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/manager/group_manager.dart';
import 'package:cost_share/manager/user_manager.dart';
import 'package:cost_share/presentation/common/app_text_input_field.dart';
import 'package:cost_share/presentation/common/error_message.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/extension/context_ext.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/authenticate_bloc.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  context.localization.login,
                  style: AppTextStyles.title2
                      .copyWith(color: AppColors.colorDark100),
                ),
              ),
              const SizedBox(height: 20),
              AppTextInputField(
                controller: _emailController,
                hintText: context.localization.email,
                onChanged: authBloc.onChangeEmail,
              ),
              const SizedBox(height: 20),
              AppTextInputField(
                controller: _passwordController,
                hintText: context.localization.password,
                isPasswordField: true,
                onChanged: authBloc.onPassChanged,
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
                      onPressed: isLoading
                          ? null
                          : () async {
                              await context.read<AuthenticateBloc>().signIn();
                              await context.read<UserManager>().loadUser();
                              final user =
                                  context.read<UserManager>().currentUser;
                              if (user != null) {
                                await context
                                    .read<GroupManager>()
                                    .loadUserGroups(user.id);

                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RouteName.intro,
                                  (route) {
                                    return route.settings.name ==
                                        RouteName.intro;
                                  },
                                );
                              }
                            },
                      message: context.localization.login,
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
                        Navigator.pushNamed(context, RouteName.signUp);
                      },
                      child: Text(
                        context.localization.signUp,
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

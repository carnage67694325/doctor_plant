import 'dart:developer';

import 'package:doct_plant/core/utils/approuter.dart';
import 'package:doct_plant/core/utils/functions/error_snack.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/core/utils/widgets/email_textfield.dart';
import 'package:doct_plant/core/utils/widgets/name_textfield.dart';
import 'package:doct_plant/core/utils/widgets/password_textfield.dart';
import 'package:doct_plant/features/auth/register/view_model.dart/cubit/register_cubit.dart';
import 'package:doct_plant/features/home/view/widgets/custom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
          child: SingleChildScrollView(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              GoRouter.of(context).push(AppRouter.kLogin);
            } else if (state is RegisterFailure) {
              errorSnackBar(context, state.erroMessage);
              log(state.erroMessage);
            }
          },
          builder: (context, state) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300.h,
                  ),
                  NameTextField(
                    controller: _nameController,
                    hintText: 'Enter your email',
                    onChanged: (value) {
                      log('Email changed: $value');
                    },
                    labelText: "Name",
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  EmailTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    onChanged: (value) {
                      log('Email changed: $value');
                    },
                    labelText: "Email",
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    showStrengthIndicator: true,
                    onChanged: (value) {
                      log('Password changed');
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  PasswordTextField(
                    controller: _passwordConfirmController,
                    hintText: 'Enter your password',
                    showStrengthIndicator: false,
                    onChanged: (value) {
                      log('Password changed');
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomElvatedButton(
                    child: state is RegisterLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                    onPressed: () async {
                      if (checkRegisterData) {
                        await BlocProvider.of<RegisterCubit>(context).register(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          confirmPassword: _passwordConfirmController.text,
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }

  bool get checkRegisterData {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordConfirmController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _passwordConfirmController.text == _passwordController.text;
  }
}

import 'package:expendi/app/modules/auth/logics/_register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/_app_logo.dart';
import '../../../shared/widgets/_custom_button.dart';
import '../../../shared/widgets/_custom_text_button.dart';
import '../../../shared/widgets/_custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const _RegisterPage(),
    );
  }
}

class _RegisterPage extends StatefulWidget {
  const _RegisterPage({super.key});

  @override
  State<_RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<_RegisterPage> {
  final TextEditingController _nameController = .new();
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();
  final TextEditingController _currencyController = .new();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  String? validateInputs() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final currency = _currencyController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || currency.isEmpty) {
      return 'Please fill in all fields';
    }

    // Simple email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    // Optionally: check password length
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterFailure){
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: theme.colorScheme.onSurface.withAlpha(200),
            builder: (context) {
              return AlertDialog(
                title: const Text('Registration Error'),
                content: Text(state.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // kill the app
                      // Future.delayed(Duration.zero, () {
                      //   if(context.mounted){
                      //     context.go('/');
                      //   }
                      // });
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        if (state is RegisterSuccess) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              context.go(state.redirectedRoute);
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withAlpha(25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                children: [
                  Center(child: AppLogo(size: 80)),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Hi there!',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Hero(
                        tag: 'sign-up-text',
                        child: Text(
                          'Create an account to get started',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurfaceVariant.withAlpha(
                              200,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  CustomTextField(
                    width: double.infinity,
                    height: 60,
                    label: 'Name',
                    hint: 'Enter your name',
                    controller: _nameController,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    width: double.infinity,
                    height: 60,
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: _emailController,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    width: double.infinity,
                    height: 60,
                    label: 'Currency',
                    hint: 'Enter your currency',
                    controller: _currencyController,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    width: double.infinity,
                    height: 60,
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    isPassword: true,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return CustomButton(
                        width: double.infinity,
                        height: 50,
                        text: 'Sign up',
                        isLoading: state is RegisterLoading,
                        onPressed: () {
                          final validationError = validateInputs();
                          if (validationError != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: theme.colorScheme.onSurface.withAlpha(200),
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Input Error'),
                                  content: Text(validationError),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }

                          context.read<RegisterCubit>().register(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            currency: _currencyController.text.trim(),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withAlpha(
                            200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomTextButton(
                        text: Text(
                          'Sign in',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:expendi/app/modules/auth/logics/_login_cubit.dart';
import 'package:expendi/app/shared/widgets/_app_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/_custom_button.dart';
import '../../../shared/widgets/_custom_text_button.dart';
import '../../../shared/widgets/_custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView({super.key});

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();

  String? validateInputs() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: theme.colorScheme.onSurface.withAlpha(200),
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.errorMessage.split(':').last.trim()),
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
        }

        if (state is LoginSuccess) {
          context.go(state.redirectedRoute);
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
                      'Welcome',
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
                      Text(
                        'Sign in to track your expenses!',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurfaceVariant.withAlpha(
                            200,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
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
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    isPassword: true,
                    textStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        width: double.infinity,
                        height: 50,
                        text: 'Sign in',
                        isLoading: state is LoginLoading,
                        onPressed: () async {
                          final validationError = validateInputs();
                          if (validationError != null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: theme.colorScheme.onSurface
                                  .withAlpha(200),
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

                          await context.read<LoginCubit>().login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
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
                        "Don't have an account?",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withAlpha(
                            200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomTextButton(
                        text: Hero(
                          tag: 'sign-up-text', // unique tag
                          child: Text(
                            'Sign up',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.push('/register');
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

import 'package:expendi/app/shared/widgets/_app_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/_custom_button.dart';
import '../../../shared/widgets/_custom_text_button.dart';
import '../../../shared/widgets/_custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginView();
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView({super.key});

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                  controller: TextEditingController(),
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
                  controller: TextEditingController(),
                  isPassword: true,
                  textStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  width: double.infinity,
                  height: 50,
                  text: 'Sign in',
                  onPressed: () {},
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
    );
  }
}

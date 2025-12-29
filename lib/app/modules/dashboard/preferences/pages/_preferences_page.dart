import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/repositories/local/_hive_service.dart';
import 'package:expendi/app/shared/widgets/_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PreferencesView();
  }
}

class _PreferencesView extends StatefulWidget {
  const _PreferencesView({super.key});

  @override
  State<_PreferencesView> createState() => __PreferencesViewState();
}

class __PreferencesViewState extends State<_PreferencesView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text('Preferences Page', style: theme.textTheme.headlineMedium),

          CustomButton(
            width: double.infinity,
            height: 50,
            text: 'Logout',
            onPressed: () async {
              await ApiClient().clearTokens().then((_) async {
                await HiveService('user_data').clear();
                if (context.mounted) {
                  context.go('/login');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

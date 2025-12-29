import 'package:flutter/material.dart';

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
    final   theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: const Center(
        child: Text(
          'Preferences Page',
        ),
      ),
    );
  }
}

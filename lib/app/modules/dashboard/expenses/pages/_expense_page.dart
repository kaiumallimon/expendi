import 'package:flutter/material.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ExpensesView();
  }
}

class _ExpensesView extends StatefulWidget {
  const _ExpensesView({super.key});

  @override
  State<_ExpensesView> createState() => __ExpensesViewState();
}

class __ExpensesViewState extends State<_ExpensesView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: const Center(
        child: Text(
          'Expenses Page',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddExpenseView();
  }
}

class _AddExpenseView extends StatefulWidget {
  const _AddExpenseView({super.key});

  @override
  State<_AddExpenseView> createState() => __AddExpenseViewState();
}

class __AddExpenseViewState extends State<_AddExpenseView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(child: Text('Add Expense Page')),
    );
  }
}

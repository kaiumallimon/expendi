import 'package:flutter/material.dart';

class AddPaymentMethodPage extends StatelessWidget {
  const AddPaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddPaymentMethodView();
  }
}

class _AddPaymentMethodView extends StatefulWidget {
  const _AddPaymentMethodView({super.key});

  @override
  State<_AddPaymentMethodView> createState() => __AddPaymentMethodViewState();
}

class __AddPaymentMethodViewState extends State<_AddPaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: const Center(
        child: Text('Add Payment Method Page'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddCategoryView();
  }
}


class _AddCategoryView extends StatefulWidget {
  const _AddCategoryView({super.key});

  @override
  State<_AddCategoryView> createState() => __AddCategoryViewState();
}

class __AddCategoryViewState extends State<_AddCategoryView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: const Center(
        child: Text('Add Category Page'),
      ),
    );
  }
}

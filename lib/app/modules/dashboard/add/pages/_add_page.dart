import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddView();
  }
}

class _AddView extends StatefulWidget {
  const _AddView({super.key});

  @override
  State<_AddView> createState() => __AddViewState();
}

class __AddViewState extends State<_AddView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: .start,
        children: [],
      )
    );
  }
}

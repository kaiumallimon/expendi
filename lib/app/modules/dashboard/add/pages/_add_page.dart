import 'package:expendi/app/config/_theme.dart';
import 'package:expendi/app/shared/widgets/_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final List<Map<String, dynamic>> _menus = [
    {
      'icon': FontAwesomeIcons.moneyBillWave,
      'title': 'Expense',
      'subtitle': 'Add a new expense',
      'backgroundColor': AppTheme.primaryColor,
      'foregroundColor': Colors.white,
    },
    {
      'icon': FontAwesomeIcons.tags,
      'title': 'Category',
      'subtitle': 'Add a new category',
      'backgroundColor': AppTheme.secondaryColor,
      'foregroundColor': Colors.white,
    },
    {
      'icon': FontAwesomeIcons.creditCard,
      'title': 'Payment Method',
      'subtitle': 'Add a new payment method',
      'backgroundColor': AppTheme.tertiaryColor,
      'foregroundColor': Colors.black,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          /* AppBar */
          CustomAppBar(
            theme: theme,
            height: statusbarHeight,
            title: 'Create New',
            subtitle:
                'Create a new transaction or a new expense category or payment method here',
          ),
          /* Content Area */
          Expanded(
            child: ListView.builder(
              itemCount: _menus.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final menu = _menus[index];
                return GestureDetector(
                  onTap: () {
                    // Handle menu tap
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: menu['backgroundColor'],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: .center,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                menu['title'],
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: menu['foregroundColor'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                menu['subtitle'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: menu['foregroundColor'],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FaIcon(
                          menu['icon'],
                          color: menu['foregroundColor'].withAlpha(150),
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

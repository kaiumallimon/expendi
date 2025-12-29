import 'package:expendi/app/shared/widgets/_custom_appbar.dart';
import 'package:expendi/app/shared/widgets/_custom_button.dart';
import 'package:expendi/app/shared/widgets/_custom_colorpicker.dart';
import 'package:expendi/app/shared/widgets/_custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final TextEditingController _categoryNameController = .new();
  final TextEditingController _categoryIconController = .new();
  Color _selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusbarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: theme.colorScheme.onSurface,
      child: Column(
        children: [
          CustomAppBar(
            theme: theme,
            backgroundColor: theme.scaffoldBackgroundColor,
            foregroundColor: theme.colorScheme.onSurface,
            height: statusbarHeight + 10,
            title: 'Add Category',
            subtitle: 'Add a new expense category here',
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        CustomTextField(
                          width: double.infinity,
                          height: 60,
                          fillColor: theme.colorScheme.onPrimary.withAlpha(50),
                          label: 'Category Name',
                          hint: 'Enter category name',
                          borderColor: theme.colorScheme.onPrimary,
                          controller: _categoryNameController,
                          foregroundColor: theme.colorScheme.onPrimary
                        ),
                        const SizedBox(height: 8),
                        CustomColorPicker(
                          width: double.infinity,
                          height: 75,
                          label: 'Category Color',
                          selectedColor: _selectedColor,
                          fillColor: theme.colorScheme.onPrimary.withAlpha(50),
                          foregroundColor: theme.colorScheme.onPrimary,
                          onColorChanged: (color) {
                            // Handle color change
                            _selectedColor = color;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          width: double.infinity,
                          height: 60,
                          fillColor: theme.colorScheme.onPrimary.withAlpha(50),
                          foregroundColor: theme.colorScheme.onPrimary,
                          borderColor: theme.colorScheme.onPrimary,
                          label: 'Category Icon',
                          hint: 'Enter category icon emoji',
                          controller: _categoryIconController,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          width: double.infinity,
                          height: 60,
                          text: 'Add Category',
                          color: theme.colorScheme.onPrimary,
                          textColor: theme.colorScheme.primary,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

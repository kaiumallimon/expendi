import 'dart:ffi';

import 'package:expendi/app/modules/dashboard/add/logics/_add_category_cubit.dart';
import 'package:expendi/app/shared/widgets/_custom_appbar.dart';
import 'package:expendi/app/shared/widgets/_custom_button.dart';
import 'package:expendi/app/shared/widgets/_custom_colorpicker.dart';
import 'package:expendi/app/shared/widgets/_custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit()..init(),
      child: const _AddCategoryView(),
    );
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

  String? validateCategory(String? value) {
    if (_categoryNameController.text.isEmpty) {
      return 'Category name cannot be empty';
    }
    if (_categoryIconController.text.isEmpty) {
      return 'Category icon cannot be empty';
    }
    return null;
  }

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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                          foregroundColor: theme.colorScheme.onPrimary,
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
                        BlocBuilder<AddCategoryCubit, AddCategoryState>(
                          builder: (context, state) {
                            return CustomButton(
                              width: double.infinity,
                              height: 50,
                              text: 'Add Category',
                              color: theme.colorScheme.onPrimary,
                              textColor: theme.colorScheme.primary,
                              isLoading: state is AddCategoryLoading,
                              onPressed: () {
                                final validationMessage = validateCategory(
                                  null,
                                );
                                if (validationMessage != null) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierColor: theme.colorScheme.onSurface
                                        .withAlpha(150),
                                    builder: (context) => AlertDialog(
                                      title: Text('Error'),
                                      content: Text(validationMessage),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                context.read<AddCategoryCubit>().addCategory(
                                  name: _categoryNameController.text.trim(),
                                  icon: _categoryIconController.text.trim(),
                                  color:
                                      '#${_selectedColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                                );

                                _categoryNameController.clear();
                                _categoryIconController.clear();
                                
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),
                  BlocBuilder<AddCategoryCubit, AddCategoryState>(
                    builder: (context, state) {
                      if (state is AddCategoryLoading) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        );
                      } else if (state is AddCategorySuccess) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              'No categories found.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisSize: .min,
                            children: [
                              Text(
                                'Available Categories:',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...categories.map((category) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                      int.parse(
                                        category.color.replaceFirst(
                                          '#',
                                          '0xFF',
                                        ),
                                      ),
                                    ).withAlpha(50),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text(
                                          category.icon,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        category.name,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      } else if (state is AddCategoryFailure) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              'Error: ${state.errorMessage}',
                              style: TextStyle(
                                color: theme.colorScheme.onError,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
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

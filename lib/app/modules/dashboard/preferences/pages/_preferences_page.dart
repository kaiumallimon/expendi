import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/config/_theme.dart';
import 'package:expendi/app/modules/dashboard/preferences/logics/_preferences_cubit.dart';
import 'package:expendi/app/repositories/local/_hive_service.dart';
import 'package:expendi/app/shared/widgets/_custom_appbar.dart';
import 'package:expendi/app/shared/widgets/_custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferencesCubit()..init(),
      child: const _PreferencesView(),
    );
  }
}

class _PreferencesView extends StatefulWidget {
  const _PreferencesView({super.key});

  @override
  State<_PreferencesView> createState() => __PreferencesViewState();
}

class __PreferencesViewState extends State<_PreferencesView> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> menus = [
    {
      'title': 'Update Profile',
      'subtitle': 'Edit your personal information',
      'icon': FontAwesomeIcons.userPen,
      'onTap': () {},
      'backgroundColor': AppTheme.primaryColor,
      'foregroundColor': Colors.white,
    },
    {
      'title': 'Categories',
      'subtitle': 'Manage your expense categories',
      'icon': FontAwesomeIcons.tags,
      'onTap': () {},
      'backgroundColor': AppTheme.tertiaryColor,
      'foregroundColor': Colors.black,
    },
    {
      'title': 'Payment Methods',
      'subtitle': 'Manage your payment methods',
      'icon': FontAwesomeIcons.creditCard,
      'onTap': () {},
      'backgroundColor': CupertinoColors.activeGreen,
      'foregroundColor': Colors.white,
    },
    {
      'title': 'Change Password',
      'subtitle': 'Update your account password',
      'icon': FontAwesomeIcons.lock,
      'onTap': () {},
      'backgroundColor': CupertinoColors.activeBlue,
      'foregroundColor': Colors.white,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  double _headerVisibility() {
    if (!_scrollController.hasClients) return 1.0;

    final offset = _scrollController.offset;
    // Handle negative offsets (overscroll bounce at top)
    if (offset <= 0) return 1.0;

    // Use a threshold - once past 30px, stay hidden
    if (offset >= 30) return 0.0;

    // Smooth transition from 0 to 30px
    final value = 1 - (offset / 30);
    return value.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (context, state) {
        if (state is PreferencesLoading) {
          return Center(
            child: CupertinoActivityIndicator(color: theme.colorScheme.primary),
          );
        } else if (state is PreferencesFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          final user = (state as PreferencesSuccess).user;
          // final visibility = _headerVisibility();

          return Container(
            color: theme.colorScheme.onSurface,
            child: Column(
              children: [
                // AppBar Section with User Info
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: theme.colorScheme.surface.withAlpha(20),
                    //       blurRadius: 100,
                    //       spreadRadius: 10,
                    //       offset: const Offset(0, 50),
                    //     ),
                    //   ],
                    // ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Picture with smooth fade and size animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 120,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(30),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              user.fullName.isNotEmpty
                                  ? user.fullName[0].toUpperCase()
                                  : '',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Gap with smooth height animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 16,
                      ),

                      Center(
                        child: Text(
                          user.fullName,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          user.email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodyMedium?.color?.withAlpha(
                              150,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // navigation menus
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        sliver: SliverList.builder(
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
                            final menu = menus[index];
                            return Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          menu['title'],
                                          style: theme.textTheme.headlineSmall
                                              ?.copyWith(
                                                color: menu['foregroundColor'],
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          menu['subtitle'],
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: menu['foregroundColor'],
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FaIcon(
                                    menu['icon'],
                                    color: menu['foregroundColor'].withAlpha(
                                      150,
                                    ),
                                    size: 25,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton(
                            width: double.infinity,
                            height: 50,
                            color: Colors.red,
                            textColor: Colors.white,
                            text: 'Logout',
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierColor: theme.colorScheme.onSurface
                                    .withAlpha(150),
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Logout'),
                                    content: const Text(
                                      'Are you sure you want to logout?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                          ).pop(); // Close dialog
                                        },
                                        child: Text('Cancel', style: TextStyle(color: Colors.black), ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await ApiClient().clearTokens().then((
                                            _,
                                          ) async {
                                            await HiveService(
                                              'user_data',
                                            ).clear();
                                            if (context.mounted) {
                                              context.go('/login');
                                            }
                                          });
                                        },
                                        child: Text('Logout', style: TextStyle(color: Colors.red), ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

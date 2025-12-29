import 'package:expendi/app/clients/_dio_client.dart';
import 'package:expendi/app/modules/dashboard/preferences/logics/_preferences_cubit.dart';
import 'package:expendi/app/repositories/local/_hive_service.dart';
import 'package:expendi/app/shared/widgets/_custom_appbar.dart';
import 'package:expendi/app/shared/widgets/_custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusbarHeight = MediaQuery.of(context).padding.top;
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
          return Container(
            color: theme.colorScheme.onSurface,
            // padding: EdgeInsets.only(left: 16, right: 16, top: statusbarHeight + 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : '', style: theme.textTheme.headlineLarge),
                        ),
                      ),
                    ],
                  ),
                ),

                // CustomAppBar(theme: theme, height: statusbarHeight, title: 'Preferences', subtitle: 'Manage your preferences here')

                // CustomButton(
                //   width: double.infinity,
                //   height: 50,
                //   text: 'Logout',
                //   onPressed: () async {
                //     await ApiClient().clearTokens().then((_) async {
                //       await HiveService('user_data').clear();
                //       if (context.mounted) {
                //         context.go('/login');
                //       }
                //     });
                //   },
                // ),
              ],
            ),
          );
        }
      },
    );
  }
}

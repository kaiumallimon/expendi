import 'package:expendi/app/modules/splash/logics/_splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/_app_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..loadApp(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if(state is SplashLoaded){
            context.go(state.redirectedRoute);
          }

          if(state is SplashError){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
          }
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisSize: .min,
                  children: [AppLogo(size: 120)],
                ),
              ),

              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CupertinoActivityIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


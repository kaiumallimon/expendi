import 'package:expendi/app/config/_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// import 'package:usuite/app/services/local/_hive_service.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index != navigationShell.currentIndex,
    );
  }

  List<Map<String, dynamic>> get _navBarItems => [
    {
      'icon': FontAwesomeIcons.house,
      'activeIcon': FontAwesomeIcons.solidHouse,
      'label': 'Home',
      'route': '/home',
    },
    {
      'icon': FontAwesomeIcons.plus,
      'activeIcon': FontAwesomeIcons.plus,
      'label': 'Add',
      'route': '/add',
    },
    {
      'icon': FontAwesomeIcons.wallet,
      'activeIcon': FontAwesomeIcons.wallet,
      'label': 'Expenses',
      'route': '/expenses',
    },
    {
      'icon': FontAwesomeIcons.gear,
      'activeIcon': FontAwesomeIcons.gear,
      'label': 'Settings',
      'route': '/preferences',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final windowSize = MediaQuery.sizeOf(context);
    final bottomNavbarSize = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: theme.colorScheme.onSurface,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Container(
                decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
                child: navigationShell,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: bottomNavbarSize + 10,
              bottom: bottomNavbarSize,
            ),
            margin: EdgeInsets.only(bottom: bottomNavbarSize),
            decoration: BoxDecoration(color: theme.colorScheme.onSurface),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_navBarItems.length, (index) {
                final item = _navBarItems[index];
                final isSelected = index == navigationShell.currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surface.withAlpha(50),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () => _onDestinationSelected(index),
                    icon: FaIcon(
                      isSelected ? item['activeIcon'] : item['icon'],
                      color: isSelected ? theme.colorScheme.onSurface : theme.colorScheme.surface.withAlpha(120),
                      size: 28,
                    ),
                    tooltip: item['label'],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

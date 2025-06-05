import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/router/app_router.gr.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

@RoutePage(name: 'DashboardRouter')
class DashboardRouter extends StatelessWidget {
  const DashboardRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const SettingsScreenRoute(),
        const OtherSettingsScreenRoute(),
        const EmptyRoute(),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButtonBuilder: (context, tabsRouter) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: padHM,
            child: PlatformFloatingBottomBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              inActiveColor: Theme.of(context).colorScheme.onSecondary,
              activeColor: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(kToolbarHeight),
              indicatorType: TabIndicatorType.roundedRectangle,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Settings',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'SettingsV2',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.mic_none),
                  label: 'Void',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

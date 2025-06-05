import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'EmptyRoute')
class EmptyRouteScreen extends StatelessWidget {
  const EmptyRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

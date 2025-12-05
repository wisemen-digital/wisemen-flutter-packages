import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ultra_playground/assets/assets.dart';
import 'package:flutter_ultra_playground/flavors.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(84),
                child: Image.asset(
                  // TODO(Anyone): Add splash image asset
                  AppAssets.splashImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (F.config?.splashImage != null)
            Positioned.fill(
              child: CachedNetworkImage(imageUrl: F.config?.splashImage ?? '', fit: BoxFit.cover),
            ),
        ],
      ),
    );
  }
}

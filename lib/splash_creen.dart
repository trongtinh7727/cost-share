import 'package:cost_share/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashCreen extends StatelessWidget {
  const SplashCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.image.svg.launchScreen.svg();
  }
}

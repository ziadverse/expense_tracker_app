import 'package:expense_tracker_app/app/routing/app_routes.dart';
import 'package:expense_tracker_app/core/constants/constant_assets.dart';
import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      2.sec,
      () => setState(() {
        isLoading = true;
      }),
    );
    Future.delayed(5.sec, () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          SizedBox(width: .infinity),
          Image.asset(ConstantAssets.logo2),
          18.vGap,
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF1FD6D9),
                Color(0xFF1FD6D9),
                Color(0xFF6B3FA0),
                Color(0xFF6B3FA0),
              ],
              stops: [0.0, 0.35, 0.65, 1.0],
            ).createShader(bounds),
            child: Text("Expense Tracker", style: TextStyle(fontSize: 42, fontWeight: .bold)),
          ),
          18.vGap,
          if (isLoading)
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1FD6D9),
              rightDotColor: const Color(0xFF6B3FA0),
              size: 50,
            ),
        ],
      ),
    );
  }
}

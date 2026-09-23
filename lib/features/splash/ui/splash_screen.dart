import 'package:expense_tracker_app/app/routes/app_routes.dart';
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
  bool showLoading = false;

  @override
  void initState() {
    Future.delayed(1.sec, () {
      setState(() {
        showLoading = true;
      });
    });
    Future.delayed(4.sec, () {
      if (mounted){
        Navigator.of(context).pushNamed(AppRoutes.home);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          Image.asset(ConstantAssets.icon),
          SizedBox(width: .infinity),
          if (showLoading) LoadingAnimationWidget.staggeredDotsWave(
            color: Color(0xFF5B2C8D),
            size: 200,
          ),
        ],
      )
    );
  }
}

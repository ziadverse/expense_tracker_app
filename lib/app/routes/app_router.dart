import 'package:expense_tracker_app/app/routes/app_routes.dart';
import 'package:expense_tracker_app/features/home/data/models/Transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/user_model.dart';
import 'package:expense_tracker_app/features/home/ui/home_screen.dart';
import 'package:expense_tracker_app/features/splash/ui/splash_screen.dart';
import 'package:expense_tracker_app/features/transactor/ui/transactor_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static Route? onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.transactor:
        return MaterialPageRoute<bool>(builder: (_) => TransactorScreen(model: settings.arguments as TransactionModel?, user: settings.arguments as UserModel?));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sen_ap_app/core/constants/app_strings.dart';
import 'package:sen_ap_app/core/router/app_router.dart';
import 'package:sen_ap_app/core/theme/app_theme.dart';
import 'package:sen_ap_app/features/nutrition/presentation/providers/nutrition_provider.dart';
import 'package:sen_ap_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:sen_ap_app/features/progress/presentation/providers/progress_provider.dart';
import 'package:sen_ap_app/features/weight/presentation/providers/weight_provider.dart';

class SenApApp extends StatelessWidget {
  const SenApApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => WeightProvider()),
        ChangeNotifierProvider(create: (_) => NutritionProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: appRouter,
      ),
    );
  }
}

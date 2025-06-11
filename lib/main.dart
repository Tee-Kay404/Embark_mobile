import 'package:Embark_mobile/app/theme/theme.dart';
import 'package:Embark_mobile/app/theme/theme_provider.dart';
import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/feature/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Future.delayed(Duration(seconds: 2));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => CounterProvider()),
  ], child: const MyApp()));
  //
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeMode = themeProvider.themeMode == ThemeMode.system
        ? ThemeMode.light
        : themeProvider.themeMode;
    return ScreenUtilInit(
      designSize: const Size(411.43, 892.57),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: AppTheme().lightMode,
          darkTheme: AppTheme().darkMode,
          themeMode: themeMode,
          onGenerateRoute: onGenerateRoute,
          initialRoute: PageRoutes.introPage.name,
        );
      },
    );
  }
}

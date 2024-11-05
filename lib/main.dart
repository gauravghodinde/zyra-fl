import 'package:zyra/pages/splash/splash_screen.dart';
import 'package:zyra/providers/DeliveryLocationProvider.dart';
import 'package:zyra/providers/RepairReqestProvider.dart';
import 'package:zyra/providers/categoryProvider.dart';
import 'package:zyra/providers/locationListProvider.dart';
import 'package:zyra/providers/locationProvider.dart';
import 'package:zyra/providers/productProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zyra/utils/uitheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CategoryListProvider()),
      ChangeNotifierProvider(create: (_) => ProductListProvider()),
      ChangeNotifierProvider(create: (_) => LocationListProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => DeliveryLocationProvider()),
      ChangeNotifierProvider(create: (_) => RepairRequestListProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zyra',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}

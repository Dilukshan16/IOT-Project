import 'package:flutter/material.dart';
import 'package:waste_management_app/pages/login_screen.dart';
import 'package:waste_management_app/pages/dashboard_screen.dart';
import 'package:waste_management_app/pages/full_bins_screen.dart';
import 'package:waste_management_app/pages/routes_screen.dart';
import 'package:waste_management_app/pages/notifications_screen.dart';
import 'package:waste_management_app/pages/bin_details_screen.dart';

void main() {
  runApp(const WasteManagementApp());
}

class WasteManagementApp extends StatelessWidget {
  const WasteManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/bins': (context) => const FullBinsScreen(),
        '/routes': (context) => const RoutesScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/bin-details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return BinDetailsScreen(
            binId: args['binId'],
            binNumber: args['binNumber'],
            location: args['location'],
            fillLevel: args['fillLevel'],
            image: args['image'],
            weight: args['weight'],
            wasteType: args['wasteType'],
            lastUpdate: args['lastUpdate'],
            coordinates: args['coordinates'],
          );
        },
      },
    );
  }
}
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/route/router_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  // setUrlStrategy(PathUrlStrategy());
  await Supabase.initialize(
    url: 'https://xeannllsijuvfdjasizd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhlYW5ubGxzaWp1dmZkamFzaXpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYyNzEzMzIsImV4cCI6MjA1MTg0NzMzMn0.Svr8d3PbYF3__S5tMLb6uzg7tiZx-w8bcmsSOPJIpzY',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MainApp(), // Wrap your app
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouteConfig().router,
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double width = MediaQuery.sizeOf(context).width;

  double scaleFactor = width / 600;
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

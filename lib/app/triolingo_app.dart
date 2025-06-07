import 'package:flutter/material.dart';
import 'res/res.dart';

class TriolingoApp extends StatelessWidget {
  const TriolingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 45),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: theme,
        onGenerateRoute: (routeSettings) => MaterialPageRoute(
            builder: routes[routeSettings.name]!, settings: routeSettings),
      ),
    );
  }
}

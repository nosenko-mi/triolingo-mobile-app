import 'package:flutter/material.dart';
import 'home_page_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'HomePage';

  @override
  State<HomePage> createState() => HomePageState();
}
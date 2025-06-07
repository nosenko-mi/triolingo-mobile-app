import 'package:flutter/material.dart';
import '../../ui/ui.dart';


final Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginPage(),
    '/registration': (context) => RegistrationPage(),
    '/home': (context) => HomePage(),
    '/quiz': (context) => QuizPage(),
    '/results': (context) => ResultsPage(),
    '/ebook_catalog/ebook': (context) => EbookPage(),
    '/ebook_catalog': (context) => EbookCatalogPage()
  };
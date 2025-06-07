import 'dart:async';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';
import 'package:triolingo/app/ui/books_catalog/widget/ebook_item.dart';

class EbookCatalogPageState extends State<EbookCatalogPage> {
  final Map<String, EpubBook?> pathsEbooks = {
    'assets/ebooks/avontuurtjes_by_carry_van_bruggen.epub': null,
    'assets/ebooks/honesty_the_best_policy_or_the_history_of_roger_by_anonymous.epub':
        null,
    'assets/ebooks/kertomisen_taito_by_jakob_wassermann.epub': null,
    'assets/ebooks/peppermint_by_alice_henkel.epub': null,
    'assets/ebooks/the_dinky_ducklings_by_lang_campbell.epub': null
  };

  Timer? loading;

  @override
  void initState() {
    loading = Timer(const Duration(seconds: 2, milliseconds: 500), () {
      _loadEbooks().whenComplete(() {
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 32),
        title: Text(
          labelEbookCatalog,
          style: const TextStyle(color: Colors.white, fontSize: 32),
        ),
      ),
      body: _getListOrProgressBar(),
    );
  }

  Widget _getListOrProgressBar() {
    if (!pathsEbooks.values.contains(null)) {
      return ListView.builder(
        itemBuilder: (context, index) => _buildEbookItem(context, index),
        itemCount: pathsEbooks.length,
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  EbookItem _buildEbookItem(BuildContext context, int index) {
    String path = pathsEbooks.keys.elementAt(index);
    return EbookItem(
      ebook: pathsEbooks[path]!,
      path: path,
    );
  }

  

  Future<Null> _loadEbooks() async {
    //Future.delayed(Duration(seconds: 3));
    for (String path in pathsEbooks.keys) {
      pathsEbooks[path] = await loadEpubFromAssets(path);
    }
  }

  @override
  void dispose() {
    loading?.cancel();
    super.dispose();
  }
}

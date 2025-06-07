import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:triolingo/app/app.dart';

class EbookPageState extends State<EbookPage> {
  late EpubController _epubController;
  String path = '';

  @override
  void didChangeDependencies() {
    path = ModalRoute.of(context)?.settings.arguments as String;
    _epubController = EpubController(
      // Load document
      document: EpubDocument.openAsset(path),
      // Set start point
      epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
    );
    loadEpubFromAssets(path).then((ebook) {
      debugPrint(ebook.Chapters.toString());
      debugPrint(cleanText(ebook.Chapters![2].HtmlContent!) );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // Show actual chapter name
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapterValue) => Text(
            '$placeholder_chapter: ${chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''}',
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      // Show table of contents
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController,
        ),
      ),
      // Show epub document
      body: EpubView(
        controller: _epubController,
        // onChapterChanged: (value) {
        //   debugPrint(value?.chapter?.HtmlContent);
        // },
      ),
    );
  }
}

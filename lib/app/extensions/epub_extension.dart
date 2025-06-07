import 'package:epubx/epubx.dart';
import 'package:flutter/services.dart';
import 'package:triolingo/app/app.dart';

extension EpubExtension on EpubBook {

  String? extractFirstParagraph() {
    for (var chapter in Chapters!) {
      String? html = chapter.HtmlContent;
      if (html != null && html.isNotEmpty) {
        final match =
            RegExp(r'<p[^>]*>(.*?)</p>', dotAll: true).firstMatch(html);
        if (match != null) {
          String paragraph = match.group(1)!;
          return cleanText(paragraph);
        }
      }
    }
    return null;
  }
}

Future<EpubBook> loadEpubFromAssets(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  Uint8List bytes = data.buffer.asUint8List();

  return await EpubReader.readBook(bytes);
}
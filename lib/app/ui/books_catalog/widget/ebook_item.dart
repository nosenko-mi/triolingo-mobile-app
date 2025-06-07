import 'dart:math';
import 'dart:typed_data';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/image.dart' as image;
import 'package:flutter_svg/svg.dart';
import 'package:triolingo/app/app.dart';
import 'package:triolingo/core/core.dart';

class EbookItem extends StatelessWidget {
  const EbookItem({super.key, required this.ebook, required this.path});

  final String path;
  final EpubBook ebook;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/ebook_catalog/ebook', arguments: path);
            },
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return QuizLoadingBottomSheet();
                  });

              String? fragment = _getTextForPrompt();
              debugPrint(fragment);
              if (fragment.isNotEmpty) {
                coreApi
                    .sendFragmentRequest(fragment: fragment)
                    .then((response) {
                  if (response is Success<QuizResponse> && context.mounted) {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushNamed('/quiz', arguments: response.data);
                        
                  } else if (response is Error && context.mounted) {
                    _makeDefaultRequest(context);
                  }

                });
              } else {
                _makeDefaultRequest(context);
              }
            },
            title: Text(
              ebook.Title ?? 'Unknown',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              ebook.Author ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            leading: _getBookCover(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBookCover() {
    Uint8List? bytes = ebook.CoverImage?.data.buffer.asUint8List();
    return bytes != null
        ? image.Image.memory(bytes)
        : SvgPicture.asset(
            'assets/icons/ic_quiz_type_book.svg',
            height: 30,
            width: 30,
          );
  }

  String _getTextForPrompt() {
    String textFromRandomChapter = _getRandomChapterText();
    if (textFromRandomChapter.isNotEmpty) {
      String textFromRandomParagraph =
          _getRandomParagraph(textFromRandomChapter);
      if (textFromRandomParagraph.isNotEmpty) {
        return textFromRandomParagraph;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  String _getRandomChapterText() {
    EpubChapter? chapter = ebook.Chapters?.takeRandom();
    if (chapter != null) {
      return cleanText(chapter.HtmlContent!);
    } else {
      return '';
    }
  }

  String _getRandomParagraph(String text) {
    // Розбиваємо текст на абзаци (роздільник — подвійний перенос рядка)
    List<String> paragraphs = text
        .split(RegExp(r'\n{2,}')) // два або більше переноси
        .map((p) => p.trim())
        .where(
            (p) => p.isNotEmpty && p.length > 30) // ігнорувати короткі/порожні
        .toList();

    if (paragraphs.length < 3) {
      return ''; // замало для вибору середнього
    }

    // Вибираємо випадковий абзац не з початку і не з кінця
    final middleRange = paragraphs.sublist(1, paragraphs.length - 1);
    final random = Random();
    return middleRange[random.nextInt(middleRange.length)];
  }

  void _makeDefaultRequest(BuildContext context) =>
      coreApi.getQuizzesRequest().then((response) {
        if(context.mounted) {
          Navigator.pop(context);
        }
        if (response is Success<QuizResponse> && context.mounted) {
          Navigator.of(context).pushNamed('/quiz', arguments: response.data);
        } else if (response is Error && context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(response.meta.message ?? textGetQuizzesError),
            ),
          );
        }
      });
}

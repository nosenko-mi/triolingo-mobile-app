import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:triolingo/app/app.dart';
import 'package:triolingo/core/core.dart';

class HomePageItem extends StatelessWidget {
  const HomePageItem({super.key, required this.data});

  final HomePageItemData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: data.itemColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () {
              switch (data.type) {
                case QuizType.TEST:
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return QuizLoadingBottomSheet();
                      });

                  coreApi.getQuizzesRequest().then((response) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    if (response is Success<QuizResponse> && context.mounted) {
                      Navigator.of(context)
                          .pushNamed('/quiz', arguments: response.data);
                    } else if (response is Error && context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                              response.meta.message ?? textGetQuizzesError),
                        ),
                      );
                    }
                  });

                case QuizType.EBOOK:
                  Navigator.of(context).pushNamed('/ebook_catalog');
                case QuizType.DEFAULT:
              }
            },
            title: Text(
              data.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              data.subtitle,
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
            leading: SvgPicture.asset(
              'assets/icons/ic_quiz_type_book.svg',
              height: 30,
              width: 30,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}

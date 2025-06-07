// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../../app.dart';

// TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// action in the IDE, or press "p" in the console), to see the
// wireframe for each widget.

class HomePageState extends State<HomePage> {
  List<HomePageItemData> items = [];
  String name = '';

  HomePageState() {
    items.add(HomePageItemData(
        title: textQuizTitleTest,
        subtitle: textQuizSubtitleTest,
        type: QuizType.TEST,
        itemColor: Colors.green));
    items.add(HomePageItemData(
        title: textEbookTitleTest,
        subtitle: textEbookSubtitleTest,
        type: QuizType.EBOOK,
        itemColor: Colors.indigo));
    items.add(HomePageItemData(
        title: textAvailableSoon,
        subtitle: textAvailableSoon,
        type: QuizType.DEFAULT,
        itemColor: Colors.amber));
  }

  @override
  void initState() {
    super.initState();
    appSettings.getUserEmail().then((email) {
      setState(() {
        name = email ?? '';
      });
    });
  }

  HomePageItem _buildItem(context, i) => HomePageItem(data: items[i]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          labelHomePageTitle,
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () {
              appSettings.truncate().then((_) {
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Вітаю, $name',
                style: TextStyle(fontSize: 36, color: Colors.black),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 50, right: 20),
          //     child:
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 160),
            child: ListView.builder(
              itemBuilder: _buildItem,
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageItemData {
  String title;
  String subtitle;
  QuizType type;
  Color itemColor;

  HomePageItemData({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.itemColor,
  });
}

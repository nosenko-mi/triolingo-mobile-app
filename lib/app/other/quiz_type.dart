enum QuizType {
  TEST(type: 'test'),
  EBOOK(type: 'ebook'),
  DEFAULT(type: 'default');

  final String type;

  const QuizType({
    required this.type,
  });
}

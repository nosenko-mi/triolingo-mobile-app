import 'package:triolingo/core/core.dart';

class GetQuizzesAction {

  Future<TriolingoResponse<QuizResponse>> sendGetQuizzesRequest() async {

    final response = await triolingoApi.getApi().get(QUIZ_API_PATH,
        queryParameters: {'source' : 'test'});

    final Meta meta = Meta.parseMeta(response: response);

    // // TODO: remove this mock
    // String jsonString = await rootBundle.loadString('assets/json/quiz.json');
    // Map<String, dynamic> jsonData = fromJson(jsonString);
    // response.data = jsonData;

    if (isSuccessMeta(meta: meta)) {
      return Success<QuizResponse>(
          QuizResponse.fromResponse(response: response, meta: meta));
    } else {
      if (response.data is String) {
        meta.message = response.data as String;
      } else if (response.data is Map<String, dynamic>) {
        meta.message = (response.data as Map<String, dynamic>)['message'];
      } else {
        meta.message = response.data.toString();
      }

      return Error(meta);
    }
  }
  
}
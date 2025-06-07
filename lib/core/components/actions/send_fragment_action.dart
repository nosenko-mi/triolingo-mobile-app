import 'package:triolingo/core/core.dart';

class SendFragmentAction {

  Future<TriolingoResponse<QuizResponse>> sendFragmentRequest(
      {required String fragment}) async {

    final response = await triolingoApi.getApi().post(SEND_FRAGMENT_PATH,
        data: toJson({'fragment' : fragment}));

    final Meta meta = Meta.parseMeta(response: response);

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
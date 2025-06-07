import 'package:triolingo/core/core.dart';

class RegistrationAction {
  Future<TriolingoResponse<RegistrationResponse>> sendRegistrationRequest(
      {required String email, required String password}) async {
        
    final response = await triolingoApi.getApi().post(REGISTER_API_PATH,
        data: RegistartionRequest(email: email, password: password).toJson());

    final Meta meta = Meta.parseMeta(response: response);

    if (isSuccessMeta(meta: meta)) {
      return Success<RegistrationResponse>(
          RegistrationResponse.fromResponse(response: response, meta: meta));
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

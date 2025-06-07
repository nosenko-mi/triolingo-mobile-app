import 'package:triolingo/core/components/actions/get_quizzes_action.dart';
import 'package:triolingo/core/components/actions/send_fragment_action.dart';

import 'bean/bean.dart';
import 'components/components.dart';

final coreApi = CoreApi();

class CoreApi {
  final LoginAction _loginAction = LoginAction();
  final RegistrationAction _registrationAction = RegistrationAction();
  final GetQuizzesAction _getQuizzesAction = GetQuizzesAction();
  final SendFragmentAction _sendFragmentAction = SendFragmentAction();

  Future<TriolingoResponse<LoginResponse>> loginRequest(
          {required String email, required String password}) =>
      _loginAction.sendLoginRequest(email: email, password: password);

  Future<TriolingoResponse<RegistrationResponse>> registrationRequest(
          {required String email, required String password}) =>
      _registrationAction.sendRegistrationRequest(
          email: email, password: password);

  Future<TriolingoResponse<QuizResponse>> getQuizzesRequest() =>
      _getQuizzesAction.sendGetQuizzesRequest();

  Future<TriolingoResponse<QuizResponse>> sendFragmentRequest(
          {required String fragment}) =>
      _sendFragmentAction.sendFragmentRequest(fragment: fragment);
}

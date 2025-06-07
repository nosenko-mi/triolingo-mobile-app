
import 'package:dio/dio.dart';
import 'package:triolingo/core/components/rest/triolingo_interceptor.dart';
import 'package:triolingo/core/core.dart';

final triolingoApi = HttpCommunicationComponent();

class HttpCommunicationComponent {
  
  final Dio _triolingoApi = Dio(baseNetworkOptions);

  HttpCommunicationComponent() {
    _triolingoApi.interceptors.add(TriolingoInterceptor());
  }

  Dio getApi() => _triolingoApi;
  
}

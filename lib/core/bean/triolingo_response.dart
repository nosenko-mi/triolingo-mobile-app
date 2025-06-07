import 'bean.dart';

sealed class TriolingoResponse<T> {}

class Success<T> extends TriolingoResponse<T> {
  final T data;
  Success(this.data);
}

class Error extends TriolingoResponse<Never> {
  final Meta meta;
  Error(this.meta);
}
import 'dart:math';

extension ListExtension on List {
  T takeRandom<T>() => this[Random().nextInt(length)];
}
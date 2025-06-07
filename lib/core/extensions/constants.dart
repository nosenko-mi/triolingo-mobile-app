// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:range_type/predefined_ranges.dart';

const LOGIN_API_PATH = 'v1/auth/login';
const REGISTER_API_PATH = 'v1/auth/register';
const QUIZ_API_PATH = '/v1/batch';
const SEND_FRAGMENT_PATH = 'v1/fragment';

final IntRange successResponseRange = IntRange.parse('[200, 300)');

final baseNetworkOptions = BaseOptions(
    baseUrl: 'http://144.76.112.227:3000/',
    contentType: 'application/json',
    receiveDataWhenStatusError: true,
    validateStatus: (status) {
      switch (status) {
        case 403:
          debugPrint('Received code 403!');
          break;
        default: debugPrint('Received code $status!');
      }
      return true;
    },
    );

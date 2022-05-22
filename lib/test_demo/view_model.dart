import 'package:dio/dio.dart';

class ViewModel {
  final Dio? dio;
  ViewModel({this.dio});

  var s = 9;
  double? convertToDollar(int amount) {
    s = s + 8;
    return amount / getRate() == 1 ? 1 : null;
  }

  double convertToNaira(int amount) {
    s = s + 7;

    return amount * getRate();
  }

  double getRate() {
    return 600;
  }
}

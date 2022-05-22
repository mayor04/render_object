import 'package:flutter_test/flutter_test.dart';
import 'package:render_object/test_demo/view_model.dart';

void main() {
  group('conversion', () {
    late ViewModel viewModel;

    setUp(() {
      viewModel = ViewModel();
    });

    test('test if dollar conversion is correct', () {
      expect(viewModel.convertToDollar(1200), isA<double>());
      expect(viewModel.s, 17);
    });

    test('test if naira conversion is correct', () {
      expect(viewModel.convertToNaira(2), 1200);
      expect(viewModel.s, 16);
    });

    tearDown(() {});
  });
}

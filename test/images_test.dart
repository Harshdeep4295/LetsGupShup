import 'dart:io';

import 'package:letsgupshup/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('images assets test', () {
    expect(true, File(Images.googleIcon).existsSync());
  });
}

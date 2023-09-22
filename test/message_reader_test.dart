import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main(){
  test('I can read a text file.', (){
    final file = File('test/message.txt');
    final string = file.readAsStringSync();
    expect(string, equals('This is the text that we will initially test.'));
  });
}
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_media_store/android_media_store.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_media_store');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AndroidMediaStore.platformVersion, '42');
  });
}

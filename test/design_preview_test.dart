import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nesadate/main.dart';

Future<void> _loadFonts() async {
  final loader = FontLoader('PlusJakartaSans');
  for (final file in const [
    'assets/fonts/PlusJakartaSans-Regular.ttf',
    'assets/fonts/PlusJakartaSans-Medium.ttf',
    'assets/fonts/PlusJakartaSans-SemiBold.ttf',
    'assets/fonts/PlusJakartaSans-Bold.ttf',
    'assets/fonts/PlusJakartaSans-ExtraBold.ttf',
  ]) {
    loader.addFont(rootBundle.load(file));
  }
  await loader.load();
}

Future<void> _shoot(
  WidgetTester tester,
  String name,
  Widget screen, {
  bool settle = true,
}) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.pale,
        fontFamily: 'PlusJakartaSans',
      ),
      home: screen,
    ),
  );
  await tester.pump();
  if (settle) await tester.pump(const Duration(milliseconds: 400));
  await tester.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  });
  await tester.pump();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$name.png'),
  );
  await tester.pump(const Duration(seconds: 2));
}

void main() {
  setUpAll(_loadFonts);

  testWidgets('splash', (tester) async {
    await _shoot(tester, '01_splash', const SplashScreen(), settle: false);
  });
  testWidgets('signup', (tester) async {
    await _shoot(tester, '02_signup', const RegisterScreen());
  });
  testWidgets('login', (tester) async {
    await _shoot(tester, '03_login', const LoginScreen());
  });
  testWidgets('basic info', (tester) async {
    await _shoot(tester, '04_basic_info', const BasicInfoScreen());
  });
  testWidgets('campus', (tester) async {
    await _shoot(tester, '05_campus', const CampusScreen());
  });
  testWidgets('interests', (tester) async {
    await _shoot(tester, '06_interests', const InterestsScreen());
  });
  testWidgets('photo profile', (tester) async {
    await _shoot(tester, '07_photo_profile', const PhotoProfileScreen());
  });
  testWidgets('home', (tester) async {
    await _shoot(tester, '08_home', const HomeScreen());
  });
  testWidgets('notification', (tester) async {
    await _shoot(tester, '09_notification', const NotificationScreen());
  });
  testWidgets('discover', (tester) async {
    await _shoot(tester, '10_discover', const MainShell(initial: 2));
  });
  testWidgets('matched', (tester) async {
    await _shoot(
      tester,
      '11_matched',
      const MatchedScreen(matchedName: 'Alya'),
    );
  });
  testWidgets('chat', (tester) async {
    await _shoot(tester, '12_chat', const MainShell(initial: 3));
  });
  testWidgets('chat room', (tester) async {
    await _shoot(tester, '14_chat_room', const ChatRoomScreen());
  });
  testWidgets('likes', (tester) async {
    await _shoot(tester, '15_likes', const MainShell(initial: 1));
  });
  testWidgets('profile', (tester) async {
    await _shoot(tester, '16_profile', const MainShell(initial: 4));
  });
}

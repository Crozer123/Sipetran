import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sipetran/main.dart';

void main() {
  testWidgets('Full Auth Flow and Dashboard smoke test', (WidgetTester tester) async {
    // 1. Launch app (SplashScreen)
    await tester.pumpWidget(const MyApp());
    expect(find.text('SIPETRAN'), findsOneWidget);

    // 2. Advance past splash timer → OnboardingScreen
    await tester.pumpAndSettle(const Duration(milliseconds: 2600));
    expect(find.text('Masuk'), findsOneWidget);

    // 3. Tap 'Masuk' → LoginScreen
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Silakan masuk dengan username Anda'), findsOneWidget);

    // 4. Try logging in with unknown username
    await tester.enterText(find.widgetWithText(TextFormField, 'Username'), 'unknown');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Username belum terdaftar! Silakan daftar terlebih dahulu.'), findsOneWidget);

    // 5. Switch to Daftar tab
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(find.text('Silakan buat akun baru dengan username'), findsOneWidget);

    // 6. Register 'user123' → navigates to Dashboard
    await tester.enterText(find.widgetWithText(TextFormField, 'Username Baru'), 'user123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Daftar'));
    await tester.pumpAndSettle();

    // 7. Verify Dashboard shows username and key widgets
    expect(find.text('user123'), findsOneWidget);
    expect(find.text('Produk'), findsOneWidget);
    expect(find.text('PHBS'), findsOneWidget);
  });
}

import 'package:adrian_messages_app/models/models.dart';
import 'package:adrian_messages_app/providers/auth_provider.dart';
import 'package:adrian_messages_app/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:adrian_messages_app/features/auth/data/auth_repository.dart';

class _FakeAuthRepo implements AuthRepository {
  UserModel? _user;

  @override
  UserModel? get currentUser => _user;

  @override
  Future<UserModel?> restoreSession() async => null;

  @override
  Future<UserModel> signIn({required String username, required String password}) async {
    _user = UserModel(
      id: 'u1',
      username: username,
      displayName: username,
      createdAt: DateTime(2020, 1, 1),
    );
    return _user!;
  }

  @override
  Future<UserModel> signUp({required String username, required String password}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    _user = null;
  }
}

void main() {
  testWidgets('SignInScreen validates and signs in', (tester) async {
    final router = GoRouter(
      initialLocation: '/sign-in',
      routes: [
        GoRoute(
          path: '/sign-in',
          builder: (_, __) => const SignInScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (_, __) => const Scaffold(body: Text('Home')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(_FakeAuthRepo()),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    // Enter invalid username first
    await tester.enterText(find.byType(TextFormField).first, 'ab');
    await tester.enterText(find.byType(TextFormField).at(1), '12345678');
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    // Should show some validation error.
    expect(find.byType(Form), findsOneWidget);

    // Enter valid username
    await tester.enterText(find.byType(TextFormField).first, 'adrian');
    await tester.tap(find.byType(FilledButton));
    await tester.pump(); // begin loading
    await tester.pump(const Duration(milliseconds: 2)); // finish

    // Should navigate to home.
    expect(find.text('Home'), findsOneWidget);
  });
}


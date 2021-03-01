import 'package:area/exceptions/bad_token_exception.dart';
import 'package:area/models/user.dart';
import 'package:area/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_area_service.dart';
import 'mock_navigator_observer.dart';

void main() {
  group("Profile", () {
    NavigatorObserver mockObserver;
    MockAreaService mockAreaService;

    setUp(() {
      mockObserver = MockNavigatorObserver();
      mockAreaService = MockAreaService();
    });

    _loadWidget(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MyProfilePage(mockAreaService),
        navigatorObservers: [mockObserver],
      ));
      await tester.pump();
    }

    _userProfile(WidgetTester tester) async {
      when(mockAreaService.getUserProfile()).thenAnswer((_) async {
        return User("test", "test@epitech.eu", ["twitter", "github", "microsoft"], false);
      });

      await _loadWidget(tester);

      expect(find.byWidgetPredicate((widget) => widget is MaterialButton && widget.enabled), findsNWidgets(1));
      expect(find.byWidgetPredicate((widget) => widget is MaterialButton && !widget.enabled), findsNWidgets(3));
    }

    _badTokenException(WidgetTester tester) async {
      when(mockAreaService.getUserProfile()).thenThrow(BadTokenException());

      await _loadWidget(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    }

    testWidgets("User profile", (WidgetTester tester) async {
      await _userProfile(tester);
    });

    testWidgets("Bad token exception", (WidgetTester tester) async {
      await _badTokenException(tester);
    });
  });
}

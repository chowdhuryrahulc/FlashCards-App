import 'package:flashcards/Modals/providerManager.dart';
import 'package:flashcards/Profilepage.dart';
import 'package:flashcards/views/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('ListView scroll testing', () {
    // Finds Nothing when run for the first time
    // Finds 1 container when run after adding in list_view
    // ListView scroll test
    testWidgets('Finds Nothing when run for the first time',
        (WidgetTester tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
          create: ((context) => createSetFutureHeadlineControl()),
          child: MaterialApp(home: list_view())));
      final listViewContainer = find.byKey(Key('listViewContainerKey'));
      expect(listViewContainer, findsNothing);
    });
  });
}

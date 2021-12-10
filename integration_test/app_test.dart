import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sharlyapp/main_dev.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User flow', (WidgetTester tester) async {
    // Init app
    await app.main();
    await tester.pumpAndSettle();
    // checks empty list
    expect(find.text("Lista vacía"), findsOneWidget);
    // navigate to new product page
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    //creates a new product
    var addButton = find.byType(ElevatedButton);
    expect(tester.widget<ElevatedButton>(addButton).enabled, isFalse);
    const String productTitle = 'Product title test';
    await tester.enterText(find.byType(TextField), productTitle);
    await tester.tap(addButton);
    await tester.pumpAndSettle();
    // deletes created product
    var productItem = find.text(productTitle);
    expect(productItem, findsOneWidget);
    await tester.drag(productItem, const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
  });
}

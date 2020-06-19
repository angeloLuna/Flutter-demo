import 'package:flutter_app/src/widgets/flatButton.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tab Button', (WidgetTester tester) async {
 // Tap the add button.
     await tester.pumpWidget(AppButtonFlat());
});
}

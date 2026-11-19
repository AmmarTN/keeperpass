import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/widgets/configuration_error_app.dart';

void main() {
  testWidgets('shows every configuration error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ConfigurationErrorApp(
        errors: <String>['Missing URL', 'Missing key'],
      ),
    );

    expect(find.text('Configuration required'), findsOneWidget);
    expect(find.text('• Missing URL'), findsOneWidget);
    expect(find.text('• Missing key'), findsOneWidget);
  });
}

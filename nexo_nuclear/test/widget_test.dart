import 'package:flutter_test/flutter_test.dart';
import 'package:nexo_nuclear/main.dart';
void main() {
  testWidgets('abre a tela inicial', (tester) async {
    await tester.pumpWidget(const ExploradorApp());
    expect(find.text('Começar a explorar'), findsOneWidget);
  });
}

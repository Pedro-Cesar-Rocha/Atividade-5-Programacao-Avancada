import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:atividade5/main.dart';

void main() {
  testWidgets('Cadastra produto e mantém os existentes', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Smartphone'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Cadastrar Produto'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Bola');
    await tester.enterText(find.byType(TextFormField).at(1), '49,90');
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Esportes').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    expect(find.text('Bola'), findsOneWidget);
    expect(find.text('Smartphone'), findsOneWidget);
    expect(find.byIcon(Icons.sports_soccer), findsOneWidget);
  });

  testWidgets('Comprar mostra SnackBar', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Comprar').first);
    await tester.pump();

    expect(find.text('Smartphone foi adicionado ao carrinho'), findsOneWidget);
  });
}

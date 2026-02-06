import 'package:flutter/material.dart';
import '../services/ai_concierge_service.dart';
import 'widgets/suggestion_card.dart';

class AiConciergePage extends StatefulWidget {
  const AiConciergePage({super.key});

  @override
  State<AiConciergePage> createState() => _AiConciergePageState();
}

class _AiConciergePageState extends State<AiConciergePage> {
  final controller = TextEditingController();
  double budget = 0;

  @override
  Widget build(BuildContext context) {
    final suggestions =
        AiConciergeService.suggest(budget: budget);

    return Scaffold(
      appBar: AppBar(title: const Text('🤖 المساعد الذكي')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'كم ميزانيتك؟',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              onSubmitted: (value) {
                setState(() => budget = double.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: suggestions
                    .map((s) => SuggestionCard(suggestion: s))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

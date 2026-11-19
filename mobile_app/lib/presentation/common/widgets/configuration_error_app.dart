import 'package:flutter/material.dart';

class ConfigurationErrorApp extends StatelessWidget {
  const ConfigurationErrorApp({required this.errors, super.key});

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF65E653)),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.settings_suggest_outlined, size: 52),
                    const SizedBox(height: 20),
                    Text(
                      'Configuration required',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Check the environment file loaded in lib/main.dart '
                      '(assets/env/development.env or production.env).',
                    ),
                    const SizedBox(height: 20),
                    ...errors.map(
                      (String error) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('• $error'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

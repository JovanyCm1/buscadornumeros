import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Searcher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NumberSearcher(),
    );
  }
}

class NumberSearcher extends StatefulWidget {
  const NumberSearcher({super.key});

  @override
  _NumberSearcherState createState() => _NumberSearcherState();
}

class _NumberSearcherState extends State<NumberSearcher> {
  final TextEditingController _lowerLimitController = TextEditingController();
  final TextEditingController _upperLimitController = TextEditingController();
  int lowerLimit = 0;
  int upperLimit = 100;
  int currentNumber = 50;
  int buttonPressCount = 0;
  int maxAttempts = 0;

  void _incrementNumber() {
    setState(() {
      if (currentNumber < upperLimit) {
        lowerLimit = currentNumber + 1;
        currentNumber = (lowerLimit + upperLimit) ~/ 2;
        buttonPressCount++;
      }
    });
  }

  void _decrementNumber() {
    setState(() {
      if (currentNumber > lowerLimit) {
        upperLimit = currentNumber - 1;
        currentNumber = (lowerLimit + upperLimit) ~/ 2;
        buttonPressCount++;
      }
    });
  }

  void _setLimits() {
    setState(() {
      lowerLimit = int.tryParse(_lowerLimitController.text) ?? 0;
      upperLimit = int.tryParse(_upperLimitController.text) ?? 100;
      currentNumber = (lowerLimit + upperLimit) ~/ 2;
      buttonPressCount = 0;
      maxAttempts = (log(upperLimit - lowerLimit + 1) / log(2)).ceil();
    });
  }

  void _resetSearch() {
    setState(() {
      currentNumber = (lowerLimit + upperLimit) ~/ 2;
      buttonPressCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Searcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _lowerLimitController,
                decoration: const InputDecoration(
                  labelText: 'Límite Inferior',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _upperLimitController,
                decoration: const InputDecoration(
                  labelText: 'Límite Superior',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: _setLimits,
              child: const Text('Establecer Límites'),
            ),
            const SizedBox(height: 20),
            Text(
              'Adivinaré tu número en menos de: $maxAttempts intentos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Número actual:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$currentNumber',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Presiones de botones: $buttonPressCount',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _incrementNumber,
                  child: const Text('Arriba'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _decrementNumber,
                  child: const Text('Abajo'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetSearch,
              child: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/settings_controller.dart';

class VisualizationsScreen extends StatefulWidget {
  const VisualizationsScreen({super.key});

  @override
  State<VisualizationsScreen> createState() => _VisualizationsScreenState();
}

class _VisualizationsScreenState extends State<VisualizationsScreen> {
  final TextEditingController _factorController =
      TextEditingController(text: '84');
  final TextEditingController _digitController =
      TextEditingController(text: '1234');

  SequenceType _sequenceType = SequenceType.fibonacci;
  double _sequenceCount = 10;
  double _primeLimit = 100;

  @override
  void dispose() {
    _factorController.dispose();
    _digitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);
    final theme = Theme.of(context);
    final chartColor = theme.colorScheme.primary;

    final fibonacciValues = _generateFibonacci(_sequenceCount.toInt());
    final primeDistribution = _buildPrimeDistribution(_primeLimit.toInt(), 10);

    final factorInput = int.tryParse(_factorController.text.trim()) ?? 0;
    final digitInput = int.tryParse(_digitController.text.trim()) ?? 0;

    final factorTree = _buildFactorTreeLines(factorInput);
    final divisors = _buildDivisors(factorInput);
    final digitSteps = _buildDigitSteps(digitInput);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visualize Numbers',
          style: TextStyle(
            fontSize: settings.fontSize,
            color: settings.fontColor,
          ),
        ),
        backgroundColor: const Color(0xFFADD8E6),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Interactive Number Sequences',
            fontSize: settings.fontSize,
            fontColor: settings.fontColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<SequenceType>(
                  value: _sequenceType,
                  decoration: const InputDecoration(
                    labelText: 'Sequence Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: SequenceType.fibonacci,
                      child: Text('Fibonacci sequence'),
                    ),
                    DropdownMenuItem(
                      value: SequenceType.primeDistribution,
                      child: Text('Prime distribution'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _sequenceType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (_sequenceType == SequenceType.fibonacci)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'How many terms?',
                        style: TextStyle(
                          fontSize: settings.fontSize - 2,
                          color: settings.fontColor.withAlpha(180),
                        ),
                      ),
                      Slider(
                        min: 5,
                        max: 15,
                        divisions: 10,
                        value: _sequenceCount,
                        label: _sequenceCount.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _sequenceCount = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _LineChartPainter(
                            values: fibonacciValues,
                            lineColor: chartColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: fibonacciValues
                            .map(
                              (value) => Chip(
                                label: Text(value.toString()),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Prime distribution up to',
                        style: TextStyle(
                          fontSize: settings.fontSize - 2,
                          color: settings.fontColor.withAlpha(180),
                        ),
                      ),
                      Slider(
                        min: 30,
                        max: 200,
                        divisions: 17,
                        value: _primeLimit,
                        label: _primeLimit.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _primeLimit = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 220,
                        child: CustomPaint(
                          painter: _BarChartPainter(
                            values: primeDistribution,
                            barColor: chartColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Each bar is a bucket of numbers. Taller bars mean more primes.',
                        style: TextStyle(
                          fontSize: settings.fontSize - 3,
                          color: settings.fontColor.withAlpha(170),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionCard(
            title: 'Factor Trees & Divisor Diagram',
            fontSize: settings.fontSize,
            fontColor: settings.fontColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _factorController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'Number for factor tree',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Text(
                  'Factor Tree',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.bold,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    factorTree.isEmpty
                        ? 'Enter a positive integer to see its factor tree.'
                        : factorTree.join('\n'),
                    style: TextStyle(
                      fontSize: settings.fontSize - 2,
                      fontFamily: 'monospace',
                      color: settings.fontColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Divisors',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.bold,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                if (divisors.isEmpty)
                  Text(
                    'No divisors to show yet.',
                    style: TextStyle(color: settings.fontColor.withAlpha(160)),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: divisors
                        .map(
                          (value) => Chip(
                            label: Text(value.toString()),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionCard(
            title: 'Digit Operations Step-by-Step',
            fontSize: settings.fontSize,
            fontColor: settings.fontColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _digitController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'Number for digit operations',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                Text(
                  'Digits',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.bold,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                if (digitSteps.digits.isEmpty)
                  Text(
                    'Type a number to see digit steps.',
                    style: TextStyle(color: settings.fontColor.withAlpha(160)),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: digitSteps.digits
                        .map(
                          (digit) => Chip(
                            label: Text(digit.toString()),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Sum of digits',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.bold,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  digitSteps.sumExpression,
                  style: TextStyle(
                    fontSize: settings.fontSize - 1,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                _StepList(steps: digitSteps.sumSteps),
                const SizedBox(height: 16),
                Text(
                  'Product of digits',
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.bold,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  digitSteps.productExpression,
                  style: TextStyle(
                    fontSize: settings.fontSize - 1,
                    color: settings.fontColor,
                  ),
                ),
                const SizedBox(height: 8),
                _StepList(steps: digitSteps.productSteps),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum SequenceType { fibonacci, primeDistribution }

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.fontSize,
    required this.fontColor,
    required this.child,
  });

  final String title;
  final double fontSize;
  final Color fontColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,
                color: fontColor,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.values,
    required this.lineColor,
  });

  final List<int> values;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) {
      return;
    }

    final maxValue = values.reduce(max).toDouble();
    final padding = 16.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axisPaint,
    );
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axisPaint,
    );

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = padding + (i / (values.length - 1)) * chartWidth;
      final normalized = maxValue == 0 ? 0.0 : values[i] / maxValue;
      final y = size.height - padding - (normalized * chartHeight);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 4, Paint()..color = lineColor);
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.lineColor != lineColor;
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.values,
    required this.barColor,
  });

  final List<int> values;
  final Color barColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) {
      return;
    }

    final maxValue = values.reduce(max).toDouble();
    final padding = 16.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;
    final barWidth = chartWidth / values.length;

    final axisPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axisPaint,
    );
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axisPaint,
    );

    for (var i = 0; i < values.length; i++) {
      final normalized = maxValue == 0 ? 0.0 : values[i] / maxValue;
      final barHeight = normalized * chartHeight;
      final left = padding + i * barWidth + 4;
      final right = padding + (i + 1) * barWidth - 4;
      final top = size.height - padding - barHeight;
      final rect = Rect.fromLTRB(left, top, right, size.height - padding);
      final paint = Paint()
        ..color = barColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(6)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.barColor != barColor;
  }
}

class _StepList extends StatelessWidget {
  const _StepList({required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .map(
            (step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('• $step'),
            ),
          )
          .toList(),
    );
  }
}

class _DigitSteps {
  const _DigitSteps({
    required this.digits,
    required this.sumExpression,
    required this.productExpression,
    required this.sumSteps,
    required this.productSteps,
  });

  final List<int> digits;
  final String sumExpression;
  final String productExpression;
  final List<String> sumSteps;
  final List<String> productSteps;
}

List<int> _generateFibonacci(int count) {
  if (count <= 0) {
    return [];
  }
  if (count == 1) {
    return [0];
  }

  final values = <int>[0, 1];
  while (values.length < count) {
    values.add(values[values.length - 1] + values[values.length - 2]);
  }
  return values;
}

List<int> _buildPrimeDistribution(int limit, int buckets) {
  if (limit < 2 || buckets <= 0) {
    return [];
  }
  final primes = _generatePrimes(limit);
  final bucketSize = max(1, (limit / buckets).ceil());
  final counts = List<int>.filled(buckets, 0);
  for (final prime in primes) {
    final index = min((prime - 1) ~/ bucketSize, buckets - 1);
    counts[index] += 1;
  }
  return counts;
}

List<int> _generatePrimes(int limit) {
  if (limit < 2) {
    return [];
  }

  final sieve = List<bool>.filled(limit + 1, true);
  sieve[0] = false;
  sieve[1] = false;
  for (var i = 2; i * i <= limit; i++) {
    if (sieve[i]) {
      for (var j = i * i; j <= limit; j += i) {
        sieve[j] = false;
      }
    }
  }

  final primes = <int>[];
  for (var i = 2; i <= limit; i++) {
    if (sieve[i]) {
      primes.add(i);
    }
  }
  return primes;
}

List<String> _buildFactorTreeLines(int number) {
  if (number <= 1) {
    return [];
  }
  final lines = <String>[];
  _buildFactorTree(number, lines, 0);
  return lines;
}

void _buildFactorTree(int value, List<String> lines, int depth) {
  final indent = '  ' * depth;
  final factor = _smallestFactor(value);
  if (factor == value) {
    lines.add('$indent$value');
    return;
  }
  final other = value ~/ factor;
  lines.add('$indent$value');
  lines.add('$indent├─ $factor');
  _buildFactorTree(factor, lines, depth + 1);
  lines.add('$indent└─ $other');
  _buildFactorTree(other, lines, depth + 1);
}

int _smallestFactor(int value) {
  for (var i = 2; i <= sqrt(value).floor(); i++) {
    if (value % i == 0) {
      return i;
    }
  }
  return value;
}

List<int> _buildDivisors(int number) {
  if (number <= 0) {
    return [];
  }
  final divisors = <int>[];
  for (var i = 1; i <= sqrt(number).floor(); i++) {
    if (number % i == 0) {
      divisors.add(i);
      if (i != number ~/ i) {
        divisors.add(number ~/ i);
      }
    }
  }
  divisors.sort();
  return divisors;
}

_DigitSteps _buildDigitSteps(int number) {
  final digits = number.abs().toString().split('').map(int.parse).toList();
  if (digits.isEmpty ||
      (digits.length == 1 && digits.first == 0 && number == 0)) {
    return const _DigitSteps(
      digits: [],
      sumExpression: '',
      productExpression: '',
      sumSteps: [],
      productSteps: [],
    );
  }

  final sumSteps = <String>[];
  var runningSum = 0;
  for (final digit in digits) {
    final previous = runningSum;
    runningSum += digit;
    sumSteps.add('$previous + $digit = $runningSum');
  }

  final productSteps = <String>[];
  var runningProduct = 1;
  for (final digit in digits) {
    final previous = runningProduct;
    runningProduct *= digit;
    productSteps.add('$previous × $digit = $runningProduct');
  }

  final sumExpression = '${digits.join(' + ')} = $runningSum';
  final productExpression = '${digits.join(' × ')} = $runningProduct';

  return _DigitSteps(
    digits: digits,
    sumExpression: sumExpression,
    productExpression: productExpression,
    sumSteps: sumSteps,
    productSteps: productSteps,
  );
}

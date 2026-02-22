import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, green}

// Global service
final ColorService colorService = ColorService();

// Service
class ColorService extends ChangeNotifier {
  // store all counters in one map
  final Map<CardType, int> _taps = {CardType.red: 0, CardType.blue: 0, CardType.green: 0};

  int tapCount(CardType type) => _taps[type] ?? 0;

  Map<CardType, int> get taps => _taps;

  void increment(CardType type) {
    _taps[type] = tapCount(type) + 1;
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(type: CardType.red),
          ColorTap(type: CardType.blue),
          ColorTap(type: CardType.green),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.green:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        final count = colorService.tapCount(type);

        return GestureDetector(
          onTap: () => colorService.increment(type),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $count',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService, 
        builder: (context, child) {
          final entries = colorService.taps.entries.toList();
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bonus: if we add a new color type, it shows automatically
                for (final e in entries) 
                  Text(
                    '${e.key} taps: ${e.value}',
                    style: const TextStyle(fontSize: 24),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

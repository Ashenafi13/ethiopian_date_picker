import 'package:flutter/material.dart';
import 'package:ethio_date_picker/ethio_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethiopian Date Picker Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ethiopian Date Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _selectedDates = [];

  void _showDatePicker() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: const EthiopianDatePicker(
              displayGregorianCalender: true,
              userLanguage: 'am', // 'am', 'en', 'ao'
              startYear: 2010,
              endYear: 2030,
              todaysDateBackgroundColor: Colors.blue,
              allowPastDates: true,
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedDates = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Selected Dates:'),
            if (_selectedDates.isEmpty)
              const Text('None')
            else
              ..._selectedDates.map(
                (date) => Text(
                  date,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            const SizedBox(height: 20),
            ElevationButton(
              onPressed: _showDatePicker,
              child: const Text('Open Ethiopian Date Picker'),
            ),
          ],
        ),
      ),
    );
  }
}

class ElevationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ElevationButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: child,
    );
  }
}

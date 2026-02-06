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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B4CDB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ethiopian Date & Time Picker'),
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
  Map<String, dynamic>? _selectedDateTime;

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

  void _showDateTimePicker() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: const EthiopianDateTimePicker(
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
        _selectedDateTime = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Date Picker Section
              _buildSection(
                title: 'Date Picker Only',
                icon: Icons.calendar_today_rounded,
                color: const Color(0xFF00C896),
                child: Column(
                  children: [
                    const Text(
                      'Selected Date:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_selectedDates.isEmpty)
                      const Text(
                        'None',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      ..._selectedDates.map(
                        (date) => Text(
                          date,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1A1A2E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    _buildButton(
                      label: 'Open Date Picker',
                      icon: Icons.calendar_today_rounded,
                      color: const Color(0xFF00C896),
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // DateTime Picker Section
              _buildSection(
                title: 'Date & Time Picker (12-Hour Ethiopian)',
                icon: Icons.access_time_rounded,
                color: const Color(0xFF5B4CDB),
                child: Column(
                  children: [
                    const Text(
                      'Selected Date & Time:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_selectedDateTime == null)
                      const Text(
                        'None',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Column(
                        children: [
                          Text(
                            'Date: ${_selectedDateTime!['date']}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF1A1A2E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ethiopian Time: ${_selectedDateTime!['ethiopianTime']}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF5B4CDB),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Gregorian: ${_selectedDateTime!['gregorianTime']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    _buildButton(
                      label: 'Open DateTime Picker',
                      icon: Icons.access_time_rounded,
                      color: const Color(0xFF5B4CDB),
                      onPressed: _showDateTimePicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

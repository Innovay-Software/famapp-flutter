import 'package:flutter/material.dart';
import '../utils/debug_logger.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logs = DebugLogger().getLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Logs'),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(logs[logs.length - 1 - index]),
          );
        },
      ),
    );
  }
}
import 'package:debug_instruments/src/components/logger_viewer_component.dart';
import 'package:flutter/material.dart';

import '../components/shared_preferences_component.dart';
import '../instruments_configurator.dart';

class DebugInstrumentsPage extends StatefulWidget {
  const DebugInstrumentsPage({
    required this.instrumentsConfigurator,
    Key? key,
  }) : super(key: key);

  final InstrumentsConfigurator instrumentsConfigurator;

  @override
  State<DebugInstrumentsPage> createState() => _DebugInstrumentsPageState();
}

class _DebugInstrumentsPageState extends State<DebugInstrumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ Debug Instruments 🛠️'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push<MaterialPageRoute>(
                MaterialPageRoute(
                  builder: (_) => const SharedPrefsComponent(),
                ),
              );
            },
            title: const Text('Cache'),
            leading: const Icon(Icons.storage_sharp),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push<MaterialPageRoute>(
                MaterialPageRoute(
                  builder: (_) => const LoggerViewerComponent(),
                ),
              );
            },
            title: const Text('Logger'),
            leading: const Icon(Icons.storage_sharp),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

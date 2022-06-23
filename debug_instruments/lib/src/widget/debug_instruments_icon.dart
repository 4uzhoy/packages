import 'package:flutter/material.dart';

import '../instruments_configurator.dart';
import 'debug_instruments_page.dart';

/// debug instruments icon button
class DebugInstrumentsIcon extends StatelessWidget {
  const DebugInstrumentsIcon({
    required this.instrumentsConfigurator,
    Key? key,
  }) : super(key: key);

  final InstrumentsConfigurator instrumentsConfigurator;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push<MaterialPageRoute>(
          MaterialPageRoute(
            builder: (context) => DebugInstrumentsPage(
              instrumentsConfigurator: instrumentsConfigurator,
            ),
          ),
        );
      },
      icon: const Icon(Icons.code),
    );
  }
}

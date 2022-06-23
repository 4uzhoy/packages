import 'dart:io';

import 'package:debug_instruments/src/instruments_configurator.dart';
import 'package:flutter/material.dart';

class LoggerViewerComponent extends StatefulWidget {
  const LoggerViewerComponent({Key? key}) : super(key: key);

  @override
  State<LoggerViewerComponent> createState() => _LoggerViewerComponentState();
}

class _LoggerViewerComponentState extends State<LoggerViewerComponent> {
  late final File file;
  @override
  void initState() {
    file = InstrumentsConfigurator.get<File>()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logger')),
      body: StreamBuilder<List<String>>(
        stream: file.readAsLines().asStream(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<String>> snapshot,
        ) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Text(
                    snapshot.data![index],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('log file is empty'));
          }
        },
      ),
    );
  }
}

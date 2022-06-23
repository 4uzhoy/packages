import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../instruments_configurator.dart';

class SharedPrefsComponent extends StatefulWidget {
  const SharedPrefsComponent({Key? key}) : super(key: key);

  @override
  _SharedPrefsComponentState createState() => _SharedPrefsComponentState();
}

class _SharedPrefsComponentState extends State<SharedPrefsComponent> {
  bool isPassed = false;
  final Map<String, Object?> _prefs = {};

  void _sharedPrefs(SharedPreferences sharedPreferences) {
    final keys = sharedPreferences.getKeys();

    for (final key in keys) {
      _prefs.putIfAbsent(key, () => sharedPreferences.get(key));
    }
  }

  @override
  void initState() {
    final instance = InstrumentsConfigurator.get<SharedPreferences>();
    isPassed = instance != null;
    if (isPassed) {
      _sharedPrefs(instance!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preferences'),
        ),
        body: ListView(
          children: [
            for (final key in _prefs.keys)
              ListTile(
                title: Text(key),
                subtitle: Text(_prefs[key].toString()),
              )
          ],
        ));
  }
}

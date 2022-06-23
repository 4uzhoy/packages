import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


import 'key_value_store.dart';
import 'type_store_key.dart';

///Singleton реалзиация [KeyValueStore] на основе [SharedPreferences]
class SharedPrefsStore implements KeyValueStore {
  factory SharedPrefsStore() => _singleton;

  SharedPrefsStore._();

  bool isInit = false;

  static final SharedPrefsStore _singleton = SharedPrefsStore._();

  late SharedPreferences _sharedPreferences;

  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  Future<void> init({SharedPreferences? sharedPreferences}) async {
    if (!isInit) {
      _sharedPreferences =
          sharedPreferences ?? await SharedPreferences.getInstance();
      isInit = true;
    }
  }

  @override
  T? read<T>(TypeStoreKey<T> typedStoreKey,
      {ValueStoreParser<T>? valueParser}) {
    final value = _sharedPreferences.get(typedStoreKey.key);
    if (value != null && value is String && value.startsWith('{')) {
      if (valueParser == null) {
        throw Exception('in read<T> value != null'
            " && value is String && value.startsWith('{')"
            '\nbut valueParser is null,'
            ' u should pass method to parse non-primitive value from store');
      }
      return valueParser(jsonDecode(value) as Map<String, Object?>);
    } else {
      return _sharedPreferences.get(typedStoreKey.key) as T?;
    }
  }

  @override
  Future<bool> contains(TypeStoreKey typedStoreKey) async =>
      _sharedPreferences.containsKey(typedStoreKey.key);

  @override
  Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value) async {
    if (value == null) {
      await _sharedPreferences.remove(typedStoreKey.key);
      return;
    }
    switch (T) {
      case int:
        await _sharedPreferences.setInt(typedStoreKey.key, value as int);
        break;
      case String:
        await _sharedPreferences.setString(typedStoreKey.key, value as String);
        break;
      case double:
        await _sharedPreferences.setDouble(typedStoreKey.key, value as double);
        break;
      case bool:
        await _sharedPreferences.setBool(typedStoreKey.key, value as bool);
        break;
      case List:
        await _sharedPreferences.setStringList(
          typedStoreKey.key,
          value as List<String>,
        );
        break;
      default:
        {
          await _sharedPreferences.setString(
              typedStoreKey.key, jsonEncode(value));
        }
    }
  }
}

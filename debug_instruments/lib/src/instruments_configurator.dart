import 'dart:io';

import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Конфигурируем инструменты на переданные инстансы
/// Все объекты, которые будут необходимы в debug instruments
/// должны быть переданы в этот кофигуратор
class InstrumentsConfigurator {
  /// Аргументы опциональны и могут быть не переданы
  InstrumentsConfigurator({
    SharedPreferences? sharedPreferences,
    GeneratedDatabase? database,
    Logger? logger,
    File? logFile,
  })  : _sharedPreferences = sharedPreferences,
        _database = database,
        _logger = logger {
    _di
      ..putIfAbsent(SharedPreferences, () => _sharedPreferences)
      ..putIfAbsent(GeneratedDatabase, () => database)
      ..putIfAbsent(File, () => logFile)
      ..putIfAbsent(Logger, () => logger);
  }

  final SharedPreferences? _sharedPreferences;
  final GeneratedDatabase? _database;
  final Logger? _logger;

  ///Получить из [_di] необходмый инстанс по типу [T]
  static T? get<T>() => _di[T] as T?;
  static void printDi() => _di.forEach((key, value) {
        print('$key:$value');
      });
}

Map<Type, Object?> _di = <Type, Object?>{};

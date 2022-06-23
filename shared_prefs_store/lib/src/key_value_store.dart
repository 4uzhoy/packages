import 'type_store_key.dart';

///Парсер для типа [T]
typedef ValueStoreParser<T> = T? Function(Map<String, Object?>);

///Для типизированного хранилища данных вида ключ-значение,
/// работающее с [TypeStoreKey]
abstract class KeyValueStore {
  /// Метод проверяющий, что по ключу [typedStoreKey],
  /// хранится какое-либо значение
  Future<bool> contains(TypeStoreKey typedStoreKey);

  /// Метод для инициализации хранилища
  Future<void> init();

  /// Метод для чтения значения по ключу [typedStoreKey], в случае если значение
  /// отсутсвует возращается null
  /// Если значение находится в хранилище, его тип приводится к [T]
  /// В случае если [T] не явялется примитивным типом,
  /// потребуется передать [valueParser]
  T? read<T>(TypeStoreKey<T> typedStoreKey, {ValueStoreParser<T> valueParser});

  /// Метод для записи значения по ключу [typedStoreKey], при необходимости
  /// удалить значение необходимо передать null
  Future<void> write<T>(TypeStoreKey<T> typedStoreKey, T? value);
}

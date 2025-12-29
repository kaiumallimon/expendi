import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  final String boxName;

  HiveService(this.boxName);

  /// Open the box
  Future<Box> _openBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  /// CREATE / ADD
  Future<void> add(dynamic value, {dynamic key}) async {
    final box = await _openBox();
    if (key != null) {
      await box.put(key, value);
    } else {
      await box.add(value);
    }
  }

  /// READ all
  Future<List<dynamic>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// READ by key
  Future<dynamic> get(dynamic key) async {
    final box = await _openBox();
    return box.get(key);
  }

  /// UPDATE
  Future<void> update(dynamic key, dynamic value) async {
    final box = await _openBox();
    await box.put(key, value);
  }

  /// DELETE
  Future<void> delete(dynamic key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  /// CLEAR box
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}

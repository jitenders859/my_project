import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/util.dart';

class ItemData<E extends HiveObject> extends ChangeNotifier {
  String boxName = E.toString() + 'Box';

  List<E> _items = [];

  E _activeItem;
  int lastItemKey = 0;

  Future<void> getItems() async {
    var box = await Hive.openBox<E>(boxName);

    if (_items == null || box.values.toList().length != _items.length) {
      _items = box.values.toList();
      if (_items != null && _items.isNotEmpty) {
        lastItemKey = _items.last.key;
      }
      notifyListeners();
    }
  }

  List<E> getAllItems() {
    return _items;
  }

  E getItem(index) {
    if (_items != null) {
      for (int i = 0; i < getAllItems().length; i++) {
        if (getAllItems()[i].key == index) {
          return getAllItems()[i];
        }
      }
    }
    return null;
  }

  Future<String> addItem(E item) async {
    var box = await Hive.openBox<E>(boxName);

    await box.add(item);

    _items = box.values.toList();
    if (_items != null && _items.isNotEmpty) {
      lastItemKey = _items.last.key;
    }

    notifyListeners();
    return "successfully Added";
  }

  Future<String> deleteItem(key) async {
    var box = await Hive.openBox<E>(boxName);

    await box.delete(key);

    _items = box.values.toList();
    if (_items != null && _items.isNotEmpty) {
      lastItemKey = _items.last.key;
    }

    Log.i("Deleted Item with key: " + key.toString());

    notifyListeners();
    return "SuccessFully Deleted";
  }

  Future<String> editItem({E item, int itemKey}) async {
    var box = await Hive.openBox<E>(boxName);

    await box.put(itemKey, item);

    _items = box.values.toList();
    if (_items != null && _items.isNotEmpty) {
      lastItemKey = _items.last.key;
    }

    _activeItem = box.get(itemKey);

    Log.i("Edited " + item.toString());

    notifyListeners();
    return "successfully Edited";
  }

  void putItem(String key, E item) async {
    var box = await Hive.openBox<E>(boxName);

    box.put(key, item);
    _activeItem = item;

    notifyListeners();
  }

  Future<E> getItemDetail(key) async {
    var box = await Hive.openBox<E>(boxName);

    return box.get(key);
  }

  void setActiveItem(key) async {
    var box = await Hive.openBox<E>(boxName);

    _activeItem = box.get(key);

    notifyListeners();
  }

  void updateActiveItem(E item) {
    _activeItem = item;

    notifyListeners();
  }

  E getActiveItem() {
    return _activeItem;
  }

  int get itemCount {
    return _items.length;
  }
}

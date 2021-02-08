import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:upstreet_flutter_code_challenge/model/photos.dart';
import 'package:upstreet_flutter_code_challenge/utils.dart/util.dart';

class PhotosData extends ChangeNotifier {
  static const String _boxName = 'photoBox';

  List<Photos> _photos = [];

  Photos _activePhotos;

  Future<void> getPhotos() async {
    var box = await Hive.openBox<Photos>(_boxName);
    if (_photos == null || box.values.toList().length != _photos.length) {
      _photos = box.values.toList();

      notifyListeners();
    }
  }

  List<Photos> getAllPhotos() {
    return _photos;
  }

  Photos getPhoto(index) {
    return _photos[index];
  }

  void addPhoto(Photos photo) async {
    var box = await Hive.openBox<Photos>(_boxName);

    await box.add(photo);

    _photos = box.values.toList();

    notifyListeners();
  }

  void deletePhoto(key) async {
    var box = await Hive.openBox<Photos>(_boxName);

    await box.delete(key);

    _photos = box.values.toList();

    Log.i("Deleted Photo with key: " + key.toString());

    notifyListeners();
  }

  void editPhoto({Photos photo, int photoKey}) async {
    var box = await Hive.openBox<Photos>(_boxName);

    await box.put(photoKey, photo);

    _photos = box.values.toList();

    _activePhotos = box.get(photoKey);

    Log.i("Edited " + photo.title);

    notifyListeners();
  }

  void setActivePhoto(key) async {
    var box = await Hive.openBox<Photos>(_boxName);

    _activePhotos = box.get(key);

    notifyListeners();
  }

  Photos getActivePhoto() {
    return _activePhotos;
  }

  int get photoCount {
    return _photos.length;
  }
}

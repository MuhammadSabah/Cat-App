import 'dart:async';
import 'package:architecture_test/model/core/cat_photo.dart';
import 'package:architecture_test/model/glitch/glitch.dart';
import 'package:architecture_test/model/helper/cat_photo_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CatProvider extends ChangeNotifier {
  final _helper = CatPhotoHelper();
  final _streamController = StreamController<Either<Glitch, CatPhoto>>();

  Stream<Either<Glitch, CatPhoto>> get catPhotoStream {
    return _streamController.stream;
  }

  Future<void> getThirtyRandomPhoto() async {
    for (int i = 0; i < 30; i++) {
      final catHelperResult = await _helper.catData();
      _streamController.add(catHelperResult);
    }
  }

  void refreshGrid() {
    getThirtyRandomPhoto();
  }
}

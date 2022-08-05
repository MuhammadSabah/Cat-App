import 'dart:convert';
import 'package:architecture_test/model/core/cat_photo.dart';
import 'package:architecture_test/model/glitch/glitch.dart';
import 'package:architecture_test/model/glitch/no_internet_glitch.dart';
import 'package:architecture_test/model/services/cat_photo_api.dart';
import 'package:dartz/dartz.dart';

class CatPhotoHelper {
  final api = CatPhotoApi();
  Future<Either<Glitch, CatPhoto>> catData() async {
    final apiResult = await api.getRandomCatPhoto();
    return apiResult.fold(
      (l) {
        return Left(NoInternetGlitch());
      },
      (r) {
        final photo = CatPhoto.fromMap(jsonDecode(r as dynamic)[0]);
        return Right(photo);
      },
    );
  }
}

import 'dart:math';

import 'package:architecture_test/model/glitch/no_internet_glitch.dart';
import 'package:architecture_test/provider/cat_provider.dart';
import 'package:architecture_test/view/widget/cat_photo_error_tile.dart';
import 'package:architecture_test/view/widget/cat_photo_tile.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CatGrid extends StatefulWidget {
  const CatGrid({Key? key}) : super(key: key);

  @override
  State<CatGrid> createState() => _CatGridState();
}

class _CatGridState extends State<CatGrid> with AfterLayoutMixin {
  List catPhotos = [];
  List catPhotoTiles = [];
  @override
  void afterFirstLayout(BuildContext context) {
    final provider = Provider.of<CatProvider>(context, listen: false);
    provider.getFifteenRandomPhoto();
    provider.catPhotoStream.listen((snapshot) {
      snapshot.fold(
        (l) {
          if (l is NoInternetGlitch) {
            Color randomColor = Color.fromRGBO(
              Random().nextInt(255),
              Random().nextInt(255),
              Random().nextInt(255),
              1,
            );
            catPhotos.add(
              CatPhotoErrorTile(
                backgroundColor: randomColor,
                errorMessage: 'Unable to Connect',
              ),
            );
          }
        },
        (r) {
          catPhotos.add(CatPhotoTile(imgUrl: r.url));
        },
      );
      int count = Random().nextInt(4);
      catPhotoTiles.add(StaggeredTile.count(count, count.toDouble()));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              catPhotoTiles.clear();
              catPhotos.clear();
              provider.refreshGrid();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Cute Kittens',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: catPhotos.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : StaggeredGridView.countBuilder(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => catPhotoTiles[index],
                itemCount: catPhotos.length,
                itemBuilder: (context, index) {
                  return catPhotos[index];
                },
              ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Favorites',
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}

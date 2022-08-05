import 'package:flutter/material.dart';

class CatPhotoErrorTile extends StatelessWidget {
  const CatPhotoErrorTile({
    Key? key,
    required this.backgroundColor,
    required this.errorMessage,
  }) : super(key: key);
  final Color backgroundColor;
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(errorMessage),
          ),
        ),
      ),
    );
  }
}

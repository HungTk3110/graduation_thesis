import 'package:flutter/material.dart';
import 'package:untitled1/generated/l10n.dart';

enum ChoosePhotoType{
  gallery,
  camera,
}

extension ChoosePhotoTypeExtension on ChoosePhotoType {
  String getTitle(BuildContext context) {
    switch (this) {
      case ChoosePhotoType.gallery:
        return 'gallery';
      case ChoosePhotoType.camera:
        return 'camera';
    }
  }

  String svgAssetIcon() {
    switch (this) {
      case ChoosePhotoType.gallery:
        return 'assets/icon/ic_image.svg';
      case ChoosePhotoType.camera:
        return 'assets/icon/create_product_camera_icon.svg';
    }
  }
}
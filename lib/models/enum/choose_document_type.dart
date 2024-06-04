import 'package:flutter/material.dart';
import 'package:untitled1/generated/l10n.dart';

enum ChooseDocumentType{
  photo,
  file,
}

extension ChoosePhotoTypeExtension on ChooseDocumentType {
  String getTitle(BuildContext context) {
    switch (this) {
      case ChooseDocumentType.photo:
        return 'Upload Image';
      case ChooseDocumentType.file:
        return 'Upload File';
    }
  }

  String svgAssetIcon() {
    switch (this) {
      case ChooseDocumentType.photo:
        return 'assets/icon/ic_image.svg';
      case ChooseDocumentType.file:
        return 'assets/icon/file-line-icon.svg';
    }
  }
}
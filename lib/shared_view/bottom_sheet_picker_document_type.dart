import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/models/enum/choose_document_type.dart';
import 'package:untitled1/models/enum/choose_photo_type.dart';

class BottomSheetPickerDocumentType extends StatelessWidget {
  const BottomSheetPickerDocumentType({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 6,
              width: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            const SizedBox(height: 16),
            _itemWidget(context, type: ChooseDocumentType.photo),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                height: 1,
                color: Color(0xFF3C3C43),
                thickness: 1,
              ),
            ),
            _itemWidget(context, type: ChooseDocumentType.file),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                height: 1,
                color: Color(0xFF3C3C43),
                thickness: 1,
              ),
            ),
            // _itemWidget(context, type: ChoosePhotoType.file),
            // Container(
            //   height: 1,
            //   margin: const EdgeInsets.symmetric(vertical: 8),
            //   child: Divider(
            //     height: 1,
            //     color: AppColors.separator,
            //     thickness: 1,
            //   ),
            // ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "cancal",
                style: TextStyle(
                  color: const Color(0xff303030),
                  fontSize: 15.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _itemWidget(BuildContext context, {required ChooseDocumentType type}) {
    return InkWell(
      onTap: () => Navigator.pop(context, type),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              type.svgAssetIcon(),
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                type.getTitle(context),
                style: TextStyle(
                  color: const Color(0xff303030),
              fontSize: 15.r,
              fontWeight: FontWeight.w500,
            ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

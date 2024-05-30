import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircleAvatar extends StatelessWidget {
  final String url;
  final double size;

  const AppCircleAvatar({
    Key? key,
    this.url = "",
    this.size = 68,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Color(0xFFe6e6e6),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return SizedBox(
                    width: size,
                    height: size,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(top: size / 4),
                    child: Image.asset(
                      'assets/image/user.png',
                      fit: BoxFit.cover,
                    ),
                  );
                },
                fit: BoxFit.fill,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(top: size / 3),
                child: Image.asset(
                  'assets/image/user.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
    );
  }
}

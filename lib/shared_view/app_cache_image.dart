import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit fit;

  final Widget? customImagePlaceholder;

  const AppCacheImage({
    Key? key,
    this.url = "",
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.customImagePlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute == true;
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xffF26950)),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.network(
                    url,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceHolderImage(),
                    fit: fit,
                  );
                },
                fit: fit,
              ),
            )
          : _buildPlaceHolderImage(),
    );
  }

  Widget _buildPlaceHolderImage() {
    if (customImagePlaceholder != null) {
      return customImagePlaceholder!;
    }

    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFe6e6e6),
      ),
      child: Center(
        child: Image.asset(
          'assets/image/user.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

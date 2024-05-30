import 'package:flutter/material.dart';

class AppAvatarDefault extends StatelessWidget {
  final double size;

  const AppAvatarDefault({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: Color(0xFFe6e6e6),      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/image/user.png',
            width: 0.6 * size,
            height: 0.6 * size,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

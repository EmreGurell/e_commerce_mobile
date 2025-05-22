import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.width,
    this.height,
    this.size,  this.circular=true, this.radius = 0,
  });
  final bool circular;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double? width, height, size;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : isDark
                ? ProjectColors.neutralBlackColor.withOpacity(.9)
                : ProjectColors.whiteColor.withOpacity(.7),
        borderRadius: !circular ? BorderRadius.circular(radius) : BorderRadius.circular(100),
      ),
      child: IconButton(
          icon: Icon(
            icon,
            color: color,
            size: size,
          ),
          onPressed: onPressed),
    );
  }
}

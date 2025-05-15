import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.margin,
    this.radius = ProjectSizes.imageAndCardRadius,
    this.showBorder = false,
    this.backgroundColor = ProjectColors.whiteColor,
    this.borderColor = ProjectColors.finance3Color,
  });

  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}

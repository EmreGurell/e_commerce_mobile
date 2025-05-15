import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = ProjectColors.whiteColor,
    this.margin,
    this.opacity = .1,
  });
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: backgroundColor!.withOpacity(opacity)),
      child: child,
    );
  }
}

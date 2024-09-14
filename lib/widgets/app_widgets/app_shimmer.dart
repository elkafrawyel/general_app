import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Color? baseColor;
  final Color? highlightColor;
  final BoxShape shapeShape;
  final int? seconds;
  final double? radius;

  const AppShimmer.rectangular({
    super.key,
    required this.height,
    this.baseColor,
    this.highlightColor,
    this.seconds,
    this.width = double.infinity,
    this.radius,
  }) : shapeShape = BoxShape.rectangle;

  const AppShimmer.circular({
    super.key,
    required this.height,
    this.baseColor,
    this.highlightColor,
    this.seconds,
    this.width = double.infinity,
    this.radius,
  }) : shapeShape = BoxShape.circle;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.white54,
        period: Duration(seconds: seconds ?? 2),
        child: Container(
          padding: EdgeInsets.zero,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: shapeShape,
            borderRadius: shapeShape == BoxShape.circle
                ? null
                : BorderRadius.circular(radius ?? 0),
          ),
        ),
      );
}

import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/circular_container.dart';
import 'package:tarhanaciyasarmobil/common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: ProjectColors.purpleColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            const Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                backgroundColor: ProjectColors.whiteColor,
              ),
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: CircularContainer(),
            ),
            child,
            // Header için verilen içerik
          ],
        ),
      ),
    );
  }
}

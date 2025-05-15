import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;
  final IconData icon;
  const ProfileMenu({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    this.icon = Iconsax.arrow_right_34,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ProjectSizes.pagePadding,
            vertical: ProjectSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                icon,
                size: ProjectSizes.IconS,
              ),
            )
          ],
        ),
      ),
    );
  }
}

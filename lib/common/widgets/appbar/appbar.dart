import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leading,
      this.actions,
      this.leadingOnPressed,
      this.centerTitle = true,
      this.backgroundColor,
      this.backIconColor = ProjectColors.neutralBlackColor});

  final Widget? title;
  final Color? backgroundColor, backIconColor;
  final bool showBackArrow;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool? centerTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ProjectSizes.pagePadding),
      child: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Iconsax.arrow_left,
                  color: backIconColor,
                ))
            : leading ?? leading,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(DeviceUtility.getAppBarHeight());
}

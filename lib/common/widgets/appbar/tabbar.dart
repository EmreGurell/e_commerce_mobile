import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/device/device_utility.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/helper_fuctions.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({super.key, required this.tabs, this.controller});

  final List<Widget> tabs;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFuctions.isDarkMode(context);
    return Material(
      color: isDark
          ? ProjectColors.neutralBlackColor
          : ProjectColors.scaffoldLight,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: Theme.of(context).primaryColor,
        labelColor:
            isDark ? ProjectColors.whiteColor : ProjectColors.neutralBlackColor,
        unselectedLabelColor: ProjectColors.grayColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtility.getAppBarHeight());
}

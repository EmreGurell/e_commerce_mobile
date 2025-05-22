import 'package:tarhanaciyasarmobil/features/personalization/screens/settings/settings.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/home.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/store.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: ProjectColors.greenColor.withOpacity(.1),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Ana Sayfa'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Mağaza'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'İstek Listesi'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profil'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const Store(),
    const Wishlist(),
    const SettingsScreen()
  ];
}

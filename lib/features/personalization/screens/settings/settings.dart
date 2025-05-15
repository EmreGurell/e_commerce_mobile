import 'package:tarhanaciyasarmobil/common/custom_shapes/containers/primary_header_container.dart';
import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/common/widgets/list_tiles/settings_menu_list_tile.dart';
import 'package:tarhanaciyasarmobil/common/widgets/list_tiles/user_profile_list_tile.dart';
import 'package:tarhanaciyasarmobil/common/widgets/texts/section_heading.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/address_page.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/profile.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/order/order.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
                child: Column(children: [
              MyAppbar(
                title: Text(
                  ProjectTexts.account,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: ProjectColors.whiteColor),
                ),
              ),
              UserProfileListTile(
                onPressed: () => Get.to(const ProfileScreen()),
              ),
              const SizedBox(
                height: ProjectSizes.spaceBtwItems * 2,
              ),
            ])),
            Padding(
              padding: const EdgeInsets.all(ProjectSizes.pagePadding),
              child: Column(
                children: [
                  const SectionHeading(
                    showActionButton: false,
                    title: 'Hesap Ayarları',
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.shopping_cart,
                    title: 'Sepetim',
                    subtitle: 'Sepeti görüntüle',
                    onTap: () {},
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.bag_tick,
                    title: 'Siparişlerim',
                    subtitle: 'Siparişleri görüntüle',
                    onTap: () => Get.to(const OrderScreen()),
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.safe_home,
                    title: 'Adreslerim',
                    subtitle: 'Adresleri düzenle',
                    onTap: () => Get.to(const UserAddressScreen()),
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.card,
                    title: 'Kartlarım',
                    subtitle: 'Kartları görüntüle, Ekle/Sil',
                    onTap: () {},
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.notification,
                    title: 'Bildirimler',
                    subtitle: 'Mesajları görüntüle',
                    onTap: () {},
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.security,
                    title: 'Hesap Gizliliği',
                    subtitle: 'Gizlilik ayarlarını düzenle',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  const SectionHeading(
                    showActionButton: false,
                    title: 'Uygulama Ayarları',
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  SettingsMenuListTile(
                    icon: Iconsax.location,
                    title: 'Konum Ayarları',
                    subtitle: 'Uygulamanın konumu kullanmasına izin ver',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: ProjectSizes.spaceBtwItems,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () =>
                              AuthenticationRepository.instance.logout(),
                          child: const Text('Çıkış Yap'))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

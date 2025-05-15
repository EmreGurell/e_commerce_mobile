import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/features/personalization/controllers/address_controller.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/add_new_address.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/widgets/address.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';
import 'package:tarhanaciyasarmobil/utils/helpers/cloud_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: MyAppbar(
        title: Text(
          ProjectTexts.myAdresses,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.blueColor,
        onPressed: () => Get.to(const AddNewAddress()),
        child: const Icon(
          Iconsax.add,
          color: ProjectColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ProjectSizes.pagePadding),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    key: Key(controller.refreshData.value.toString()),
                    future: controller.getAllUserAddresses(),
                    builder: (context, snapshot) {
                      final response =
                          CloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);
                      if (response != null) return response;
                      final addresses = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) => SingleAddress(
                          address: addresses[index],
                          onTap: () =>
                              controller.selectAddress(addresses[index]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

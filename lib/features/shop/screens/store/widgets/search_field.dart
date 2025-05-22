import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tarhanaciyasarmobil/features/shop/controllers/search_controller.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/texts.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
  });

  final MySearchController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.searchProducts,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: ProjectSizes.spaceBtwItems * 1.2),
        hintStyle: const TextStyle(color: ProjectColors.gray3Color),
        fillColor: ProjectColors.whiteColor,
        filled: true,
        hintText: ProjectTexts.search,
        prefixIcon:
            const Icon(Iconsax.search_normal, color: ProjectColors.gray3Color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
          borderSide: const BorderSide(color: ProjectColors.gray4Color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ProjectSizes.imageAndCardRadius),
          borderSide: const BorderSide(color: ProjectColors.gray4Color),
        ),
        suffixIcon: controller.searchText.value.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: controller.clearSearch,
              )
            : null,
      ),
    );
  }
}

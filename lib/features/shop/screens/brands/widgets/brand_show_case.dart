import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarhanaciyasarmobil/features/shop/models/brand_model.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../store/widgets/brand_card.dart';

// Kullanılacak renkler (istediğin renkleri buraya ekleyebilirsin)
List<Color> availableColors = [
  Color(0xffA3B18A), // Soft yeşil - zeytin, doğal bitki yeşili
  Color(0xffF2CC8F), // Sıcak sarı - buğday, bal tonu
  Color(0xffD9BF77), // Açık toprak kahverengisi - doğal tarhana/pirinç rengi
  Color(0xffC19A6B), // Koyu toprak kahvesi - toprak, odun rengi
  Color(0xffE4DCCF), // Krem-bej - doğal süt ürünleri tonu
  Color(0xffBC6C25), // Turuncu-kahve - sıcak tarçın, baharat rengi
  Color(0xff8A6D3B), // Koyu hardal sarısı - bakliyat, kuru yemiş rengi
  Color(0xffF4E1D2), // Çok açık bej - doğal kağıt, ham pamuk gibi
];

class BrandShowcase extends StatelessWidget {
  final List<String> images;
  final BrandModel brand;
  final List<Color> _usedColors;
  final int index;

  BrandShowcase({
    super.key,
    required this.images,
    required this.brand,
    required List<Color> usedColors,
    required this.index,
  }) : _usedColors = usedColors;

  static Color getUniqueColor(List<Color> usedColors) {
    final random = Random();
    final available =
        availableColors.where((c) => !usedColors.contains(c)).toList();

    if (available.isEmpty) {
      return availableColors[random.nextInt(availableColors.length)];
    }

    return available[random.nextInt(available.length)];
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getUniqueColor(_usedColors);
    final isEven = index % 2 == 0;

    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        color: backgroundColor,
        child: Row(
          children: isEven
              ? [
                  Expanded(flex: 1, child: BrandCard2(brand: brand)),
                  const SizedBox(width: ProjectSizes.spaceBtwItems / 2),
                  Expanded(flex: 2, child: _buildImageList()),
                ]
              : [
                  Expanded(flex: 2, child: _buildImageList()),
                  const SizedBox(width: ProjectSizes.spaceBtwItems / 2),
                  Expanded(flex: 1, child: BrandCard2(brand: brand)),
                ],
        ),
      ),
    );
  }

  Widget _buildImageList() {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) => brandTopProductImageWidget(images[index]),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image) {
  return Container(
    width: 150,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
    ),
  );
}

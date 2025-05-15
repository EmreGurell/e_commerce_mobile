import 'package:tarhanaciyasarmobil/common/widgets/appbar/appbar.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/order/widgets/order_list_items.dart';
import 'package:tarhanaciyasarmobil/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: Text('Siparişlerim',
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(ProjectSizes.pagePadding),
        child: OrderListItems(),
      ),
    );
  }
}

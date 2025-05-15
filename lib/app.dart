import 'package:tarhanaciyasarmobil/bindings/general_bindings.dart';
import 'package:tarhanaciyasarmobil/routes/app_routes.dart';
import 'package:tarhanaciyasarmobil/utils/constants/colors.dart';
import 'package:tarhanaciyasarmobil/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialBinding: GeneralBindings(),
        getPages: AppRoutes.pages,
        home: const Scaffold(
          backgroundColor: ProjectColors.blueColor,
          body: Center(
            child: CircularProgressIndicator(
              color: ProjectColors.whiteColor,
            ),
          ),
        ));
  }
}

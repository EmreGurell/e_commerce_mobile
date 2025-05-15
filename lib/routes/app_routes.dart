import 'package:tarhanaciyasarmobil/features/authentication/screens/login/login.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/signup.dart';
import 'package:tarhanaciyasarmobil/features/authentication/screens/signup/verify_email.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/address/address_page.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/profile/profile.dart';
import 'package:tarhanaciyasarmobil/features/personalization/screens/settings/settings.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/cart/cart.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/checkout/checkout.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/home/home.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/order/order.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/store/store.dart';
import 'package:tarhanaciyasarmobil/features/shop/screens/wishlist/wishlist.dart';
import 'package:tarhanaciyasarmobil/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.store, page: () => const Store()),
    GetPage(name: Routes.favourites, page: () => const Wishlist()),
    GetPage(name: Routes.settings, page: () => const SettingsScreen()),
    // GetPage(name: Routes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: Routes.order, page: () => const OrderScreen()),
    GetPage(name: Routes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: Routes.cart, page: () => const CartScreen()),
    GetPage(name: Routes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: Routes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: Routes.signup, page: () => const SignupScreen()),
    GetPage(name: Routes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: Routes.signIn, page: () => const LoginScreen()),
    GetPage(name: Routes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: Routes.onBoarding, page: () => const OnboardingScreen()),
  ];
}

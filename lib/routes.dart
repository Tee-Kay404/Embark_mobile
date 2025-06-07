import 'package:Embark_mobile/app/theme/theme_toggle.dart';
import 'package:Embark_mobile/feature/auth/settings.dart';
import 'package:Embark_mobile/feature/models/cart_page.dart';
import 'package:Embark_mobile/feature/models/category_products.dart';
import 'package:Embark_mobile/feature/models/payment/pages/bank_transfer.dart';
import 'package:Embark_mobile/feature/models/payment/pages/card.dart';
import 'package:Embark_mobile/feature/models/payment/pages/cash_delivery.dart';
import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/pages/account.dart';
import 'package:Embark_mobile/pages/category.dart';
import 'package:Embark_mobile/pages/contact.dart';
import 'package:Embark_mobile/pages/discount_offers.dart';
import 'package:Embark_mobile/pages/gift_card.dart';
import 'package:Embark_mobile/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:Embark_mobile/components/drawer/drawer.dart';
import 'package:Embark_mobile/feature/auth/views/log_in_view.dart';
import 'package:Embark_mobile/feature/auth/views/sign_up_view.dart';
import 'package:Embark_mobile/feature/models/product_details.dart';
import 'package:Embark_mobile/pages/dashBoard.dart';
import 'package:Embark_mobile/pages/forgot_password.dart';
import 'package:Embark_mobile/pages/intro_page.dart';
import 'package:Embark_mobile/pages/onboarding_pages/onboarding_pages.dart';

enum PageRoutes {
  introPage,
  account,
  categoryProduct,
  onBoarding,
  login,
  signUp,
  dashBoard,
  forgotPassword,
  productCard,
  productDetails,
  drawer,
  cartPage,
  discountOffer,
  settings,
  category,
  giftCards,
  contact,
  splash,
  themeToggle,
  order,
  loginModal,
  cardPayment,
  bankTransfer,
  cashDelivery,
  pages
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  WidgetBuilder builder;
  switch (PageRoutesExtension.fromString(settings.name)) {
    case PageRoutes.introPage:
      builder = (ctx) => const IntroPage();
      break;
    case PageRoutes.onBoarding:
      builder = (ctx) => const OnBoardingPage();
      break;
    case PageRoutes.order:
      builder = (ctx) => const OrdersPage(
            products: {},
          );
      break;
    case PageRoutes.login:
      builder = (ctx) => const LogInView();
      break;
    case PageRoutes.signUp:
      builder = (ctx) => const SignUp();
      break;
    case PageRoutes.dashBoard:
      builder = (ctx) => Dashboard();
      break;
    case PageRoutes.forgotPassword:
      builder = (ctx) => ForgotPasswordScreen();
      break;
    case PageRoutes.drawer:
      builder = (ctx) => const DrawerPage();
      break;
    case PageRoutes.settings:
      builder = (ctx) => const SettingsPage();
      break;
    case PageRoutes.category:
      builder = (ctx) => CategoryPage();
      break;
    case PageRoutes.discountOffer:
      builder = (ctx) => const DiscountOffers();
      break;
    case PageRoutes.cashDelivery:
      final args = settings.arguments;
      if (args is Map<String, dynamic>) {
        final price = args['price'] as double;
        final products = args['products'] as Product;
        builder = (ctx) => CashDelivery(
              price: price,
              products: products,
            );
      } else {
        builder = (ctx) => const IntroPage();
      }
      break;
    case PageRoutes.bankTransfer:
      builder = (ctx) => const BankTransfer();
      break;
    case PageRoutes.account:
      builder = (ctx) => AccountPage();
      break;
    case PageRoutes.cardPayment:
      final args = settings.arguments;
      if (args is Product) {
        builder = (ctx) => CardPayment(
              product: args,
            );
      } else {
        builder = (ctx) => Dashboard();
      }
      break;
    case PageRoutes.giftCards:
      builder = (ctx) => const GiftCard();
      break;
    case PageRoutes.contact:
      builder = (ctx) => ContactPage();
      break;
    case PageRoutes.categoryProduct:
      final args = settings.arguments;
      if (args is Map<String, dynamic>) {
        final category = args['category'] as String;
        builder = (ctx) => CategoryProductsPage(category: category);
      } else {
        builder = (ctx) => const IntroPage();
      }
      break;

    case PageRoutes.cartPage:
      final args = settings.arguments;
      if (args is Map<String, dynamic>) {
        builder = (ctx) => CartPage(products: args);
      } else {
        builder = (ctx) => const IntroPage();
      }
      break;
    case PageRoutes.themeToggle:
      builder = (ctx) => ThemePage();
      break;
    case PageRoutes.productDetails:
      final arguments = settings.arguments;
      if (arguments is Product) {
        builder = (ctx) => ProductDetails(products: arguments);
      } else {
        builder = (ctx) => const IntroPage();
      }
      break;
    default:
      builder = (ctx) => const IntroPage();
      break;
  }
  return MaterialPageRoute(builder: builder, settings: settings);
}

extension PageRoutesExtension on PageRoutes {
  static PageRoutes? fromString(String? value) {
    var routes = PageRoutes.values.where((route) => route.name == value);
    if (routes.isNotEmpty) {
      return routes.first;
    } else {
      return null;
    }
  }
}

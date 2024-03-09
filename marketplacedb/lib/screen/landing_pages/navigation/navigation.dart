import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/screen/landing_pages/home_page/home_page_controller.dart';
import 'package:marketplacedb/screen/landing_pages/navigation/navigation_controller.dart';
import 'package:marketplacedb/controllers/products/product_item_controller.dart';
import 'package:marketplacedb/controllers/user_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/favorites_page/favorites_page_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/sell_pages/billing_address_setup/billing_address_setup.dart';
import 'package:marketplacedb/controllers/products/product_controller.dart';
import 'package:marketplacedb/screen/sign_in_pages/item_order_pages/shopping_cart_page/shopping_cart_page_controller.dart';
import 'package:marketplacedb/util/local_storage/local_storage.dart';

class Navigation extends StatelessWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MPLocalStorage localStorage = MPLocalStorage();
    Get.put(ProductController());
    Get.put(ProductItemController());
    Get.put(FavoritesPageController());
    Get.put(ShoppingCartPageController());
    Get.put(HomeScreenController());
    UserController userController = Get.put(UserController());
    NavigationController navigationController = NavigationController.instance;
    print(localStorage.readData('token'));
    print(localStorage.readData('userID'));
    return Obx(() => Scaffold(
          bottomNavigationBar: NavigationBar(
              selectedIndex: navigationController.index.value,
              onDestinationSelected: (index) async {
                if (index == 2) {
                  await userController.userHasAddress();
                  if (userController.userHasAddressValue.value == false) {
                    Get.to(() => const BillingAddressSetup());
                    navigationController.index.value = 0;
                  } else {
                    navigationController.index.value = index;
                  }
                } else {
                  navigationController.index.value = index;
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home4), label: 'home'),
                NavigationDestination(
                    icon: Icon(Iconsax.search_favorite), label: 'Discover'),
                NavigationDestination(
                    icon: Icon(Iconsax.shop_add), label: 'Sell'),
                NavigationDestination(
                    icon: Icon(Iconsax.heart), label: 'Favorites'),
                NavigationDestination(
                    icon: Icon(Iconsax.profile_tick), label: 'Me'),
              ]),
          //
          body: Obx(() =>
              navigationController.screens[navigationController.index.value]),
        ));
  }
}


  //case 'listingAdded':
  //successSnackBar(context, MPTexts.productListed, MPTexts.success);
  //break;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marketplacedb/common/widgets/common_widgets/containers.dart';
import 'package:marketplacedb/data/models/addresses/user_address_model.dart';
import 'package:marketplacedb/screen/signin_pages/settings_pages/address_list_page/address_list_controller.dart';
import 'package:marketplacedb/util/constants/app_colors.dart';
import 'package:marketplacedb/util/constants/app_sizes.dart';
import 'package:marketplacedb/util/helpers/helper_functions.dart';
import 'package:marketplacedb/util/popups/alert_dialog.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    super.key,
    required this.userAddress,
  });

  final UserAddressModel userAddress;

  @override
  Widget build(BuildContext context) {
    AddressListPageController controller = AddressListPageController.instance;
    final dark = MPHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        if (userAddress.isDefault! == false) {
          MPAlertDialog.openDialog(
              context,
              "Make this your default address?",
              "Are you sure you want to make this address as your default address?",
              [
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel",
                        style: Theme.of(context).textTheme.bodyMedium!)),
                MaterialButton(
                    onPressed: () {
                      controller.selectedAddress.value = userAddress;
                      controller.setDefaultAddress();
                      Navigator.of(context).pop();
                    },
                    child: Text('Approve',
                        style: Theme.of(context).textTheme.bodyMedium!))
              ]);
        }
      },
      child: MPCircularContainer(
          height: null,
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(MPSizes.md),
          backgroundColor: userAddress.isDefault!
              ? MPColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: userAddress.isDefault!
              ? Colors.transparent
              : dark
                  ? MPColors.darkerGrey
                  : MPColors.grey,
          margin: const EdgeInsets.only(bottom: MPSizes.spaceBtwItems),
          child: Stack(children: [
            Positioned(right: 0, top: 0, child: Container()),
            Positioned(
              right: 5,
              bottom: 0,
              child: Icon(userAddress.isDefault! ? Iconsax.tick_circle5 : null,
                  color: userAddress.isDefault!
                      ? dark
                          ? MPColors.light
                          : MPColors.dark.withOpacity(0.6)
                      : null),
            ),
            Padding(
              padding: const EdgeInsets.only(right: MPSizes.md),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(userAddress.address!.contactNumber!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(width: MPSizes.xs),
                        IconButton(
                            onPressed: () {
                              controller.selectedAddress.value = userAddress;
                              if (controller.selectedAddress.value.isDefault! ==
                                  true) {
                                MPAlertDialog.openDialog(
                                    context,
                                    "Default Address cannot be removed ",
                                    "Select other address to default", [
                                  MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!)),
                                ]);
                              } else {
                                MPAlertDialog.openDialog(
                                    context,
                                    "Remove Address?",
                                    "Are you sure you want to delete this address?",
                                    [
                                      MaterialButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!)),
                                      MaterialButton(
                                          onPressed: () {
                                            controller.deleteAddress();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Remove',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!))
                                    ]);
                              }
                            },
                            icon: Icon(Icons.delete,
                                size: MPSizes.iconSm,
                                color: dark ? MPColors.light : MPColors.dark)),
                      ],
                    ),
                    const SizedBox(height: MPSizes.sm / 2),
                    Text(userAddress.address!.city!.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!),
                    const SizedBox(height: MPSizes.sm / 2),
                    Text(
                      userAddress.address!.unitNumber!,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    const SizedBox(height: MPSizes.sm / 2),
                    Text(
                      userAddress.address!.addressLine1!,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ]),
            )
          ])),
    );
  }
}

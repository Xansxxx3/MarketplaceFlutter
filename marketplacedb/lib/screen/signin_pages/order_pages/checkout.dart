// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplacedb/config/buttons.dart';
import 'package:marketplacedb/config/textfields.dart';
import 'package:marketplacedb/controllers/shoppingCartController.dart';
import 'package:marketplacedb/models/shoppingCartItemModel.dart';

import 'package:marketplacedb/screen/signin_pages/navigation.dart';

class CheckoutPage extends StatefulWidget {
  final ShoppingCartItemModel item;

  final ShoppingCartController controller = Get.find<ShoppingCartController>();

  CheckoutPage({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckoutPageState(item: item);
}

class CheckoutPageState extends State<CheckoutPage> {
  final ShoppingCartItemModel item;

  CheckoutPageState({required this.item});
  final shipping = TextEditingController();
  String selectedPaymentType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 3,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.network(
                      item.product_item!.product_images?[0].product_image ??
                          'asd',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Price: Php ${item.product_item!.price?.toStringAsFixed(2) ?? 'N/A'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Row(children: [
              Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Headertext(text: 'Shipping Address'))
            ]),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Navigation(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2.0,
                  ),
                ),
                child: const Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Headertext(text: 'Payment Type'))
              ])),
          Column(
            children: <Widget>[
              RadioListTile(
                title: const Text('Paypal'),
                value: 'Paypal',
                groupValue: selectedPaymentType,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentType = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Gcash'),
                value: 'Gcash',
                groupValue: selectedPaymentType,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentType = value!;
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LargeWhiteButton(
                    onPressed: () {
                      // Handle the check out button action
                    },
                    text: 'Check Out',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

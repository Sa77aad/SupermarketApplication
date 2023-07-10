import 'package:flutter/material.dart';
import 'package:checkout_screen_ui/checkout_page.dart';
import 'package:checkout_screen_ui/credit_card_form.dart';
import 'package:checkout_screen_ui/validation.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFFFFFFB8);
    final List<PriceItem> _priceItems = [
      PriceItem(name: 'Product A', quantity: 1, totalPriceCents: 5200),
      PriceItem(name: 'Product B', quantity: 2, totalPriceCents: 8599),
      PriceItem(name: 'Product C', quantity: 1, totalPriceCents: 2499),
      PriceItem(name: 'Delivery Charge', quantity: 1, totalPriceCents: 1599),
    ];
    return Scaffold(
        backgroundColor: myColor,
        body: CheckoutPage(
          priceItems: _priceItems,
          payToName: 'Checkout',
          displayNativePay: true,
          onNativePay: () => print('Native Pay Clicked'),
          //isApple: Platform.isIOS,
          onCardPay: (results) =>
              print('Credit card form submitted with results: $results'),
          onBack: () => Navigator.of(context).pop(),
        ));
  }
}

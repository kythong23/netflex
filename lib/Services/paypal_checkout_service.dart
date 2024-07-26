import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:netflex/data/Subcription.dart';
import '../config/api_service.dart';
import '../page/home.dart';
import '../page/subcription.dart';

class CheckoutPaypal {
  static void Checkout(BuildContext context, Subcription sub) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId: "AeNf6JabhZ2Rgl3ylk8eSsR_uIELbc842H-jygHtG1AdCnm0lm4eGgzFwuF4hJcDuZCCrp46Sweyocla",
        secretKey: "EFLQq_0JToLL_XglK7WazYJJNn184WOXX1hn8zwOnLtnx3iwWeoI_6XRNGuBTob67AS-JLDbE8zRiTdU",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: [
          {
            "amount": {
              "total": '${sub.subPrice}',
              "currency": "USD",
              "details": {
                "subtotal": '${sub.subPrice}',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "${sub.subdesc}.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "${sub.subName}",
                  "quantity": 1,
                  "price": '${sub.subPrice}',
                  "currency": "USD"
                }
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          bool check = await setSubcriptionForUser(sub!.subId!);
          if(check){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHome()));
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionPage()));
          }
        },
        onError: (error) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionPage()));
        },
        onCancel: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionPage()));
        },
      ),
    ));
  }
}


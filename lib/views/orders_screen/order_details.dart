import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'components/order_placed_details.dart';
import 'components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Order Details")
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Placed",
                  showDone: data['order_placed'] // Add null check here
                  ),
              orderStatus(
                  color: Vx.blue900,
                  icon: Icons.thumb_up_alt,
                  title: "Conformed",
                  showDone: data['order_conformed'] // Add null check here
                  ),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_repair_sharp,
                  title: "Delivery",
                  showDone: data['order_on_delivery'] // Add null check here
                  ),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_outlined,
                  title: "Delivered",
                  showDone: data['order_delivered'] // Add null check here
                  ),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                      title1: "Order Code",
                      title2: "Shipping Method",
                      d1: data['order_code'],
                      d2: data['shipping_method']),
                  orderPlacedDetails(
                      title1: "Order Date",
                      title2: "Payment Method",
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format(data['order_date'].toDate()),
                      d2: data['payment_method']),
                  orderPlacedDetails(
                      title1: "Payment Status",
                      title2: "Delivery Status",
                      d1: "Unpade",
                      d2: "Order Placed"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address"
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['order_by_name']}".text.make(),
                                "${data['order_by_email']}".text.make(),
                                "${data['order_by_address']}".text.make(),
                                "${data['order_by_city']}".text.make(),
                                "${data['order_by_country']}".text.make(),
                                "${data['order_by_state']}".text.make(),
                                "${data['order_by_phoneNo']}".text.make(),
                                "${data['order_by_postalCode']}".text.make(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 125,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(semibold).make(),
                                "${data['total_amount']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Ordeerd Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tPrice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(EdgeInsets.only(bottom: 4))
                  .make(),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

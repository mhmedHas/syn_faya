import 'package:flutter/material.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/order.dart';
import '../generated/l10n.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderDetailsPage({required this.orders});
  final Order orders;

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String _orderStatus = 'Accept'; // الحالة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).order_Deteils),
        centerTitle: true,
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/33-removebg-preview.png'),
                      backgroundColor: primary,
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orders.companyName!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            S.of(context).de_order_blow,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            buildDetailTile(
              icon: Icons.description,
              label: S.of(context).order_Deteils,
              value: widget.orders.itemCount!.toString(),
            ),
            buildDetailTile(
              icon: Icons.location_on,
              label: S.of(context).pickup_loc,
              value: widget.orders.pickupLocation!,
            ),
            buildDetailTile(
              icon: Icons.local_shipping,
              label: S.of(context).delevary_loc,
              value: widget.orders.deliveryLocation!,
            ),
            buildDetailTile(
              icon: Icons.price_check,
              label: S.of(context).price,
              value: "1000",
            ),
            buildDetailTile(
              icon: Icons.payment_outlined,
              label: S.of(context).statePay,
              value: S.of(context).pay,
            ),
            buildDetailTile(
              icon: Icons.phone,
              label: S.of(context).phone,
              value: widget.orders.customerPhone ?? S.of(context).NotProvided,
            ),
            SizedBox(height: 16),

            // Chips to change order status
            Text(
              S.of(context).order_state,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: Text(S.of(context).accept),
                  selected: _orderStatus == S.of(context).accept,
                  onSelected: (selected) {
                    setState(() {
                      _orderStatus = S.of(context).accept;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text(S.of(context).intransit),
                  selected: _orderStatus == S.of(context).intransit,
                  onSelected: (selected) {
                    setState(() {
                      _orderStatus = S.of(context).intransit;
                    });
                  },
                ),
                ChoiceChip(
                  label: Text(S.of(context).delivered),
                  selected: _orderStatus == S.of(context).delivered,
                  onSelected: (selected) {
                    setState(() {
                      _orderStatus = S.of(context).delivered;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              '${S.of(context).currunt} :$_orderStatus',
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),

            SizedBox(height: 16),

            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Perform action for canceling the order or any other functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).canceledorder)),
                    );
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(S.of(context).canceledorder),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Map or perform any action
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Map_page()));
                  },
                  icon: Icon(Icons.map),
                  label: Text(S.of(context).viewmap),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30, // Increased icon size
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

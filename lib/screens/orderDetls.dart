import 'package:flutter/material.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/models/complet.dart';
import 'package:v1/models/orderModel.dart';

import '../generated/l10n.dart';

class OrderD_page extends StatelessWidget {
  const OrderD_page({super.key, required this.order});
  final complete order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // إضافة تدرج لوني كخلفية للـ Scaffold
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 255, 255, 255)
            ], // تدرج لوني بين primary و الأزرق
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  const Icon(Icons.assignment_outlined,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).order_Deteils,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: primary, // استخدام اللون الأساسي كخلفية
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(30), // تحديد انحناء الحافة السفلية اليسرى
                  bottomRight:
                      Radius.circular(30), // تحديد انحناء الحافة السفلية اليمنى
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: const [],
              floating: true,
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailCard(Icons.receipt, S.of(context).orderid,
                            "${order.order_id}"),
                        _buildDetailCard(Icons.person,
                            S.of(context).customername, order.customerName),
                        _buildDetailCard(
                            Icons.business,
                            S.of(context).Companyname,
                            order.companyName ?? "N/A"),
                        _buildDetailCard(
                            Icons.location_on,
                            S.of(context).pickup_loc,
                            order.pickupLocation ?? "N/A"),
                        _buildDetailCard(
                            Icons.local_shipping,
                            S.of(context).delevary_loc,
                            order.deliveryLocation ?? "N/A"),
                        _buildDetailCard(Icons.category,
                            S.of(context).ordertybe, order.orderType ?? "N/A"),
                        _buildDetailCard(Icons.format_list_numbered,
                            S.of(context).item, "${order.itemCount ?? "N/A"}"),
                        _buildDetailCard(
                            Icons.calendar_today,
                            S.of(context).orderdata,
                            order.orderDate?.toString() ?? "N/A"),
                        _buildDetailCard(
                            Icons.notes,
                            S.of(context).additionaldetails,
                            order.additionalDetails ?? "N/A"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 7, 158, 67)),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

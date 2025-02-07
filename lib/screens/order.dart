import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/api_model/profileData.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/models/complet.dart'; // موديل الطلبات المسلمة
import 'package:v1/models/orderModel.dart'; // موديل الطلبات المفتوحة
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/drawble.dart';
import 'package:v1/screens/loginPage.dart';
import 'package:v1/screens/orderDetls.dart';
import 'package:v1/screens/order_D_home.dart';
import 'package:v1/widget/navBarr.dart';
import '../generated/l10n.dart';

class order_page extends StatefulWidget {
  final complete? order;
  order_page({super.key, this.order});

  @override
  State<order_page> createState() => _order_pageState();
}

class _order_pageState extends State<order_page> {
  final ProfileService apiService = ProfileService();
  bool _isLoading = true;
  String _errorMessage = '';

  int? someMethod(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    return userModel.iddd;
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await apiService.fetchActiveOrders(someMethod(context));
      await apiService.fetchDeliveredOrders(someMethod(context));
    } on SocketException catch (e) {
      setState(() {
        _errorMessage =
            'No internet connection. Please check your network settings.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = "internet  not connect";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // لون خلفية الشاشة
      appBar: AppBar(
        title: Text(
          S.of(context).orderhistory,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primary, // اللون الأساسي
        centerTitle: true,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : FutureBuilder<List<Order>>(
                  future: apiService.fetchActiveOrders(someMethod(context)),
                  builder: (context, snapshotActive) {
                    if (snapshotActive.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshotActive.hasError) {
                      return Center(
                          child: Text("Error: ${snapshotActive.error}"));
                    } else {
                      return FutureBuilder<List<complete>>(
                        future: apiService
                            .fetchDeliveredOrders(someMethod(context)),
                        builder: (context, snapshotDelivered) {
                          if (snapshotDelivered.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshotDelivered.hasError) {
                            return Center(
                                child:
                                    Text("Error: ${snapshotDelivered.error}"));
                          } else {
                            List<Order> activeOrders =
                                snapshotActive.data ?? [];
                            List<complete> deliveredOrders =
                                snapshotDelivered.data ?? [];

                            return RefreshIndicator(
                              onRefresh: _fetchData,
                              child: ListView(
                                padding: const EdgeInsets.all(8.0),
                                children: [
                                  // قسم الطلبات المفتوحة
                                  _buildOpenSection(
                                    context,
                                    '              ${S.of(context).open_order}',
                                    Colors.green, // لون القسم
                                    Icons.check_circle, // أيقونة القسم
                                    activeOrders,
                                    Colors.black, // لون النص
                                  ),
                                  // قسم الطلبات المسلمة
                                  _buildCompleteSection(
                                    context,
                                    '              ${S.of(context).deleverd_order}',
                                    Colors.blue, // لون القسم
                                    Icons.done_all, // أيقونة القسم
                                    deliveredOrders,
                                    Colors.black, // لون النص
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
      bottomNavigationBar: const CustomNavBar(
        order: true,
      ),
    );
  }

  // دالة لعرض الطلبات المفتوحة (open)
  Widget _buildOpenSection(BuildContext context, String title, Color iconColor,
      IconData icon, List<Order> filteredOrders, Color textColor) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        children: filteredOrders
            .map((order) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: primary,
                        child: Text(
                          order.id.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        order.customerName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${order.pickupLocation}   ➔   ${order.deliveryLocation}',
                            style: TextStyle(color: Colors.purple[700]),
                          ),
                          Text(
                            'تاريخ الطلب: ${order.orderDate.toString().split(' ')[0]}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                              orders: order,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // دالة لعرض الطلبات المسلمة (complete)
  Widget _buildCompleteSection(
      BuildContext context,
      String title,
      Color iconColor,
      IconData icon,
      List<complete> filteredOrders,
      Color textColor) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        children: filteredOrders
            .map((order) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: primary,
                        child: Text(
                          order.order_id.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        order.customerName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${order.pickupLocation}   ➔   ${order.deliveryLocation}',
                            style: TextStyle(color: Colors.purple[700]),
                          ),
                          Text(
                            'تاريخ الطلب: ${order.orderDate.toString().split(' ')[0]}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderD_page(order: order),
                          ),
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

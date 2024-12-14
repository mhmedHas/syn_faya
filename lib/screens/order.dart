import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/screens/HomeScreen.dart';
import 'package:v1/screens/driver.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/orderDetls.dart';
import 'package:v1/screens/privacy_page.dart';
import 'package:v1/screens/settings.dart';

import 'package:v1/widget/navBarr.dart';
import 'package:v1/widget/splash.dart';

import '../generated/l10n.dart';

class order_page extends StatelessWidget {
  final Order? order;
  order_page({this.order}) {
    order != null ? orders.add(order!) : "";
  }
  List<Order> orders = [
    Order(
      id: 1,
      customerName: 'حلول التقنية',
      customerPhone: '01124031904',
      status: 'مفتوح',
      companyName: 'شركة التقنية',
      pickupLocation: 'القاهرة',
      deliveryLocation: 'الإسكندرية',
      orderType: 'إلكترونيات',
      itemCount: 5,
      orderDate: DateTime(2024, 12, 10),
      additionalDetails: 'مواد قابلة للكسر، يرجى التعامل بحذر',
    ),
    Order(
      id: 2,
      customerName: 'الشحن العالمية',
      customerPhone: '01124031904',
      status: 'مفتوح',
      companyName: 'الشحن العالمية المحدودة',
      pickupLocation: 'الجيزة',
      deliveryLocation: 'الأقصر',
      orderType: 'أثاث',
      itemCount: 3,
      orderDate: DateTime(2024, 12, 9),
      additionalDetails: 'أشياء كبيرة، تتطلب تجميعًا',
    ),
    Order(
      id: 3,
      customerName: 'الإمدادات البيئية',
      customerPhone: '01124031904',
      status: 'مفتوح',
      companyName: 'الإمدادات الصديقة للبيئة',
      pickupLocation: 'أسوان',
      deliveryLocation: 'الغردقة',
      orderType: 'أدوات مكتبية',
      itemCount: 20,
      orderDate: DateTime(2024, 12, 8),
      additionalDetails: 'أُلغيت بناءً على طلب العميل',
    ),
    Order(
      id: 4,
      customerName: 'المحيط الأزرق',
      customerPhone: '01124031904',
      status: 'مفتوح',
      companyName: 'تجارة المحيط الأزرق',
      pickupLocation: 'بورسعيد',
      deliveryLocation: 'الإسماعيلية',
      orderType: 'مأكولات بحرية',
      itemCount: 10,
      orderDate: DateTime(2024, 12, 7),
      additionalDetails: 'سريعة التلف، تحتاج إلى تسليم سريع',
    ),
    Order(
      id: 5,
      customerName: 'حلول التقنية',
      customerPhone: '01124031904',
      status: 'مفتوح',
      companyName: 'شركة التقنية',
      pickupLocation: 'القاهرة',
      deliveryLocation: 'الإسكندرية',
      orderType: 'إلكترونيات',
      itemCount: 7,
      orderDate: DateTime(2024, 12, 6),
      additionalDetails: 'تشمل وثائق الضمان',
    ),
    Order(
      id: 6,
      customerName: 'الشحن العالمية',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'الشحن العالمية المحدودة',
      pickupLocation: 'الجيزة',
      deliveryLocation: 'الأقصر',
      orderType: 'آلات ثقيلة',
      itemCount: 2,
      orderDate: DateTime(2024, 12, 5),
      additionalDetails: 'آلات ثقيلة، تتطلب معالجة خاصة',
    ),
    Order(
      id: 7,
      customerName: 'الإمدادات البيئية',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'الإمدادات الصديقة للبيئة',
      pickupLocation: 'أسوان',
      deliveryLocation: 'الغردقة',
      orderType: 'مستلزمات مكتبية',
      itemCount: 15,
      orderDate: DateTime(2024, 12, 4),
      additionalDetails: 'أُلغيت بسبب عدم توفر العناصر',
    ),
    Order(
      id: 8,
      customerName: 'المحيط الأزرق',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'تجارة المحيط الأزرق',
      pickupLocation: 'بورسعيد',
      deliveryLocation: 'الإسماعيلية',
      orderType: 'مأكولات بحرية',
      itemCount: 12,
      orderDate: DateTime(2024, 12, 3),
      additionalDetails: 'تم تسليمها إلى منشأة تخزين مبردة',
    ),
    Order(
      id: 9,
      customerName: 'حلول التقنية',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'شركة التقنية',
      pickupLocation: 'القاهرة',
      deliveryLocation: 'الإسكندرية',
      orderType: 'أجهزة',
      itemCount: 8,
      orderDate: DateTime(2024, 12, 2),
      additionalDetails: 'توصيل سريع مطلوب',
    ),
    Order(
      id: 10,
      customerName: 'الشحن العالمية',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'الشحن العالمية المحدودة',
      pickupLocation: 'الجيزة',
      deliveryLocation: 'الأقصر',
      orderType: 'منسوجات',
      itemCount: 4,
      orderDate: DateTime(2024, 12, 1),
      additionalDetails: 'تتطلب تخليص جمركي',
    ),
    Order(
      id: 11,
      customerName: 'الإمدادات البيئية',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'الإمدادات الصديقة للبيئة',
      pickupLocation: 'أسوان',
      deliveryLocation: 'الغردقة',
      orderType: 'منتجات ورقية',
      itemCount: 25,
      orderDate: DateTime(2024, 11, 30),
      additionalDetails: 'أُلغيت بسبب تأخر الشحنة',
    ),
    Order(
      id: 12,
      customerName: 'المحيط الأزرق',
      customerPhone: '01124031904',
      status: 'ملغى',
      companyName: 'تجارة المحيط الأزرق',
      pickupLocation: 'بورسعيد',
      deliveryLocation: 'الإسماعيلية',
      orderType: 'أطعمة مجمدة',
      itemCount: 18,
      orderDate: DateTime(2024, 11, 29),
      additionalDetails: 'تتطلب التحكم بدرجة الحرارة أثناء النقل',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 66, 66),
      appBar: AppBar(
        title: Text(
          S.of(context).orderhistory,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primary, // اللون الأساسي
        centerTitle: true,
        elevation: 10, // زيادة تأثير الظل
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40), // جعل الحواف أسفل أكثر دائرية
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(4.0), // إضافة مسافة بين AppBar والمحتوى
          child: Container(
            color: Colors.transparent, // شريط غير مرئي أسفل الـ AppBar
          ),
        ),
        automaticallyImplyLeading:
            false, // لإخفاء أيقونة الشريط الجانبي الافتراضية
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // أيقونة السهم للرجوع
          onPressed: () {
            Navigator.of(context).pop();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HomeScreen())); // للعودة إلى الشاشة السابقة
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber[700]!, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  S.of(context).Billgets,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                accountEmail: Text(
                  S.of(context).BIllgetsemailcom,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/44.jpg'),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Driver()),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                ),
              ),
              ListTile(
                title:
                    Text(S.of(context).orders, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.menu, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => order_page(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).map, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.map_outlined, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Map_page(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).api, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.settings, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Settings_page(),
                  ));
                },
              ),
              ListTile(
                title:
                    Text(S.of(context).privacy, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.privacy_tip, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PrivacyPage(),
                  ));
                },
              ),
              ListTile(
                title: Text(S.of(context).change_language,
                    style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.language, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleLocale();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
              ),
              Divider(thickness: 1.0),
              ListTile(
                title:
                    Text(S.of(context).close, style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.cancel, color: Colors.black),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildSection(
            context,
            '              ${S.of(context).open_order}',
            Colors.red,
            Icons.more_horiz,
            orders.where((order) => order.status == 'مفتوح').toList(),
            const Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 8),
          _buildSection(
            context,
            '              ${S.of(context).deleverd_order}',
            Colors.red,
            Icons.more_horiz,
            orders.where((order) => order.status == 'مسلمه').toList(),
            const Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 8),
          _buildSection(
            context,
            '             ${S.of(context).cance_lorder} ',
            Colors.red,
            Icons.more_horiz,
            orders.where((order) => order.status == 'ملغى').toList(),
            const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        order: true, // تمرير البيانات اللازمة إلى الناف بار
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Color iconColor,
      IconData icon, List<Order> filteredOrders, Color textColor) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        backgroundColor: Colors.grey[100],
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                      subtitle: Text(
                        '${order.pickupLocation}   ➔   ${order.deliveryLocation}',
                        style: TextStyle(color: Colors.purple[700]),
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

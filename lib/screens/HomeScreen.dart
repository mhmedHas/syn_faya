import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/screens/driver.dart';
import 'package:v1/screens/map.dart';
import 'package:v1/screens/order.dart';
import 'package:v1/screens/orderDetls.dart';
import 'package:v1/screens/order_D_home.dart';
import 'package:v1/screens/privacy_page.dart';
import 'package:v1/screens/settings.dart';
import 'package:v1/widget/navBarr.dart';

import 'package:intl/intl.dart';
import 'package:v1/widget/splash.dart';

import '../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAvailable = true; // Driver's status

  final List<Order> orders = [
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      status: 'مفتوح',
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).orders,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber[700], // اللون الأصفر الدافئ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return Container(
              margin: EdgeInsets.all(8), // مسافة حول الزر
              decoration: BoxDecoration(
                color: Colors.white, // خلفية الزر
                borderRadius: BorderRadius.circular(12), // حواف دائرية
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // لون الظل
                    blurRadius: 4, // مدى تلاشي الظل
                    offset: Offset(2, 2), // اتجاه الظل
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.amber[700]), // أيقونة الزر
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // فتح الشريط الجانبي
                },
              ),
            );
          },
        ),
        actions: [
          Row(
            children: [
              Text(
                isAvailable ? S.of(context).online : S.of(context).ofline,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 255, 3, 3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: isArabic()
                    ? EdgeInsets.only(left: 10)
                    : EdgeInsets.only(right: 10),
                child: Switch(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreen, // خلفية التفعيل
                  inactiveTrackColor:
                      Colors.grey, // خلفية الإلغاء // اللون عند إيقاف التفعيل
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return InkWell(
                  onTap: () {},
                  child: Card(
                    margin: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.companyName!,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.purple[700], // اللون الأصفر الداكن
                                ),
                              ),
                              Icon(Icons.location_on, color: primary),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${S.of(context).order_Deteils}  ${order.itemCount}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          Text(
                            'من ${order.pickupLocation} الى ${order.deliveryLocation}  ',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${S.of(context).phone} ${order.customerPhone}',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple[700],
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderDetailsPage(orders: order),
                                    ),
                                  );
                                },
                                child: Text(
                                  S.of(context).show,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          CustomNavBar(home: true),
        ],
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

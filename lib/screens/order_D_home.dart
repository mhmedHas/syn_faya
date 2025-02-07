import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/screens/loginPage.dart';
import 'package:v1/screens/map.dart';
import '../generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart'; // استيراد حزمة url_launcher

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.orders});
  final Order orders;

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String _orderStatus = 'جاري التحميل...'; // الحالة الافتراضية
  bool _isAccepted = false; // حالة زر القبول
  bool _isInTransit = false; // حالة زر قيد التوصيل
  bool _isDelivered = false; // حالة زر تم التوصيل
  Color _cancelButtonColor = primary;

  @override
  void initState() {
    super.initState();
    _fetchOrderStatus(int.parse(
        widget.orders.id!.toString())); // جلب حالة الطلب عند بدء الصفحة
  }

  // دالة لجلب حالة الطلب من الخادم
  Future<void> _fetchOrderStatus(int orderId) async {
    final String apiUrl =
        "http://alwarsh.net/api/get_order_status.php?request_id=$orderId";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          setState(() {
            _orderStatus = data['data']['status']; // تحديث حالة الطلب
            _updateButtonColors(); // تحديث ألوان الأزرار بناءً على الحالة
          });
        } else {
          setState(() {
            _orderStatus = "فشل جلب الحالة: ${data['message']}";
          });
        }
      } else {
        setState(() {
          _orderStatus = "فشل الاتصال بالخادم";
        });
      }
    } catch (e) {
      setState(() {
        _orderStatus = "حدث خطأ: $e";
      });
    }
  }

  // دالة لتحديث ألوان الأزرار بناءً على الحالة الحالية
  void _updateButtonColors() {
    setState(() {
      _isAccepted = _orderStatus == "accepted";
      _isInTransit = _orderStatus == "in_transit";
      _isDelivered = _orderStatus == "delivered";
    });
  }

  // دالة لتحديث حالة الطلب
  Future<void> _updateOrderStatus(String status) async {
    final String apiUrl = "http://alwarsh.net/api/update_order_status.php";

    try {
      final userModel = Provider.of<UserModel>(context, listen: false);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "driver_id": userModel.iddd, // معرف السائق
          "request_id": widget.orders.id, // معرف الطلب
          "status": status, // الحالة الجديدة (in_transit أو delivered)
        }),
      );

      // طباعة الاستجابة الكاملة لأغراض التصحيح
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // إذا كان الطلب ناجحًا
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          setState(() {
            _orderStatus = status; // تحديث الحالة في الواجهة
            _updateButtonColors(); // تحديث ألوان الأزرار بناءً على الحالة
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("فشل تحديث الحالة: ${responseData['message']}")),
          );
        }
      } else {
        // إذا كان هناك خطأ في الطلب
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("done")),
        );
      }
    } catch (e) {
      // إذا حدث خطأ أثناء الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: $e")),
      );
    }
  }

  // دالة لإرسال طلب قبول الطلب
  Future<void> _acceptOrder() async {
    final String apiUrl = "http://alwarsh.net/api/accept_order.php";

    try {
      final userModel = Provider.of<UserModel>(context, listen: false);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "driver_id": userModel.iddd, // يمكنك تغيير هذا إلى معرف السائق الفعلي
          "request_id": widget.orders.id, // معرف الطلب
        }),
      );

      // طباعة الاستجابة الكاملة لأغراض التصحيح
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // إذا كان الطلب ناجحًا
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          setState(() {
            _orderStatus = "accepted"; // تحديث الحالة في الواجهة
            _updateButtonColors(); // تحديث ألوان الأزرار بناءً على الحالة
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم قبول الطلب بنجاح')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("فشل قبول الطلب: ${responseData['message']}")),
          );
        }
      } else {
        // إذا كان هناك خطأ في الطلب
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("done")),
        );
      }
    } catch (e) {
      // إذا حدث خطأ أثناء الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: $e")),
      );
    }
  }

  // دالة لإرسال طلب إلغاء الطلب
  Future<void> _cancelOrder() async {
    final String apiUrl = "http://alwarsh.net/api/cancel_order.php";

    try {
      final userModel = Provider.of<UserModel>(context, listen: false);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "driver_id": userModel.iddd, // يمكنك تغيير هذا إلى معرف السائق الفعلي
          "request_id": widget.orders.id, // معرف الطلب
        }),
      );

      if (response.statusCode == 200) {
        // إذا كان الطلب ناجحًا
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("تم إلغاء الطلب بنجاح")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("فشل إلغاء الطلب: ${responseData['message']}")),
          );
        }
      } else {
        // إذا كان هناك خطأ في الطلب
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("اعد المحاوله")),
        );
      }
    } catch (e) {
      // إذا حدث خطأ أثناء الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("اعد المحاوله: $e")),
      );
    }

    // إعادة تعيين حالة الأزرار ولون زر الإلغاء
    setState(() {
      _isAccepted = false;
      _isInTransit = false;
      _isDelivered = false;
      _cancelButtonColor = primary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).order_Deteils),
        centerTitle: true,
        backgroundColor: primary,
        shape: const RoundedRectangleBorder(
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
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          // '${widget.orders.companyImage}' ??
                          'assets/images/33-removebg-preview.png'),
                      backgroundColor: primary,
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orders.companyName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
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
            const Divider(),
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
              value: widget.orders.totalAmount!,
            ),
            buildDetailTile(
              icon: Icons.image,
              label: S.of(context).showw,
              value: "reset",
              isImage: true, // تحديد أن هذا العنصر يعرض صورة
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
              isPhoneNumber: true, // تحديد أن هذا الرقم هاتف
            ),
            const SizedBox(height: 16),

            // Chips to change order status
            Text(
              S.of(context).order_state,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  label: Text(S.of(context).accept),
                  selected: _isAccepted,
                  onSelected: (selected) {
                    setState(() {
                      _isAccepted = true;
                      _cancelButtonColor = Colors.red; // تغيير لون زر الإلغاء
                    });
                    _acceptOrder(); // استدعاء دالة قبول الطلب
                  },
                  selectedColor: _isAccepted ? Colors.green : null,
                ),
                ChoiceChip(
                  label: Text(S.of(context).intransit),
                  selected: _isInTransit,
                  onSelected: _isAccepted
                      ? (selected) {
                          setState(() {
                            _isInTransit = true;
                            _cancelButtonColor =
                                Colors.red; // تغيير لون زر الإلغاء
                          });
                          _updateOrderStatus(
                              "in_transit"); // تحديث الحالة إلى "in_transit"
                        }
                      : null,
                  selectedColor: _isInTransit ? Colors.green : null,
                ),
                ChoiceChip(
                  label: Text(S.of(context).delivered),
                  selected: _isDelivered,
                  onSelected: _isInTransit
                      ? (selected) {
                          setState(() {
                            _isDelivered = true;
                            _cancelButtonColor =
                                Colors.red; // تغيير لون زر الإلغاء
                          });
                          _updateOrderStatus(
                              "delivered"); // تحديث الحالة إلى "delivered"
                        }
                      : null,
                  selectedColor: _isDelivered ? Colors.green : null,
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text(
              '${S.of(context).currunt} :$_orderStatus',
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _cancelOrder, // استدعاء دالة إلغاء الطلب
                  icon: const Icon(Icons.cancel),
                  label: Text(S.of(context).canceledorder),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _cancelButtonColor, // استخدام اللون المحدد
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // الانتقال إلى الخريطة
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(
                            pickupLocationUrl: widget.orders.pickup_mapUrl,
                            deliveryLocationUrl: widget.orders.delivery_mapUrl,
                          ),
                        ));
                  },
                  icon: const Icon(Icons.map),
                  label: Text(S.of(context).viewmap),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDetailTile({
    required IconData icon,
    required String label,
    required String value,
    bool isPhoneNumber = false, // معلمة لتحديد إذا كان الرقم هاتف
    bool isImage = false, // معلمة جديدة لتحديد إذا كان العنصر يعرض صورة
  }) {
    return GestureDetector(
      onTap: isPhoneNumber
          ? () async {
              if (value.isNotEmpty) {
                // تنظيف الرقم من الأحرف غير الرقمية
                final String phoneNumber =
                    value.replaceAll(RegExp(r'[^0-9]'), '');
                final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

                // التحقق من إمكانية فتح الرابط
                await launch(phoneUri.toString());
              }
            }
          : isImage
              ? () {
                  _showImageDialog(
                      // context,
                      // widget.orders
                      //     .companyImage!); ///////////////////////////////////////// عرض الصورة
                      context,
                      "https://hdqwalls.com/wallpapers/chevrolet-fnr-concept-car.jpg");
                }
              : null,
      child: Container(
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
              offset: const Offset(0, 2),
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
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: isPhoneNumber ? Colors.blue : Colors.grey[600],
                      decoration: isPhoneNumber
                          ? TextDecoration.underline
                          : TextDecoration.none,
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

  // دالة لعرض الصورة في Dialog
  void _showImageDialog(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black, // خلفية سوداء لتكبير الصورة
            appBar: AppBar(
              backgroundColor: Colors.black, // لون خلفية AppBar
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop(); // العودة للصفحة السابقة
                },
              ),
            ),
            body: Container(
              height: double.infinity,
              child: Center(
                child: InteractiveViewer(
                  panEnabled: true, // تمكين التمرير الأفقي والعمودي
                  boundaryMargin: EdgeInsets.all(20), // هامش حول الصورة
                  minScale: 0.5, // أصغر حجم تكبير
                  maxScale: 4.0, // أكبر حجم تكبير
                  child: Hero(
                    tag: 'imageHero', // علامة Hero لتأثير الانتقال
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill, // عرض الصورة بشكل كامل
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

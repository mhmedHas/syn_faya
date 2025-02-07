import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:v1/api_model/profileData.dart';
import 'package:v1/helper/Constanat.dart';
import 'package:v1/helper/darkmode.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/screens/drawble.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
import '../generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// تهيئة flutter_local_notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// دالة للتعامل مع الإشعارات في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  _showNotification(message);
}

// دالة لتهيئة flutter_local_notifications
void initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'your_channel_id', // معرف القناة
    'your_channel_name', // اسم القناة
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// دالة لعرض الإشعارات
void _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // معرف القناة
    'your_channel_name', // اسم القناة
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // معرف الإشعار
    message.notification?.title ?? 'إشعار جديد', // عنوان الإشعار
    message.notification?.body ?? 'تم إضافة طلب جديد', // محتوى الإشعار
    platformChannelSpecifics,
  );
}

class SwitchProvider with ChangeNotifier {
  bool _isAvailable = true;

  bool get isAvailable => _isAvailable;

  void toggleSwitch(bool value) {
    _isAvailable = value;
    notifyListeners();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = true;
  Future<List<Order>>? futureOrders; // تعريف futureOrders كـ nullable
  late Timer _timer;
  List<Order> _orders = [];
  int _previousOrderCount = 0; // عدد الطلبات السابقة

  @override
  void initState() {
    super.initState();
    _initializeFirebase().catchError((error) {
      _showErrorSnackBar("no enternet connection");
    });
    _checkInternetConnection().then((isConnected) {
      if (isConnected) {
        setState(() {
          futureOrders = _fetchOrders(); // تهيئة futureOrders هنا
        });
      } else {
        _showNoInternetSnackBar();
      }
    });
    _startPolling();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // طلب إذن الإشعارات (خاصة على iOS)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // الحصول على رمز الجهاز
    String? token = await messaging.getToken();
    print("Device Token: $token");

    // إرسال الرمز إلى الخادم لتسجيله
    if (token != null) {
      _sendTokenToServer(token).catchError((error) {
        // _showErrorSnackBar("no enternet connection");
      });
    }

    // التعامل مع الإشعارات في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // استقبال الإشعارات عندما يكون التطبيق في المقدمة
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");

      // عرض الإشعار يدويًا
      _showNotification(message);
    });

    // تهيئة flutter_local_notifications
    initializeNotifications();
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://alwarsh.net/api/register_token.php'),
        body: {
          'device_token': token,
        },
      );

      if (response.statusCode == 200) {
        print("Token sent to server successfully");
      } else {
        throw Exception('Failed to send token to server}');
      }
    } catch (e) {
      throw Exception('Failed to send token to server');
    }
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      if (_isConnected) {
        try {
          List<Order> newOrders = await _fetchOrders();
          _checkForNewOrders(newOrders);
        } catch (e) {
          // _showErrorSnackBar('فشل جلب الطلبات: $e');
        }
      }
    });
  }

  void _checkForNewOrders(List<Order> newOrders) {
    if (newOrders.length > _previousOrderCount) {
      setState(() {
        _orders = newOrders;
        _previousOrderCount = newOrders.length; // تحديث عدد الطلبات السابقة
      });

      // إرسال إشعار فقط إذا كان هناك طلب جديد
      final newOrder = newOrders.last;
      _sendNotification(newOrder);
    }
  }

  void _sendNotification(Order newOrder) {
    RemoteMessage message = RemoteMessage(
      notification: RemoteNotification(
        title: S.current.orederNOT,
        body: S.current.orderBody,
      ),
    );

    _showNotification(message);
  }

  Future<List<Order>> _fetchOrders() async {
    try {
      final response =
          await http.get(Uri.parse('http://alwarsh.net/api/get_orders.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == true) {
          List<dynamic> ordersJson = data['data'];
          return ordersJson.map((json) => Order.fromJson(json)).toList();
        } else {
          throw Exception('no enternet connection');
        }
      } else {
        throw Exception('no enternet connection');
      }
    } catch (e) {
      throw Exception('no enternet connection');
    }
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showNoInternetSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('لا يوجد اتصال بالإنترنت!'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'إعادة المحاولة',
          onPressed: () {
            _checkInternetConnection().then((isConnected) {
              if (isConnected) {
                setState(() {
                  futureOrders = _fetchOrders();
                });
              } else {
                _showNoInternetSnackBar();
              }
            });
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'إعادة المحاولة',
          onPressed: () {
            _checkInternetConnection().then((isConnected) {
              if (isConnected) {
                setState(() {
                  futureOrders = _fetchOrders();
                });
              } else {
                _showNoInternetSnackBar();
              }
            });
          },
        ),
      ),
    );
  }

  Future<void> _updateDriverStatus(bool isActive) async {
    final String apiUrl =
        "http://alwarsh.net/api/update_driver_active_status.php";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'driver_id': 1,
          'is_active': isActive ? 1 : 0,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          print("تم تحديث الحالة بنجاح: ${responseData['message']}");
        } else {
          throw Exception("فشل تحديث الحالة: ${responseData['message']}");
        }
      } else {
        throw Exception("فشل الاتصال بالخادم: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("حدث خطأ: ");
    }
  }

  String truncateText(String? text) {
    if (text == null || text.length <= 10) {
      return text ?? '';
    } else {
      return text.substring(0, 10) + '...';
    }
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchProvider>(context);

    if (!_isConnected) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('لا يوجد اتصال بالإنترنت!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _checkInternetConnection().then((isConnected) {
                    if (isConnected) {
                      setState(() {
                        futureOrders = _fetchOrders();
                      });
                    } else {
                      _showNoInternetSnackBar();
                    }
                  });
                },
                child: Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).orders,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.amber[700],
        leading: Builder(
          builder: (context) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.amber[700]),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        actions: [
          Row(
            children: [
              Text(
                switchProvider.isAvailable
                    ? S.of(context).online
                    : S.of(context).ofline,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 3, 3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: isArabic()
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(right: 10),
                child: Switch(
                  value: switchProvider.isAvailable,
                  onChanged: (value) {
                    switchProvider.toggleSwitch(value);
                    _updateDriverStatus(value).catchError((error) {
                      _showErrorSnackBar('فشل تحديث الحالة: ');
                    });
                  },
                  activeTrackColor: Colors.lightGreen,
                  inactiveTrackColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureOrders = _fetchOrders();
          });
        },
        child: Column(
          children: [
            Expanded(
              child: futureOrders == null
                  ? Center(
                      child:
                          CircularProgressIndicator()) // عرض مؤشر تحميل إذا كان futureOrders غير مهيأ
                  : FutureBuilder<List<Order>>(
                      future: futureOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('لا توجد طلبات متاحة'));
                        } else {
                          _orders = snapshot.data!;
                          return ListView.builder(
                            itemCount: _orders.length,
                            itemBuilder: (context, index) {
                              final order = _orders[index];
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                  margin: const EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              order.companyName!,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple[700],
                                              ),
                                            ),
                                            const Icon(Icons.location_on,
                                                color: primary),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${S.of(context).order_Deteils}  ${order.itemCount}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                        Text(
                                          ' ${truncateText(order.pickupLocation)} ⬅ ${truncateText(order.deliveryLocation)}  ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700]),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${S.of(context).phone} : ${order.customerPhone}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.purple[700],
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetailsPage(
                                                            orders: order),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                S.of(context).show,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
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
                          );
                        }
                      },
                    ),
            ),
            const CustomNavBar(home: true),
          ],
        ),
      ),
    );
  }
}

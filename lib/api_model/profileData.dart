import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v1/models/complet.dart';
import 'package:v1/models/oopen.dart';
import 'package:v1/models/orderModel.dart';
import 'package:v1/models/profile_data.dart';

class ProfileService {
  final String baseUrl = "http://alwarsh.net/api";

  // Future<ProfileData> fetchDriverProfile(int? driverId) async {
  //   final response = await http
  //       .get(Uri.parse('$baseUrl/get_driver_profile.php?driver_id=$driverId'));

  //   if (response.statusCode == 200) {
  //     // إذا كانت الاستجابة ناجحة (200 OK)
  //     print('Response Body: ${response.body}'); // طباعة الاستجابة للتحقق

  //     Map<String, dynamic> jsonMap = jsonDecode(response.body);

  //     // استخراج "personal_info" من "data"
  //     if (jsonMap.containsKey("data") && jsonMap["data"] is Map) {
  //       Map<String, dynamic> data = jsonMap["data"];
  //       if (data.containsKey("personal_info") && data["personal_info"] is Map) {
  //         Map<String, dynamic> personalInfo = data["personal_info"];
  //         Map<String, dynamic> statistics = data["statistics"];
  //         ProfileData profileData =
  //             ProfileData.fromJson(personalInfo, statistics);
  //         print('Profile Data: $profileData'); // طباعة البيانات للتحقق
  //         return profileData;
  //       } else {
  //         throw Exception('Personal info not found in response');
  //       }
  //     } else {
  //       throw Exception('Data not found in response');
  //     }
  //   } else {
  //     // إذا كانت هناك مشكلة في الاستجابة
  //     throw Exception('Failed to load driver profile');
  //   }
  // }
  // Future<ProfileData> fetchDriverProfile(int? driverId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final cachedData = prefs.getString('driverProfile');

  //   // إذا كانت البيانات مخزنة محليًا، نستخدمها
  //   if (cachedData != null) {
  //     final Map<String, dynamic> jsonMap = jsonDecode(cachedData);
  //     return ProfileData.fromJson(
  //         jsonMap["personal_info"], jsonMap["statistics"]);
  //   }

  //   // جلب البيانات من الخادم
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/get_driver_profile.php?driver_id=$driverId'),
  //   );

  //   if (response.statusCode == 200) {
  //     // إذا كانت الاستجابة ناجحة (200 OK)
  //     print('Response Body: ${response.body}'); // طباعة الاستجابة للتحقق

  //     Map<String, dynamic> jsonMap = jsonDecode(response.body);

  //     // استخراج "personal_info" من "data"
  //     if (jsonMap.containsKey("data") && jsonMap["data"] is Map) {
  //       Map<String, dynamic> data = jsonMap["data"];
  //       if (data.containsKey("personal_info") && data["personal_info"] is Map) {
  //         Map<String, dynamic> personalInfo = data["personal_info"];
  //         Map<String, dynamic> statistics = data["statistics"];

  //         // حفظ البيانات في التخزين المؤقت
  //         prefs.setString('driverProfile', jsonEncode(data));

  //         // تحويل البيانات إلى كائن ProfileData
  //         ProfileData profileData =
  //             ProfileData.fromJson(personalInfo, statistics);
  //         print('Profile Data: $profileData'); // طباعة البيانات للتحقق
  //         return profileData;
  //       } else {
  //         throw Exception('Personal info not found in response');
  //       }
  //     } else {
  //       throw Exception('Data not found in response');
  //     }
  //   } else {
  //     // إذا كانت هناك مشكلة في الاستجابة
  //     throw Exception('Failed to load driver profile');
  //   }
  // }

  Future<ProfileData> fetchDriverProfile(int? driverId,
      {bool forceRefresh = false}) async {
    final prefs = await SharedPreferences.getInstance();

    // إذا لم نكن نريد إجبار التحديث وكانت البيانات مخزنة محليًا، نستخدمها
    if (!forceRefresh) {
      final cachedData = prefs.getString('driverProfile');
      if (cachedData != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(cachedData);
        return ProfileData.fromJson(
            jsonMap["personal_info"], jsonMap["statistics"]);
      }
    }

    // جلب البيانات من الخادم
    final response = await http.get(
      Uri.parse('$baseUrl/get_driver_profile.php?driver_id=$driverId'),
    );

    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة (200 OK)
      print('Response Body: ${response.body}'); // طباعة الاستجابة للتحقق

      Map<String, dynamic> jsonMap = jsonDecode(response.body);

      // استخراج "personal_info" من "data"
      if (jsonMap.containsKey("data") && jsonMap["data"] is Map) {
        Map<String, dynamic> data = jsonMap["data"];
        if (data.containsKey("personal_info") && data["personal_info"] is Map) {
          Map<String, dynamic> personalInfo = data["personal_info"];
          Map<String, dynamic> statistics = data["statistics"];

          // حفظ البيانات في التخزين المؤقت
          prefs.setString('driverProfile', jsonEncode(data));

          // تحويل البيانات إلى كائن ProfileData
          ProfileData profileData =
              ProfileData.fromJson(personalInfo, statistics);
          print('Profile Data: $profileData'); // طباعة البيانات للتحقق
          return profileData;
        } else {
          throw Exception('Personal info not found in response');
        }
      } else {
        throw Exception('Data not found in response');
      }
    } else {
      // إذا كانت هناك مشكلة في الاستجابة
      throw Exception('Failed to load driver profile');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response =
        await http.get(Uri.parse('http://alwarsh.net/api/get_orders.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true) {
        List<dynamic> ordersJson = data['data'];
        var x = ordersJson.map((json) => Order.fromJson(json)).toList();
        return ordersJson.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders: ${data['message']}');
      }
    } else {
      throw Exception('Failed to load orders');
    }
  }

  // Future<List<complete>> fetchDeliveredOrders(int? driverId) async {
  //   final response = await http.get(Uri.parse(
  //       "http://alwarsh.net/api/get_driver_delivered_orders.php?driver_id=$driverId"));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);

  //     // Check if the API call was successful
  //     if (data['status'] == true) {
  //       // Extract the list of orders from the JSON response
  //       List<dynamic> ordersJson = data['data']['orders'];

  //       // Debugging: Print the raw JSON data
  //       print('Raw JSON Data: $ordersJson');

  //       // Convert the JSON list into a list of `complete` objects
  //       List<complete> orders =
  //           ordersJson.map((json) => complete.fromJson(json)).toList();

  //       // Debugging: Print the parsed orders
  //       print('Parsed Orders: $orders');

  //       return orders;
  //     } else {
  //       // If the API call was unsuccessful, throw an exception with the error message
  //       throw Exception("Failed to load orders: ${data['message']}");
  //     }
  //   } else {
  //     // If the HTTP request failed, throw an exception with the status code
  //     throw Exception("Failed to load orders: ${response.statusCode}");
  //   }
  // }

  Future<List<Order>> fetchActiveOrders(int? driverId) async {
    final String apiUrl =
        "http://alwarsh.net/api/get_driver_active_orders.php?driver_id=$driverId";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      // التحقق من نجاح الطلب
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // التحقق من حالة الاستجابة
        if (data['status'] == true) {
          final List<dynamic> acceptedOrders =
              data['data']['orders']['accepted'];
          final List<dynamic> inTransitOrders =
              data['data']['orders']['in_transit'];

          // تحويل JSON إلى قائمة من الكائنات open
          List<Order> orders = [];
          orders.addAll(
              acceptedOrders.map((json) => Order.fromJson(json)).toList());
          orders.addAll(
              inTransitOrders.map((json) => Order.fromJson(json)).toList());

          return orders; // إرجاع القائمة
        } else {
          throw Exception("Failed to load orders: ${data['message']}");
        }
      } else {
        throw Exception("Failed to load orders: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<complete>> fetchDeliveredOrders(int? driverId) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('deliveredOrders');

    // إذا كانت البيانات مخزنة محليًا، نستخدمها
    if (cachedData != null) {
      final List<dynamic> cachedOrders = jsonDecode(cachedData);
      return cachedOrders.map((json) => complete.fromJson(json)).toList();
    }

    // جلب البيانات من الخادم
    final response = await http.get(Uri.parse(
        "http://alwarsh.net/api/get_driver_delivered_orders.php?driver_id=$driverId"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // التحقق من نجاح الطلب
      if (data['status'] == true) {
        final List<dynamic> ordersJson = data['data']['orders'];

        // تحويل JSON إلى قائمة من الكائنات complete
        final List<complete> orders =
            ordersJson.map((json) => complete.fromJson(json)).toList();

        // حفظ البيانات في التخزين المؤقت
        prefs.setString('deliveredOrders', jsonEncode(ordersJson));

        return orders;
      } else {
        throw Exception("Failed to load orders: ${data['message']}");
      }
    } else {
      throw Exception("Failed to load orders: ${response.statusCode}");
    }
  }

  Future<void> refreshOrders(int? driverId) async {
    final prefs = await SharedPreferences.getInstance();

    // جلب البيانات من الخادم
    final List<complete> deliveredOrders = await fetchDeliveredOrders(driverId);

    // حفظ البيانات المحدثة في التخزين المؤقت
  }
}

// دالة لجلب الطلبات النشطة مع التخزين المؤقت


  // دالة لتحديث البيانات من الخادم


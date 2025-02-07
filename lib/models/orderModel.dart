// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Order {
  final String id; // رقم الطلب
  final String customerName;
  final String customerPhone; // اسم العميل
  final String status; // حالة الطلب
  final String? companyName;
  final String? companyImage; // اسم الشركة
  final String? pickupLocation; // مكان الاستلام
  final String? deliveryLocation; // مكان التسليم
  final String? orderType; // نوع الطلب
  final String? itemCount; // عدد القطع
  final String? orderDate; // تاريخ الطلب
  final String? additionalDetails;
  final String? paymentStatus;
  final String? totalAmount;

  final String? pickup_mapUrl;
  final String? delivery_mapUrl;
  final String? reset;

  Order({
    this.reset,
    this.pickup_mapUrl,
    this.delivery_mapUrl,
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.status,
    this.companyName,
    this.companyImage,
    this.pickupLocation,
    this.deliveryLocation,
    this.orderType,
    this.itemCount,
    this.orderDate,
    this.additionalDetails,
    this.paymentStatus,
    this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'].toString(),
      companyImage: json['company']["logo"],
      customerName: json['customer']['name'],
      customerPhone: json['customer']['phone'],
      status: json['order_details']['order_status'],
      companyName: json['company']['name'],
      pickupLocation: json['order_details']['locations']['pickup']['address'],
      deliveryLocation: json['order_details']['locations']['delivery']
          ['address'],
      delivery_mapUrl: json['order_details']['locations']['delivery']
          ['map_link'],
      pickup_mapUrl: json['order_details']['locations']["pickup"]['map_link'],
      orderType: json['order_details']['type'],
      itemCount: json['order_details']['items_count'].toString(),
      orderDate: json['order_details']['delivery_date'].toString(),
      additionalDetails: json['order_details']['additional_notes'],
      paymentStatus: json['order_details']['payment_status'],
      totalAmount: json['order_details']['costs']['total_amount'].toString(),
    );
  }

  toJson() {}
}

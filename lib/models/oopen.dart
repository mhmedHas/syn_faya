class open {
  final String id; // رقم الطلب
  final String customerName; // اسم العميل
  final String customerPhone; // هاتف العميل
  final String status; // حالة الطلب
  final String? companyName; // اسم الشركة
  final String? companyImage; // صورة الشركة
  final String? pickupLocation; // مكان الاستلام
  final String? deliveryLocation; // مكان التسليم
  final String? orderType; // نوع الطلب
  final String? itemCount; // عدد القطع
  final String? orderDate; // تاريخ الطلب
  final String? additionalDetails; // ملاحظات إضافية
  final String? paymentStatus; // حالة الدفع
  final String? totalAmount; // المبلغ الإجمالي

  open({
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

  // تحويل JSON إلى كائن open
  factory open.fromJson(Map<String, dynamic> json) {
    return open(
      id: json['order_id'].toString(),
      customerName: json['customer']['name'] as String,
      customerPhone: json['customer']['phone'] as String,
      status: json['order_details']['order_status'] as String,
      companyName: json['company']['name'] as String?,
      companyImage: json['company']['logo'] as String?,
      pickupLocation:
          json['order_details']['locations']['pickup']['address'] as String?,
      deliveryLocation:
          json['order_details']['locations']['delivery']['address'] as String?,
      orderType: json['order_details']['type'] as String?,
      itemCount: json['order_details']['items_count'].toString(),
      orderDate: json['dates']['order_date'].toString(),
      additionalDetails: json['order_details']['additional_notes'] as String?,
      paymentStatus: json['order_details']['payment_status'] as String?,
      totalAmount: json['order_details']['costs']['total_amount'].toString(),
    );
  }
}

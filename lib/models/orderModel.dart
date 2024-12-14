class Order {
  final int id; // رقم الطلب
  final String customerName;
  final String customerPhone; // اسم العميل
  final String status; // حالة الطلب
  final String? companyName; // اسم الشركة
  final String? pickupLocation; // مكان الاستلام
  final String? deliveryLocation; // مكان التسليم
  final String? orderType; // نوع الطلب
  final int? itemCount; // عدد القطع
  final DateTime? orderDate; // تاريخ الطلب
  final String? additionalDetails; // تفاصيل إضافية

  Order({
    required this.customerPhone,
    required this.id,
    required this.customerName,
    required this.status,
    this.companyName,
    this.pickupLocation,
    this.deliveryLocation,
    this.orderType,
    this.itemCount,
    this.orderDate,
    this.additionalDetails,
  });
}

class complete {
  final String? order_id;

  final String customerName;
  final String customerPhone;
  final String companyName;
  final String pickupLocation;
  final String deliveryLocation;
  final String orderType;
  final String itemCount;
  final String orderDate;
  final String additionalDetails;

  complete({
    this.order_id,
    required this.customerName,
    required this.customerPhone,
    required this.companyName,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.orderType,
    required this.itemCount,
    required this.orderDate,
    required this.additionalDetails,
  });

  factory complete.fromJson(Map<String, dynamic> json) {
    return complete(
      order_id: json['order_id'].toString(),
      customerName: json['customer']['name'],
      customerPhone: json['customer']['phone'],
      companyName: json['company']['name'],
      pickupLocation: json['order_details']['locations']['pickup']['address'],
      deliveryLocation: json['order_details']['locations']['delivery']
          ['address'],
      orderType: json['order_details']['type'],
      itemCount: json['order_details']['items_count'].toString(),
      orderDate: json['dates']['order_date'],
      additionalDetails: json['order_details']['additional_notes'],
    );
  }
}

class BookingDTO{
  int id;
  int customerId;
  String customerName;
  int lawyerId;
  String lawyerName;
  String bookingDate;
  String paymentMethod;
  int totalPrice;
  String payDate;
  int status;
  int customerCaseId;

  BookingDTO(
      {required this.id,
      required this.customerId,
      required this.customerName,
      required this.lawyerId,
      required this.lawyerName,
      required this.bookingDate,
      required this.paymentMethod,
      required this.totalPrice,
      required this.payDate,
      required this.status,
      required this.customerCaseId});

  factory BookingDTO.fromJson(Map<String, dynamic> json) {
    return BookingDTO(
      id : json['id'],
      customerId : json['customer_id'],
      customerName :json['customer_name'],
      lawyerId : json['lawyer_id'],
      lawyerName : json['lawyer_name'],
      bookingDate : json['booking_date'],
      paymentMethod : json['payment_method'],
      totalPrice : json['total_price'],
      payDate : json['pay_date'],
      status : json['status'],
      customerCaseId : json['customer_case_id']
    );
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['customer_id'] = this.customerId;
      data['customer_name'] = this.customerName;
      data['lawyer_id'] = this.lawyerId;
      data['lawyer_name'] = this.lawyerName;
      data['booking_date'] = this.bookingDate;
      data['payment_method'] = this.paymentMethod;
      data['total_price'] = this.totalPrice;
      data['pay_date'] = this.payDate;
      data['status'] = this.status;
      data['customer_case_id'] = this.customerCaseId;
    return data;
  }



}
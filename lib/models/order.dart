import 'package:advisories_lawyer/models/booking.dart';
import 'package:advisories_lawyer/models/customer_case.dart';

class Order{
  CustomerCase? customerCaseOfOrder;

  Booking? bookingOfOrder;

  Order();

  CustomerCase? getCustomerCaseOfOrder() {
    return customerCaseOfOrder;
  }
  Booking? getBookingOfOrder() {
    return bookingOfOrder;
  }



  void setCustomerCaseOfOrder(CustomerCase upCuscase) {customerCaseOfOrder = upCuscase;}

  void setBookingOfOrder(Booking upBooking) {bookingOfOrder = upBooking;}




 

}
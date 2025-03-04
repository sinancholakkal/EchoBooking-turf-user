class BookingTurfmodel {
  final String bookingDate; //
  final String bookingTime; //
  final String catogery; //
  final List<dynamic> images; //
  final String includes; //
  final String latitude;
  final String longitude;
  final String turfName; //
  final String turfId;
  final String landmark; //
  final String status;
  final String price;
  final String ownerId;
  final String userName;
  final String bookingId;
  Map<String,dynamic>?review;
  BookingTurfmodel({
    required this.bookingId,
    required this.price,
    required this.bookingDate,
    required this.landmark,
    required this.bookingTime,
    required this.catogery,
    required this.images,
    required this.includes,
    required this.latitude,
    required this.longitude,
    required this.turfName,
    required this.turfId,
    required this.status,
    required this.ownerId,
    required this.userName,
    this.review
  });
}

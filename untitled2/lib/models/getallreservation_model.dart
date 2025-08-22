class ReservationService {
  final int id;
  final String nameAr;
  final String nameEn;
  final int quantity;
  final String unitPrice;
  final String? location;
  final String? color;

  ReservationService({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.quantity,
    required this.unitPrice,
    required this.location,
    required this.color,
  });


  factory ReservationService.fromJson(Map<String, dynamic> data) {
    return ReservationService(
      id: data['id'],
      nameAr: data['service']['name_ar'],
      nameEn: data['service']['name_en'],
      quantity: data['quantity'],
      unitPrice: data['unit_price'],
      location: data['location'],
      color: data['color'],
    );
  }

  @override
  String toString() {
    return '    - Service: $nameAr / $nameEn\n'
        '      Quantity: $quantity, Unit Price: $unitPrice\n'
        '      Location: ${location ?? 'N/A'}, Color: ${color ?? 'N/A'}';
  }
}


class GetallreservationModel {
  final int reservId;
  final String reservationDate;
  final String startTime;
  final String endTime;
  final String? homeAddress; // Use nullable type since it can be null
  final String discountAmount;
  final String hallNameAr;
  final String hallNameEn;
  final String locationAr;
  final String locationEn;
  final int capacity;
  final String totalPrice;
  final String imageUrl;
  final List<ReservationService> services; // Add a list to hold services

  GetallreservationModel({
    required this.reservId,
    required this.reservationDate,
    required this.startTime,
    required this.endTime,
    required this.homeAddress,
    required this.discountAmount,
    required this.hallNameAr,
    required this.hallNameEn,
    required this.locationAr,
    required this.locationEn,
    required this.capacity,
    required this.totalPrice,
    required this.imageUrl,
    required this.services, // Include in constructor
  });

  // Factory constructor to create a ReservationModel from JSON data
  // Factory constructor لإنشاء ReservationModel من بيانات JSON
  factory GetallreservationModel.fromJson(Map<String, dynamic> data) {
    var servicesList = (data['reservation_services'] as List?)
        ?.map((serviceData) => ReservationService.fromJson(serviceData))
        .toList() ??
        [];

    return GetallreservationModel(
      reservId: data['id'],
      reservationDate: data['reservation_date'],
      startTime: data['start_time'],
      endTime: data['end_time'],
      homeAddress: data['home_address'],
      discountAmount: data['discount_amount'],
      hallNameAr: data['hall']['name_ar'],
      hallNameEn: data['hall']['name_en'],
      locationAr: data['hall']['location_ar'],
      locationEn: data['hall']['location_en'],
      capacity: data['hall']['capacity'],
      totalPrice: data['total_price'],
      imageUrl: data['hall']['image_url']['image_1'],
      services: servicesList, // Assign the parsed list
    );
  }
}
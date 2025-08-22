class GetReservationModel {
  final int reservationid;
  final String reservationdate;
  final String starttime;
  final String endtime;
  final String hallnamear;
  final String hallnameen;
  final int price;
  final List<Service> services;

  GetReservationModel(
      {required this.reservationid,
        required this.reservationdate,
        required this.starttime,
        required this.endtime,
        required this.hallnamear,
        required this.hallnameen,
        required this.price,
        required this.services});

  factory GetReservationModel.fromJson(Map<String, dynamic> data) {
    var servicesList = data['services'] as List;
    List<Service> parsedServices =
    servicesList.map((i) => Service.fromJson(i)).toList();

    return GetReservationModel(
      reservationid: data['reservation_id'],
      reservationdate: data['reservation_date'],
      starttime: data['start_time'],
      endtime: data['end_time'],
      hallnamear: data['hall']['name_ar'],
      hallnameen: data['hall']['name_en'],
      price: data['total_price'],
      services: parsedServices,
    );
  }
}

class Service {
  final int id;
  final String serviceNameAr;
  final String serviceNameEn;
  final int quantity;
  final String unitPrice;
  final int totalItemPrice;

  Service({
    required this.id,
    required this.serviceNameAr,
    required this.serviceNameEn,
    required this.quantity,
    required this.unitPrice,
    required this.totalItemPrice,
  });

  factory Service.fromJson(Map<String, dynamic> data) {
    return Service(
      id: data['id'],
      serviceNameAr: data['service_name_ar'],
      serviceNameEn: data['service_name_en'],
      quantity: data['quantity'],
      unitPrice: data['unit_price'],
      totalItemPrice: data['total_item_price'],
    );
  }
}

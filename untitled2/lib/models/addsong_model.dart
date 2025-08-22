



import '../Api/endpoint.dart';

class AddsongModel {
  final String reservation_id;
  final String artist;
  final String title;
  final int id;
  AddsongModel({
    required this.reservation_id,
    required this.artist,
    required this.title,
    required this.id,
  });

  factory AddsongModel.fromJson(Map<String, dynamic> jsonData) {
    return AddsongModel(
      id: int.tryParse(jsonData[ApiKey.id].toString()) ?? 0,

      title: jsonData[ApiKey.title] ?? '',
      artist: jsonData[ApiKey.artist] ?? '',
      reservation_id:
      jsonData[ApiKey.reservation_id] ?? '', // جلب اسم الـ DJ من داخل user
    );
  }

  static List<AddsongModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AddsongModel.fromJson(json)).toList();
  }
}

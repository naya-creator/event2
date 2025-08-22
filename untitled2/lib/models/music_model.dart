


import '../Api/endpoint.dart';

class MusicModel {
  final String id;
  final String title;
  final String artist;
  final String language;

  MusicModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.language,
  });

  factory MusicModel.fromJson(Map<String, dynamic> jsonData) {
    return MusicModel(
      id: jsonData[ApiKey.id].toString(),
      title: jsonData[ApiKey.title] ?? '',
      artist: jsonData[ApiKey.artist] ?? '',
      language: jsonData[ApiKey.language] ?? '',
    );
  }

  static List<MusicModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MusicModel.fromJson(json)).toList();
  }
}

class ErrorModel {
  final bool status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromjson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData['status'] ?? false,
      errorMessage: jsonData['errorMessage'] ??
          jsonData['message'] ??
          'حدث خطأ غير معروف', //لستقبال json
    );
  }
}

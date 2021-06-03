class ResponseModel {
  final String status;
  final String message;
  final dynamic data;

  ResponseModel(
      {required this.status, required this.message, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

import 'package:get/get.dart';

class model_status {
  String? id;
  String? sender;
  Rx<String>? status;

  model_status({this.id, this.sender, Rx<String>? status})
      : status = status ?? Rx<String>('');

  model_status.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sender = json['sender'],
        status = Rx<String>(json['status'] ?? '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'status': status?.value,
    };
  }
}

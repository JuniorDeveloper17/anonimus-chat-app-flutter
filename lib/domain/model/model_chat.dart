import 'package:get/get.dart';
class model_chat {
  String? id;
  String? sender;
  String? name;
  String? text;
  String? timestamp;
  Rx<String>? isRead;
  Rx<String>? status;
  String? repliedToId;
  String? repliedToName;
  String? repliedToText;
  String? repliedToTimestamp;
  String? attachmentsType;
  String? attachmentsUrl;

  model_chat({
    this.id,
    this.sender,
    this.name,
    this.text,
    this.timestamp,
    Rx<String>? isRead,
    Rx<String>? status,
    this.repliedToId,
    this.repliedToName,
    this.repliedToText,
    this.repliedToTimestamp,
    this.attachmentsType,
    this.attachmentsUrl,
  })  : isRead = isRead ?? Rx<String>(''),
        status = status ?? Rx<String>('');

  model_chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sender = json['sender'],
        name = json['name'],
        text = json['text'],
        timestamp = json['timestamp'],
        isRead = Rx<String>(json['isRead']),
        status = Rx<String>(json['status']),
        repliedToId = json['repliedTo_id'],
        repliedToName = json['repliedTo_name'],
        repliedToText = json['repliedTo_text'],
        repliedToTimestamp = json['repliedTo_timestamp'],
        attachmentsType = json['attachments_type'],
        attachmentsUrl = json['attachments_url'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'name': name,
      'text': text,
      'timestamp': timestamp,
      'isRead': isRead?.value,
      'status': status?.value,
      'repliedTo_id': repliedToId,
      'repliedTo_name': repliedToName,
      'repliedTo_text': repliedToText,
      'repliedTo_timestamp': repliedToTimestamp,
      'attachments_type': attachmentsType,
      'attachments_url': attachmentsUrl,
    };
  }
}

class model_delete {
  String? id;
  String? timestamp;

  model_delete({this.id, this.timestamp});

  model_delete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
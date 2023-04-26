import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  String? email;
  Timestamp? sendTime;
  String? name;
  String? photoUrl;

  MessageModel({this.message, this.sendTime, this.name, this.photoUrl, this.email});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['email'];
    sendTime = json['sendTime'];
    name = json['name'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['email'] = email;
    data['sendTime'] = sendTime;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    return data;
  }
}

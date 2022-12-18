// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {
  final String? displayName;
  final String? token;
  final String? email;
  final int? questionAnswered;
  final int? score;
  final double? bestTime;
  final DateTime? lastLogin;

  UserClass(this.displayName, this.token, this.email, this.lastLogin,
      this.questionAnswered, this.score, this.bestTime);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'token': token,
      'email': email,
      'questionAnswered': questionAnswered,
      'score': score,
      'bestTime': bestTime,
      'lastLogin': lastLogin?.millisecondsSinceEpoch,
    };
  }

  factory UserClass.fromMap(Map<String, dynamic> map) {
    return UserClass(
      map['displayName'] != null ? map['displayName'] as String : null,
      map['token'] != null ? map['token'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'].toDate().toString())
          : null,
      map['questionAnswered'] != null ? map['questionAnswered'] as int : null,
      map['score'] != null ? map['score'] as int : null,
      map['bestTime'] != null ? map['bestTime'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserClass.fromJson(String source) =>
      UserClass.fromMap(json.decode(source) as Map<String, dynamic>);
}

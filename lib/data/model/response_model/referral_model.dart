// To parse this JSON data, do
//
//     final referralModel = referralModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ReferralModel referralModelFromJson(String str) =>
    ReferralModel.fromJson(json.decode(str));

String referralModelToJson(ReferralModel data) => json.encode(data.toJson());

class ReferralModel {
  String? status;
  ReferralData? message;

  ReferralModel({
    this.status,
    this.message,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
        status: json["status"],
        message: json["message"] == null
            ? null
            : ReferralData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message?.toJson(),
      };
}

class ReferralData {
  String? referralLink;
  dynamic currency;
  Map<dynamic, List<Referral>>? referrals;
  Map<dynamic, dynamic>? levels;

  ReferralData({this.referralLink, this.referrals, this.levels, this.currency});

  factory ReferralData.fromJson(Map<String, dynamic> json) => ReferralData(
        currency: json['currency'],
        referralLink: json["referralLink"],
        referrals: Map.from(json["referrals"]!).map((k, v) =>
            MapEntry<dynamic, List<Referral>>(k,
                List<Referral>.from(v.map((x) => Referral.fromJson(x)) ?? {}))),
        levels: json['levels'] != null
            ? json['levels'].map((key, value) {
                return MapEntry(key, Level.fromJson(value));
              })
            : {},
      );

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "referralLink": referralLink,
        "referrals": Map.from(referrals!).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Level {
  final String? team;
  final String? commission;
  final String? totalInvest;
  final String? teamWithdraw;

  Level({
    required this.team,
    required this.commission,
    required this.totalInvest,
    required this.teamWithdraw,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      team: json['team'].toString(),
      commission: json['commission'].toString(),
      totalInvest: json['total_invest'].toString(),
      teamWithdraw: json['team_withdraw'].toString(),
    );
  }
}

class Referral {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? image;
  String? phoneCode;
  String? phone;
  String? total_invest;
  int? referralId;
  DateTime? createdAt;
  String? fullname;
  String? mobile;

  Referral({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.phoneCode,
    this.phone,
    this.total_invest,
    this.referralId,
    this.createdAt,
    this.fullname,
    this.mobile,
    this.image
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        total_invest: json['total_invest'].toString(),
        referralId: json["referral_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        fullname: json["fullname"],
        mobile: json["mobile"],
       image: json["image"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "phone_code": phoneCode,
        "phone": phone,
        "referral_id": referralId,
        "created_at": createdAt?.toIso8601String(),
        "fullname": fullname,
        "mobile": mobile,
         "image":image
      };
}

import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final String title;
  final List<RewardModel> lists;

  Reward({
    title,
    lists,
  }) : title = title ?? '',
        lists = lists ?? [];

  @override
  List<Object?> get props => [title, lists];

  static Reward fromJson(Map<String, dynamic> json, lists) => Reward(
    title: json['title'].toString(),
    lists: lists,
  );
}

class RewardModel extends Equatable  {
  final String id;
  final String name;
  final String points;
  final String deductPoints;
  final String refNo;
  final String date;
  final String logo;

  RewardModel({
    id,
    name,
    points,
    deductPoints,
    refNo,
    date,
    logo,
  }) : id = id ?? '',
        name = name ?? '',
        points = points ?? '',
        deductPoints = deductPoints ?? '',
        refNo = refNo ?? '',
        logo = logo ?? '',
        date = date ?? '';

  @override
  List<Object?> get props => [id, name, points, deductPoints, refNo,logo, date];

  static RewardModel fromJson(Map<String, dynamic> json) => RewardModel(
    id: json['id'].toString(),
    name: json['merchant'].toString(),
    points: json['add_point'].toString(),
    deductPoints: json['deduct_point'].toString(),
    refNo: json['ref_no'].toString(),
    logo: json['logo'].toString(),
    date: json['created_date'].toString(),
  );

  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'name': name,
        'points': points,
        'deductPoints': deductPoints,
        'refNo': refNo,
        'logo': logo,
        'date': date,
      };
}
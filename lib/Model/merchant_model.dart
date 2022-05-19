import 'package:equatable/equatable.dart';

class Merchant extends Equatable {
final String title;
final List<MerchantModel> lists;

Merchant({
  title,
  lists,
}) : title = title ?? '',
lists = lists ?? [];

  @override
  List<Object?> get props => [title, lists];

static Merchant fromJson(Map<String, dynamic> json, lists) => Merchant(
  title: json['title'].toString(),
  lists: lists,
);
}

class MerchantModel extends Equatable  {
  final String id;
  final String name;
  final String picture;
  final String lat;
  final String lng;
  final String address;
  final String phone;
  final String description;

  MerchantModel({
    id,
    name,
    picture,
    lat,
    lng,
    address,
    phone,
    description,
}) : id = id ?? '',
  name = name ?? '',
  picture = picture ?? '',
  lat = lat ?? '',
  lng = lng ?? '',
  address = address ?? '',
        description = description ?? '',
        phone = phone ?? '';

  @override
  List<Object?> get props => [id, name, picture, lat, lng,address,phone,description];

  static MerchantModel fromJson(Map<String, dynamic> json) => MerchantModel(
    id: json['id'].toString(),
    name: json['name'].toString(),
    picture: json['picture'].toString(),
    lat: json['lat'].toString(),
    lng: json['lng'].toString(),
    address: json['address'].toString(),
    phone: json['phone'].toString(),
    description: json['description'].toString(),
  );

  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'name': name,
        'picture': picture,
        'lat': lat,
        'lng': lng,
        'address': address,
        'phone': phone,
        'description': description,
      };
}
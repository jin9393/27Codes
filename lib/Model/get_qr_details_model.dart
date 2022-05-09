import 'package:equatable/equatable.dart';

class GetQrDetailsModel extends Equatable {
  final String id;
  final String status;
  final String created_date;
  final String voucher_amount;
  final String from;
  final String percent;
  final String use_point;

  GetQrDetailsModel({
    id,
    status,
    created_date,
    voucher_amount,
    from,
    percent,
    use_point,
  })  : id = id ?? '',
        status = status ?? '',
        created_date = created_date ?? '',
        voucher_amount = voucher_amount ?? '',
        from = from ?? '',
        percent = percent ?? '',
        use_point = use_point ?? '';

  @override
  List<Object?> get props => [id, status, created_date, voucher_amount, from,percent,use_point];

  static GetQrDetailsModel fromJson(Map<String, dynamic> json) =>
      GetQrDetailsModel(
        id: json['id'].toString(),
        status: json['status'].toString(),
        created_date: json['created_date'].toString(),
        voucher_amount: json['voucher_amount'].toString(),
        from: json['from'].toString(),
        percent: json['percent'].toString(),
        use_point: json['use_point'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'created_date': created_date,
        'voucher_amount': voucher_amount,
        'from': from,
        'percent': percent,
        'use_point': use_point,
      };
}

import 'package:equatable/equatable.dart';

class WorkingHour extends Equatable {
  final String day;
  final String open;
  final String closing;

  WorkingHour({
    day,
    open,
    closing,
  })  : day = day ?? '',
        open = open ?? '',
        closing = closing ?? '';

  @override
  List<Object?> get props =>
      [day, open, closing];

  static WorkingHour fromJson(Map<String, dynamic> json) => WorkingHour(
    day: json['day'].toString(),
    open: json['open'].toString(),
    closing: json['closing'].toString(),
      );
}

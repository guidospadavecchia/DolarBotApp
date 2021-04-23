import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

export 'package:decimal/decimal.dart';

@immutable
class DecimalAdapter {
  final Decimal decimal;

  DecimalAdapter(this.decimal);

  factory DecimalAdapter.tryParse(dynamic number) {
    if (number is DecimalAdapter) {
      return number;
    } else if (number is Decimal) {
      return DecimalAdapter(number);
    } else if (number is int) {
      return DecimalAdapter(Decimal.fromInt(number));
    }
    return DecimalAdapter(Decimal.parse(number.toString()));
  }

  bool get isNaN => decimal.isNaN;

  bool get isNegative => decimal.isNegative;

  DecimalAdapter operator ~/(dynamic other) =>
      DecimalAdapter(decimal ~/ DecimalAdapter.tryParse(other).decimal);

  bool get isInfinite => decimal.isInfinite;

  DecimalAdapter abs() => DecimalAdapter(decimal.abs());

  DecimalAdapter operator +(dynamic other) =>
      DecimalAdapter(decimal + DecimalAdapter.tryParse(other).decimal);

  DecimalAdapter operator -(dynamic other) =>
      DecimalAdapter(decimal - DecimalAdapter.tryParse(other).decimal);

  DecimalAdapter operator *(dynamic other) =>
      DecimalAdapter(decimal * DecimalAdapter.tryParse(other).decimal);

  DecimalAdapter operator /(dynamic other) =>
      DecimalAdapter(decimal / DecimalAdapter.tryParse(other).decimal);

  DecimalAdapter remainder(dynamic other) =>
      DecimalAdapter(decimal.remainder(DecimalAdapter.tryParse(other).decimal));

  int toInt() => decimal.toInt();

  @override
  bool operator ==(Object other) => decimal == DecimalAdapter.tryParse(other).decimal;

  @override
  String toString() => decimal.toString();

  double toDouble() => decimal.toDouble();

  DecimalAdapter round() => DecimalAdapter(decimal.round());

  @override
  int get hashCode => decimal.hashCode;
}

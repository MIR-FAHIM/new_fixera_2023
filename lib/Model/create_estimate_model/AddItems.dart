import 'package:flutter/cupertino.dart';

class AddItems{
  final String? TypeOfProject;
  final String? SelectMeasurment;
  final String? Discription;
  final String? Quantity;
  final String? PerUnitCharge;
  final String? Price;


  const AddItems({
    @required this.TypeOfProject,
    @required this.SelectMeasurment,
    @required this.Discription,
    @required this.Quantity,
    @required this.PerUnitCharge,
    @required this.Price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddItems &&
          runtimeType == other.runtimeType &&
          TypeOfProject == other.TypeOfProject &&
          SelectMeasurment == other.SelectMeasurment &&
          Discription == other.Discription &&
          Quantity == other.Quantity &&
          PerUnitCharge == other.PerUnitCharge &&
          Price == other.Price);

  @override
  int get hashCode =>
      TypeOfProject.hashCode ^
      SelectMeasurment.hashCode ^
      Discription.hashCode ^
      Quantity.hashCode ^
      PerUnitCharge.hashCode ^
      Price.hashCode;

  @override
  String toString() {
    return 'AddItems{' +
        ' TypeOfProject: $TypeOfProject,' +
        ' SelectMeasurment: $SelectMeasurment,' +
        ' Discription: $Discription,' +
        ' Quantity: $Quantity,' +
        ' PerUnitCharge: $PerUnitCharge,' +
        ' Price: $Price,' +
        '}';
  }

  AddItems copyWith({
    String? TypeOfProject,
    String? SelectMeasurment,
    String? Discription,
    String? Quantity,
    String? PerUnitCharge,
    String? Price,
  }) {
    return AddItems(
      TypeOfProject: TypeOfProject ?? this.TypeOfProject,
      SelectMeasurment: SelectMeasurment ?? this.SelectMeasurment,
      Discription: Discription ?? this.Discription,
      Quantity: Quantity ?? this.Quantity,
      PerUnitCharge: PerUnitCharge ?? this.PerUnitCharge,
      Price: Price ?? this.Price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'TypeOfProject': this.TypeOfProject,
      'SelectMeasurment': this.SelectMeasurment,
      'Discription': this.Discription,
      'Quantity': this.Quantity,
      'PerUnitCharge': this.PerUnitCharge,
      'Price': this.Price,
    };
  }

  factory AddItems.fromMap(Map<String, dynamic> map) {
    return AddItems(
      TypeOfProject: map['TypeOfProject'] as String,
      SelectMeasurment: map['SelectMeasurment'] as String,
      Discription: map['Discription'] as String,
      Quantity: map['Quantity'] as String,
      PerUnitCharge: map['PerUnitCharge'] as String,
      Price: map['Price'] as String,
    );
  }

//</editor-fold>
}



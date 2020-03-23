import 'package:intl/intl.dart';

class Bike {

  Bike({
    this.make,
    this.model,
    this.year,
    this.colour,
    this.motRenewalDate,
    this.mileageAtMot,
    this.lastServiceDate,
    this.mileageAtService,
    this.serviceInterval,
    this.insuranceCoverType,
    this.insurancePremium,
    this.insuranceProvider,
    this.insuranceRenewalDate,
    this.insuranceTotalExcess,
    this.insuranceUsage,
    this.insuranceYearsNoClaims,
    this.purchasePrice,
    this.purchaseType,
    this.valueOfAccessories,
    this.monthlyPayment,
    this.optionalFinalPayment,
    this.financeContractLength,
    this.financeEstimatedMileage
  });

  String make;
  String model;
  int year;
  int bikeAge;
  String colour;
  DateTime motRenewalDate;
  int mileageAtMot;
  DateTime lastServiceDate;
  int mileageAtService;
  int serviceInterval;
  String insuranceCoverType;
  double insurancePremium;
  String insuranceProvider;
  DateTime insuranceRenewalDate;
  double insuranceTotalExcess;
  String insuranceUsage;
  int insuranceYearsNoClaims;
  double purchasePrice;
  String purchaseType;
  double valueOfAccessories;
  double monthlyPayment;
  double optionalFinalPayment;
  int financeContractLength;
  int financeEstimatedMileage;

  factory Bike.fromJson(Map<String, String> json) {

    return Bike(
      make: json['make'],
      model: json['model'],
      year: int.parse(json['year']),
      colour: json['colour'],
      motRenewalDate: new DateFormat("dd/MM/yyyy", "en_GB").parse(json['motRenewalDate']),
      mileageAtMot: int.parse(json['mileageAtMot']),
      lastServiceDate: new DateFormat("dd/MM/yyyy", "en_GB").parse(json['lastServiceDate']),
      mileageAtService: int.parse(json['mileageAtService']),
      serviceInterval: int.parse(json['serviceInterval']),
      insuranceCoverType: json['insuranceCoverType'],
      insurancePremium: double.parse(json['insurancePremium']),
      insuranceProvider: json['insuranceProvider'],
      insuranceRenewalDate: new DateFormat("dd/MM/yyyy", "en_GB").parse(json['insuranceRenewalDate']),
      insuranceTotalExcess: double.parse(json['insuranceTotalExcess']),
      insuranceUsage: json['insuranceUsage'],
      insuranceYearsNoClaims: int.parse(json['insuranceYearsNoClaims']),
      purchasePrice: double.parse(json['purchasePrice']),
      purchaseType: json['purchaseType'],
      valueOfAccessories: double.parse(json['valueOfAccessories']),
      monthlyPayment: double.parse(json['monthlyPayment']),
      optionalFinalPayment: double.parse(json['optionalFinalPayment']),
      financeContractLength: int.parse(json['financeContractLength']),
      financeEstimatedMileage: int.parse(json['financeEstimatedMileage'])
    );
  }

  Map<String,dynamic> get map {
    return {
      "make": make,
      "model": model,
      "year": year,
      "colour": colour,
      "motRenewalDate": motRenewalDate,
      "mileageAtMot": mileageAtMot,
      "lastServiceDate": lastServiceDate,
      "mileageAtService": mileageAtService,
      "serviceInterval": serviceInterval,
      "insuranceCoverType": insuranceCoverType,
      "insurancePremium": insurancePremium,
      "insuranceProvider": insuranceProvider,
      "insuranceRenewalDate": insuranceRenewalDate,
      "insuranceTotalExcess": insuranceTotalExcess,
      "insuranceUsage": insuranceUsage,
      "insuranceYearsNoClaims": insuranceYearsNoClaims,
      "purchasePrice": purchasePrice,
      "purchaseType": purchaseType,
      "valueOfAccessories": valueOfAccessories,
      "monthlyPayment": monthlyPayment,
      "optionalFinalPayment": optionalFinalPayment,
      "financeContractLength": financeContractLength,
      "financeEstimatedMileage": financeEstimatedMileage
    };
  }

  int get age {
    return bikeAge;
  }

  void set age(int currentYear) {
    bikeAge = currentYear - year;
  }

}
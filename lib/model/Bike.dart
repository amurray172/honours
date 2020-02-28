class Bike {
  String make;
  String model;
  int manufactureYear;
  int bikeAge;
  String color;

  Map<String,dynamic> get map {
    return {
      "make": make,
      "model": model,
      "manufactureYear": manufactureYear,
      "color": color,
    };
  }

  int get age {
    return bikeAge;
  }

  void set age(int currentYear) {
    bikeAge = currentYear - manufactureYear;
  }

  Bike({this.make,this.model,this.manufactureYear,this.color,});
}
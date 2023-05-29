class RealEstateModel {
  String city, distributionType, description, buildingType, condition, _id, _salesman, address;
  List<String> pictures;
  bool publicUtility;
  int price, areaSize, numberOfRooms;
  double latitude, longitude;

  String get id => _id;
  String get salesman => _salesman;

  RealEstateModel(this._id, this.city, this.distributionType, this.price, this.description, this.buildingType, this.condition, this.pictures,
  this.publicUtility, this.areaSize, this.numberOfRooms, this._salesman, this.address, this.latitude, this.longitude);

  factory RealEstateModel.fromJson(Map<String, dynamic> json) => RealEstateModel(
    json['_id'] as String,
    json['city'] as String,
    json['distributionType'] as String,
    json['price'] as int,
    json['description'] as String,
    json['buildingType'] as String,
    json['condition'] as String,
    (json['pictures'] as List<dynamic>).map((e) => e as String).toList(),
    json['publicUtility'] as bool,
    json['areaSize'] as int,
    json['numberOfRooms'] as int,
    json['_salesman'] as String,
    json['address'] as String,
    json['latitude'] as double,
    json['longitude'] as double,
  );
}
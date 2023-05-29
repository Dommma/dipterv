class CustomerModel {
  String name, address, mobileNumber, emailAddress, _id, salesman;

  String get id => _id;

  CustomerModel(this._id, this.name, this.address, this.mobileNumber, this.emailAddress, this.salesman);

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    json['_id'] as String,
    json['name'] as String,
    json['address'] as String,
    json['mobileNumber'] as String,
    json['emailAddress'] as String,
    json['salesman'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
    'address': this.address,
    'mobileNumber': this.mobileNumber,
    'emailAddress': this.emailAddress,
    '_id': this._id,
    'salesman': this.salesman,
  };
}
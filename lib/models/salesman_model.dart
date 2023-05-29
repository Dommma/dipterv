class SalesmanModel {
  String name, mobileNumber, emailAddress, rank, profilePicture, _id;

  String get id => _id;

  SalesmanModel(this._id, this.name, this.rank, this.mobileNumber, this.emailAddress, this.profilePicture);

  factory SalesmanModel.fromJson(Map<String, dynamic> json) => SalesmanModel(
    json['_id'] as String,
    json['name'] as String,
    json['rank'] as String,
    json['mobileNumber'] as String,
    json['emailAddress'] as String,
    json['profilePicture'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': this.name,
    'mobileNumber': this.mobileNumber,
    'emailAddress': this.emailAddress,
    'rank': this.rank,
    'profilePicture': this.profilePicture,
    '_id': this._id,
  };
}
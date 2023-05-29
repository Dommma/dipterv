class EventModel {
  String title, creator, description;
  DateTime dateTime;
  String? _id;

  String? get id => _id;

  EventModel(this.title, this.dateTime, this.description, this.creator, this._id);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final id = json['_id'];
    final title = json['title'];
    final year = json['year'];
    final month = json['month'];
    final day = json['day'];
    final hour = json['hour'];
    final minute = json['minute'];
    final description = json['description'];
    final creator = json['_creator'];
    final dateT = DateTime(year, month, day, hour, minute);
    return EventModel(title, dateT, description, creator, id);
  }
  Map<String, dynamic> toJson() {
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    return <String, dynamic>{
      'title': this.title,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'description': this.description,
      'creator' : this.creator
    };
  }

}
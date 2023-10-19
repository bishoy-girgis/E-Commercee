class AddAddressModel {
  AddAddressModel({
    this.status,
    this.message,
    this.data,
  });

  AddAddressModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  String? status;
  String? message;
  List<Data>? data;
}

class Data {
  Data({
    this.id,
    this.name,
    this.details,
    this.city,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    details = json['details'];
    city = json['city'];
  }

  String? id;
  String? name;
  String? details;
  String? city;
}

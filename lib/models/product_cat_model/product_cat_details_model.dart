class ProductCatDetailModel {
  bool? success;
  String? message;
  List<Data>? data;

  ProductCatDetailModel({this.success, this.message, this.data});

  ProductCatDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var rowId;
  var productId;
  var productName;
  var productDescription;
  var stockQuantity;
  var price;
  var imagePath;
  var point;

  Data(
      {this.rowId,
        this.productId,
        this.productName,
        this.productDescription,
        this.stockQuantity,
        this.price,
        this.point,
        this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    rowId = json['row_Id'];
    productId = json['productId'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    stockQuantity = json['stockQuantity'];
    price = json['price'];
    point = json['point'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row_Id'] = this.rowId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['stockQuantity'] = this.stockQuantity;
    data['price'] = this.price;
    data['point'] = this.point;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
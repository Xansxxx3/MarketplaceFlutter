import 'package:marketplacedb/data/models/products/product_category_model.dart';

class ProductTypeModel {
  int? id;
  String? name;
  ProductCategoryModel? productCategory;
  String? description;

  ProductTypeModel(
      {this.description, this.id, this.name, this.productCategory});

  ProductTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['product_category'] != null) {
      productCategory = ProductCategoryModel.fromJson(json['product_category']);
    } else {
      productCategory = null;
    }
    description = json['description'];
  }
}

import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';

class GetWishlistModel extends GetWishlistEntity {
  GetWishlistModel({
    super.status,
    super.count,
    super.data,
  });

  GetWishlistModel.fromJson(dynamic json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
}

class Data extends DataWishListEntity {
  Data({
    super.sold,
    super.images,
    this.subcategory,
    super.ratingsQuantity,
    super.id,
    super.title,
    super.slug,
    super.description,
    super.quantity,
    super.price,
    super.imageCover,
    this.category,
    super.brand,
    super.ratingsAverage,
    super.createdAt,
    super.updatedAt,
    super.v,
  });

  Data.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(Subcategory.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    imageCover = json['imageCover'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    id = json['id'];
  }

  List<Subcategory>? subcategory;
  Category? category;
}

class Brand extends BrandWishListEntity {
  Brand({
    super.id,
    super.name,
    super.slug,
    super.image,
  });

  Brand.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  String? id;
  String? name;
  String? slug;
  String? image;
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  Subcategory.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }

  String? id;
  String? name;
  String? slug;
  String? category;
}

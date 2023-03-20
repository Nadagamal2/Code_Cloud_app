  class CategoryIdallSearchModel {
  int? id;
  String? title;
  String? imgUrl;
  String? link;
  String? details;
  String? offer;
  String? saleCode;
  bool? isFaviourite;
  bool? isSpecial;
  String? phoneNumber;
  String? storAddress;
  bool? acceptLocoCard;
  int? categoryId;
  Category? category;
  int? countryId;
  Country? country;

  CategoryIdallSearchModel({
    this.id,
    this.title,
    this.imgUrl,
    this.link,
    this.details,
    this.offer,
    this.saleCode,
    this.phoneNumber,
    this.acceptLocoCard,
    this.categoryId,
    this.category,
    this.countryId,
    this.country,
    this.storAddress,
    this.isFaviourite,
    this.isSpecial,
  });

  factory CategoryIdallSearchModel.fromJson(Map<String, dynamic> json) {
    return CategoryIdallSearchModel(
      id: json['id'],
      title: json['stor_Title'],
      imgUrl: json['stor_ImgUrl'],
      link: json['stor_Link'],
      details: json['stor_Deteils'],
      storAddress: json['stor_Address'],
      offer: json['stor_Offer'],
      saleCode: json['stor_SaleCode'],
      phoneNumber: json['stor_PhoneNumber'],
      acceptLocoCard: json['accept_Loco_Card'],
      categoryId: json['catgId'],
      isFaviourite: json['isFaviourite'],
      isSpecial: json['isSpecial'],
      category: Category.fromJson(json['categories']),
      countryId: json['countId'],
      country: Country.fromJson(json['countries']),
    );
  }
}

class Category {
  int? id;
  String? name;
  String? iconUrl;

  Category({
    this.id,
    this.name,
    this.iconUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['categ_Name'],
      iconUrl: json['cated_IconUrl'],
    );
  }
}

class Country {
  int? id;
  String? name;
  String? flagUrl;

  Country({
    this.id,
    this.name,
    this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['cont_Name'],
      flagUrl: json['cont_FlagUrl'],
    );
  }
}
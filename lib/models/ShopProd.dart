class Product {
  String productSeq;
  String productNo;
  String shopID;
  String productName;
  String productDescription;
  String productImage;
  String productPrice;
  String productQty;
  String productUnit;
  String purchaseLimitOnQty;
  String totalPurchase;
  String productRating;
  String itemAvailable;
  String iteminStock;
  String fixeditemforSale;
  String productType;
  String productCategory;
  String productSubCategory;
  String isActive;
  String creationTime;
  String updatedTime;

  Product(
      {
        this.productSeq,
        this.productNo,
        this.shopID,
        this.productName,
        this.productDescription,
        this.productImage,
        this.productPrice,
        this.productQty,
        this.productUnit,
        this.purchaseLimitOnQty,
        this.totalPurchase,
        this.productRating,
        this.itemAvailable,
        this.iteminStock,
        this.fixeditemforSale,
        this.productType,
        this.productCategory,
        this.productSubCategory,
        this.isActive,
        this.creationTime,
        this.updatedTime});

  Product.fromJson(Map<String, dynamic> json) {
    productNo = json['productNo'];
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    productQty = json['productQty'];
    productUnit = json['productUnit'];
    productType = json['productType'];
    productCategory = json['productCategory'];
    productSubCategory = json['productSubCategory'];

    productSeq = json['productSeq'];
    productDescription = json['productDescription'];
    shopID = json['shopID'];
    purchaseLimitOnQty = json['purchaseLimitOnQty'];
    totalPurchase = json['totalPurchase'];
    productRating = json['productRating'];
    itemAvailable = json['itemAvailable'];
    iteminStock = json['iteminStock'];
    fixeditemforSale = json['fixeditemforSale'];

    isActive = json['isActive'];
    creationTime = json['creationTime'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productSeq'] = this.productSeq;
    data['productNo'] = this.productNo;
    data['shopID'] = this.shopID;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productPrice'] = this.productPrice;
    data['productQty'] = this.productQty;
    data['productUnit'] = this.productUnit;
    data['purchaseLimitOnQty'] = this.purchaseLimitOnQty;
    data['totalPurchase'] = this.totalPurchase;
    data['productRating'] = this.productRating;
    data['itemAvailable'] = this.itemAvailable;
    data['iteminStock'] = this.iteminStock;
    data['fixeditemforSale'] = this.fixeditemforSale;
    data['productType'] = this.productType;
    data['productCategory'] = this.productCategory;
    data['productSubCategory'] = this.productSubCategory;
    data['isActive'] = this.isActive;
    data['creationTime'] = this.creationTime;
    data['updatedTime'] = this.updatedTime;
    return data;
  }
}

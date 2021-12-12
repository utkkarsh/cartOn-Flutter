class ShopItem {

  String productSeq;
  String productNo;
  String shopID;
  String shopName;
  String shopAddress;
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
  int itemCartQty;

  ShopItem(
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
        this.updatedTime
      });

  ShopItem.fromJson(Map<String, dynamic> json) {
    productNo = json['productNo'];
    productName = json['productName'];
    productType = json['productType'];
    productCategory = json['productCategory'];
    productSubCategory = json['productSubCategory'];
    productPrice = json['productPrice'];
    productImage = json['productImage'];
    productUnit = json['productUnit'];
    productQty = json['productQty'];
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

    itemCartQty = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopID'] = this.shopID;
    data['shopName'] = this.shopName;
    data['shopAddress'] = this.shopAddress;
    data['productNo'] = this.productNo;
    data['productName'] = this.productName;
    data['productType'] = this.productType;
    data['productCategory'] = this.productCategory;
    data['productSubCategory'] = this.productSubCategory;
    data['productPrice'] = this.productPrice;
    data['productImage'] = this.productImage;
    data['productUnit'] = this.productUnit;
    data['productQty'] = this.productQty;
    data['itemCartQty'] = this.itemCartQty.toString();
    return data;
  }
}

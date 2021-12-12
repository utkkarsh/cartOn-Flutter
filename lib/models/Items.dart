class Items {
  String custId;
  String orderNumber;
  String itemSeqNo;
  String prodNumber;
  String itemValue;
  String itemDiscount;
  String vendorId;

  Items(
      { this.custId,
        this.orderNumber,
        this.itemSeqNo,
        this.prodNumber,
        this.itemValue,
        this.itemDiscount,
        this.vendorId});

  Items.fromJson(Map<String, dynamic> json) {
    custId = json['cust_id'];
    orderNumber = json['order_number'];
    itemSeqNo = json['item_seq_no'];
    prodNumber = json['prod_number'];
    itemValue = json['item_value'];
    itemDiscount = json['item_discount'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cust_id'] = this.custId;
    data['order_number'] = this.orderNumber;
    data['item_seq_no'] = this.itemSeqNo;
    data['prod_number'] = this.prodNumber;
    data['item_value'] = this.itemValue;
    data['item_discount'] = this.itemDiscount;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}

class OrderItem {
  String shopID;
  String productNo;
  String productName;
  String productType;
  String productCategory;
  String productSubCategory;
  String productImage;
  String productUnit;
  int productQty;
  int itemCartQty;
  double productPrice;

  OrderItem(
      {this.shopID,
        this.productNo,
        this.productName,
        this.productType,
        this.productCategory,
        this.productSubCategory,
        this.productPrice,
        this.productImage,
        this.productUnit,
        this.productQty,
        this.itemCartQty});

  OrderItem.fromJson(Map<String, dynamic> json) {
    shopID = json['shopID'];
    productNo = json['productNo'];
    productName = json['productName'];
    productType = json['productType'];
    productCategory = json['productCategory'];
    productSubCategory = json['productSubCategory'];
    productPrice = double.parse(json['productPrice']);
    productImage = json['productImage'];
    productUnit = json['productUnit'];
    productQty = int.parse(json['productQty']);
    itemCartQty = int.parse(json['itemCartQty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopID'] = this.shopID;
    data['productNo'] = this.productNo;
    data['productName'] = this.productName;
    data['productType'] = this.productType;
    data['productCategory'] = this.productCategory;
    data['productSubCategory'] = this.productSubCategory;
    data['productPrice'] = this.productPrice;
    data['productImage'] = this.productImage;
    data['productUnit'] = this.productUnit;
    data['productQty'] = this.productQty;
    data['itemCartQty'] = this.itemCartQty;
    return data;
  }
}
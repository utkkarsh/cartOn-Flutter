import 'dart:convert';
import 'dart:ui';
import 'package:CartOn/models/Items.dart';
import 'package:CartOn/models/Order.dart';
import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/models/address.dart';
import 'package:CartOn/models/pToken.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:flushbar/flushbar.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:CartOn/util/DefaultFunctions.dart';
import 'package:CartOn/models/callAPI.dart';
import 'package:CartOn/util/Router.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Razorpay _razorpay = Razorpay();

  String selectedPaymentMethod = "online";
  String selectedDelMethod = "deliver";
  bool buttonState = true;
  String errorMessage ="";
  String addressString="Loading...";
  Address globalAddress;
  String payStatus = "none";

  String customerDetailsName = "";
  String customerDetailsPhone = "";
  String customerToken="";
  String payResponse = "";
  String paySignature="";
  String razorPayOrderID;
  String tokenKey="";
  String tokenSecret="";

  //Order Local Variables
  // List items=[];
  // List listofShops =[];
  // List listofShopItems=[];
  List itemsFromCart=[];
  double orderTotal;

  List paymentMethods = [
    {
      'payMethod': "Pay Online",
      'methodValue' :'online',
      'icon':'credit'
    },
    {
      'payMethod':'Pay on Delivery',
      'methodValue' :'offline',
      'icon':'payCash'

    },
  ] ;

  List deliveryMethods = [
    {
      'payMethod': "Deliver at your place",
      'methodValue' :'deliver',
      'icon':'deliveryStore'
    },
    {
      'payMethod':'Pickup from store',
      'methodValue' :'pickup',
      'icon':'pickFromStore'
    },
  ] ;

  get_pToken() async{
    pToken data = await getPayToken('CHECKOUT');
    setState(() {
      tokenKey=data.ptokenKey;
      tokenSecret = data.ptokenSecret;
    });

  }

  getAddressData() async{
    var tempAddressString = await getCustomerAddressInString();
    var tempAddress = await getCustomerAddress();
    setState(() {
      addressString=tempAddressString;
      globalAddress = tempAddress!=null?Address.fromJson(tempAddress):null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    Map<String,String> orderBillingError = store.checkValidityofPrices();
    String tempValue = "";
    orderBillingError.forEach((key, value) {
      tempValue =  tempValue +" , " + key + " ( Min Cart Value "+ Constant.RUPEE+ value.toString()+")";
    });
    String tempMsg =  "Order not meeting minimum cart value for shop " + tempValue + ".\n\nPlease add more items to Continue.";
    if(orderBillingError.length>0){
      setState(() {
        buttonState=false;
        errorMessage = tempMsg;
      });
    }

    if(payStatus=='error')
    {
      Flushbar(
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          title:  "Payment Cancelled",
          message:  payResponse,
          duration:  Duration(seconds: 10)
      )..show(context);
    }

    return
      Scaffold(
        appBar: NewAppBar(
          text: 'Checkout',
          isCenterTitle: false,
          isHideSearch: true,
          showBackButton:false,
          context: context,
            showHomeIcon:false
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Constant.PADDING_VIEW),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Delivering Items To ',
                  fontColor: Pallete.shopTitleText,
                  fontFamily: Constant.QS_SEMIBOLD,
                  fontSize: Constant.TEXT_FONT,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  margin: EdgeInsets.only(top: 8,bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      text: addressString!=null?addressString:'No address on this account.',
                      fontColor: Pallete.shopTitleText,
                      fontFamily: Constant.QS_REGULAR,
                      fontSize: Constant.TEXT_FONT,
                      maxLines: 2,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextWidget(
                  text: 'Preferred Payment Method',
                  fontColor: Pallete.shopTitleText,
                  fontFamily: Constant.QS_SEMIBOLD,
                  fontSize: Constant.TEXT_FONT,
                ),
                Container(
                  margin: EdgeInsets.only(top:8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...List.generate(
                          paymentMethods.length, (index) => 
                          Expanded(child: paymentMethodCard(paymentMethods[index]["payMethod"],paymentMethods[index]["methodValue"],paymentMethods[index]["icon"]))
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                TextWidget(
                  text: 'Preferred Delivery Method',
                  fontColor: Pallete.shopTitleText,
                  fontFamily: Constant.QS_SEMIBOLD,
                  fontSize: Constant.TEXT_FONT,
                ),
                Container(
                  margin: EdgeInsets.only(top:8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...List.generate(
                          deliveryMethods.length, (index) =>
                          Expanded(child: deliveryMethodCard(deliveryMethods[index]["payMethod"],deliveryMethods[index]["methodValue"],deliveryMethods[index]["icon"]))
                      )
                    ],
                  ),
                )
                ,
                SizedBox(height: 15,),
                TextWidget(
                  text: 'Bill Details',
                  fontColor: Pallete.shopTitleText,
                  fontFamily: Constant.QS_SEMIBOLD,
                  fontSize: Constant.TEXT_FONT,
                ),
                Container(
                  margin: EdgeInsets.only(top:8),
                  child: showOrderBrief(store),
                ),
                SizedBox(height: 15,),
                errorMessage!=""&&buttonState!=true ? Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(top:8),
                  decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Center(
                      child: Text(
                          errorMessage,
                      style: TextStyle(
                        color: Colors.red
                      ),)
                  ),
                ):Container()
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRect(
          child: BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color:Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: FlatButton(
                      disabledColor: Pallete.buttonDisabledColor2,
                      disabledTextColor: Pallete.textDisabledColor2,
                      child: Text(
                        addressString!=null?'Continue':'Add Address to Continue',
                        style: TextStyle(
                          color: buttonState!=false?Colors.black:Pallete.textDisabledColor2,
                          fontSize:  Constant.BUTTON_FONT - 1,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                        ),
                      ),
                      // highlightedBorderColor: Colors.green,
                      color: Pallete.smallButtonColor1,
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
                      onPressed: addressString!=null&&buttonState!=false?() {
                        checkPayMethod(store);
                      }:null
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
  // Center(
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: <Widget>[
  // Container(
  // child: RaisedButton(onPressed: openCheckout, child: Text('Open'))
  // )
  // ])
  // )


  @override
  void initState() {
    super.initState();
    getAddressData();
    get_pToken();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();

  }

  void checkPayMethod(store) async {

    await getUserData(store);
    //create order request
    if(selectedPaymentMethod=="online"){
      //  Call RazorPay order API & get order ID
      //  update orderID in razorpay payment request
      //  Open payment page for payment
      openCheckout(store);
    }
    else{
      //  Place the order
      var payStatus = 'offline';
      var paymentId = "";
      var paySignature = "";
      await createOrder(payStatus,paymentId,paySignature);
    }

  }

  getUserData (store) async {
    var list = <String>[];
    list = await getCustomerDetails();
    var token = await getTokens();

    if ( list.length > 1)
    {
      setState(() {
        customerDetailsName = list[0];
        customerDetailsPhone = list[1];
        customerToken = token;
        orderTotal = store.getCartTotal();
        itemsFromCart = store.getItemsFromCart();
        // email = list[3];
      });
    }
    // print(custName + phone);
  }



  Future<void> openCheckout(store) async {
    var key = tokenKey;
        //'rzp_test_ktCdwo1WZO9gAj';
    var secret = tokenSecret;
        //'XmbLqHQJKhyzyFFDq0EDvy0v';
    var amount = store.getCartTotal() * 100; //in the smallest currency sub-unit.

    print(razorPayOrderID);
    var rzpOrderID = razorPayOrderID!=null?razorPayOrderID:await generateOrderId(key,secret,amount);

    if(rzpOrderID!=null)
      {
        var options = {
          'key': tokenKey,//'rzp_test_ktCdwo1WZO9gAj', //'rzp_test_1DP5mmOlF5G5ag',
          'amount': amount, //in the smallest currency sub-unit.
          'name': 'CartOn Pvt. Ltd.',
          'order_id': rzpOrderID, // Generate order_id using Orders API
          'description': customerDetailsName.toString(),
          'timeout': 300, // in seconds
          'prefill': {
            'contact': customerDetailsPhone.toString(),
            'email': 'support@carton.com'
          },
          'send_sms_hash': false,
          'language':'hindi',
          'theme': {
            'hide_topbar' : true,
          }
        };

        setState(() {
          razorPayOrderID = rzpOrderID;
        });

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e);
        }

      }

  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId);
    // var store = Provider.of<MyStore>(context,listen: false);

    var payStatus = 'success';
    var paymentId = response.paymentId;
    var paySignature = response.signature;
    print('I am calling order service after payment');
    Future.delayed(const Duration(milliseconds: 50), ()async {
      await createOrder(payStatus,paymentId,paySignature);
    });

  }

  void _handlePaymentError(PaymentFailureResponse response) {

    Future.delayed(Duration.zero, () {
      Fluttertoast.showToast(
          msg: "ERROR: " + response.code.toString() + " - " + response.message);
    });


    // setState(() {
    //   payStatus = 'error';
    //   payResponse = response.message.toString();
    // });

    }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName);
  }



  Widget deliveryMethodCard(name,  methodValue,icon)
  {
    return GestureDetector(
      onTap: ()=>{
        setState(() {
          selectedDelMethod = methodValue;
        })
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Stack(
          // alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child:CircularCheckBox(
                  value: selectedDelMethod==methodValue?true:false,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  checkColor: Colors.white,
                  activeColor: Pallete.addItemButtonColor3,
                  onChanged: (bool x) {
                    setState(() {
                      selectedDelMethod = methodValue;
                    });
                    // someBooleanValue = !someBooleanValue;
                  }
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset('${Constant.PATH_IMAGE}/svg/$icon.svg',height: 45,),
                      Text(
                          name.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:TextStyle(
                            color: Pallete.shopTitleText,
                            fontFamily: Constant.QS_SEMIBOLD,
                            fontSize: Constant.TEXT_FONT,
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentMethodCard(name,  methodValue, icon)
  {
    return GestureDetector(
      onTap: ()=>{
        setState(() {
          selectedPaymentMethod = methodValue;
        })
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Stack(
          // alignment: Alignment.center,
          children: [
            Align(
            alignment: Alignment.topRight,
              child:CircularCheckBox(
                value: selectedPaymentMethod==methodValue?true:false,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                checkColor: Colors.white,
                activeColor: Pallete.addItemButtonColor3,
                onChanged: (bool x) {
                  setState(() {
                    selectedPaymentMethod = methodValue;
                  });
                  // someBooleanValue = !someBooleanValue;
                }
            ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset('${Constant.PATH_IMAGE}/svg/$icon.svg',height: 45,),
                      Text(
                        name.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      style:TextStyle(
                        color: Pallete.shopTitleText,
                        fontFamily: Constant.QS_SEMIBOLD,
                        fontSize: Constant.TEXT_FONT,
                      )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showOrderBrief(store)
  {

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: 'Ordering '+ store.getItemsinCart().toString() +' Items from '+ store.getUniqueShopsFromCart().length.toString() + ' shop.'),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Item Total',
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.QS_MEDIUM,
                    fontSize: Constant.TEXT_FONT-1,
                  ),
                  TextWidget(
                    text: Constant.RUPEE +' '+ store.getCartTotal().toString(),
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.OXY_REGULAR,
                    fontSize: Constant.TEXT_FONT-1,
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Delivery Fee',
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.QS_MEDIUM,
                    fontSize: Constant.TEXT_FONT-1,
                  ),
                  TextWidget(
                    text: Constant.RUPEE +' '+ store.getDeliveryFee().toString(),
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.OXY_REGULAR,
                    fontSize: Constant.TEXT_FONT-1,
                  ),
                ],
              ),
              SizedBox(height: 7,),
              Divider(
                height: 2,
                thickness: 1,
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'To Pay',
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.QS_BOLD,
                    fontSize: Constant.TEXT_FONT-1,
                  ),
                  TextWidget(
                    text: Constant.RUPEE +' '+ store.getTotalPayValue().toString(),
                    fontColor: Pallete.shopTitleText,
                    fontFamily: Constant.OXY_BOLD,
                    fontSize: Constant.TEXT_FONT-1,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  // initializeOrder() async{
  //   print(itemsFromCart);
  //
  //   itemsFromCart.forEach((element) {
  //     print('I am in');
  //     print(element.toJson());
  //     items.add(element.toJson());
  //   });
  //
  //   final uniqueShops = items.groupBy((m) => m["shopID"]);
  //   listofShops = uniqueShops.keys.toList();
  //   listofShopItems = uniqueShops.values.toList();
  //   print('Debugging - MET initializeOrder');
  //   print(listofShops);
  //
  //   // Temporary Variable For Calculating Price by Shop Level.
  //   var priceShopLevel = new Map();
  //   for( var data in listofShopItems) {
  //     var orderSplitTotal = data.fold(0, (previousValue, element) =>
  //     previousValue + int.parse(element["itemCartQty"]) *
  //         double.parse(element["productPrice"]));
  //     print(orderSplitTotal);
  //     priceShopLevel[0]=orderSplitTotal;
  //   }
  //
  //   priceShopLevel.forEach((key, value) {print('My Key is ' + key);});
  //   var details = new Map();
  //   details['Usrname'] = 'admin';
  //   details['Password'] = 'admin@123';
  //   print(priceShopLevel);
  //   print('I am done');
  // }

  createOrder(String payStatus,String payResponse,String paySignature) async
  {
    var store = Provider.of<MyStore>(context,listen: false);
    print('MET createOrderService');
    // CREATE ITEM LEVEL OBJECT FOR PLACING THE ORDER
    // Get the current data from the store, traverse the data and add the json'd data to the list
    // Supply the list to order level object.
    List items=[];

    // print(itemsFromCart);

    itemsFromCart.forEach((element) {
      print(element.toJson());
      items.add(element.toJson());
    });

    final uniqueShops = items.groupBy((m) => m["shopID"]);
    List listofShops = uniqueShops.keys.toList();
    List listofShopItems = uniqueShops.values.toList();

    // print(listofShopItems);

    Orders1 ord;
    List statusArray=[];
    // CREATE ORDER LEVEL OBJECT FOR PLACING THE ORDER
    for( var data in listofShopItems)
      {
        print('Debugging : MET createOrder');
        // print(data[0]);
        var orderSplitTotal = data.fold(0, (previousValue, element) => previousValue + int.parse(element["itemCartQty"] )* double.parse(element["productPrice"]));
        var orderObject = {
          "Order_Number": (listofShopItems.indexOf(data)+1).toString(),
          "Order_Value": orderSplitTotal.toString(),
          "Order_Items": data.length.toString(),
          "Order_Pay_Type": selectedPaymentMethod,
          "Order_PayID": payStatus=="success"?payResponse.toString():"0",
          "Order_Pay_Status": payStatus=="success"?"paid":"pending",
          "Order_DlvyID": "",
          "Order_Dlvy_Type": selectedDelMethod.toString(),
          "shop_id": data[0]["shopID"],
          "shop_name" : data[0]["shopName"],
          "shop_address" : data[0]["shopAddress"],
          "Cust_State": globalAddress!=null?globalAddress.state:null,
          "Cust_City": globalAddress!=null?globalAddress.city:null,
          "Cust_PinCode": globalAddress!=null?globalAddress.pinCode:null,
          "Cust_Address": addressString,
          "Cust_Phone": customerDetailsPhone.toString(),
          "Cust_Latitude": globalAddress!=null?globalAddress.lat:null,
          "Cust_Longitude": globalAddress!=null?globalAddress.long:null,
          "Order_Status":"1",
          "cust_id": customerToken,
          "Items":data
        };
        ord = Orders1.fromJson(orderObject);
        print(ord.toJson());
        print('Placing the order now');
        await ord.placeOrder(ord);
        // print(ord.statusMsg)
        statusArray.add(ord.statusType);
      }

    var foundElements = statusArray.where((e) => e == "success");
      print(foundElements.length);

    // Get relevant details from component, store & shared preference and populate the order object
    // validate the order object and call the /order API to place the order to the system.


    if(foundElements.length>0){
      store.clearCart();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.of(context).pushNamed(Routers.CHECKOUT_COMPLETED,arguments: orderTotal.toString() );
    }

  }

}


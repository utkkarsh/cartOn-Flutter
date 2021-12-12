import 'package:CartOn/models/MyStore.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/StyleUtil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class AddQuantityView extends StatefulWidget {
  final Function modifyQuantity;
  final double viewSize;
  final int index;
  final bool isFromCart;
  AddQuantityView({this.modifyQuantity, this.viewSize, this.index, this.isFromCart}) : super();

  @override
  _AddQuantityViewState createState() => _AddQuantityViewState();
}

class _AddQuantityViewState extends State<AddQuantityView> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            color: Pallete.addItemButtonColor1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color:Colors.transparent)),
            elevation: Constant.CARD_ELEVATION,
            child: Container(
              // color: Colors.cyanAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // color: Colors.green,
                    width: widget.viewSize,
                    height: widget.viewSize,
                    child: Center(
                        child: IconButton(
                            color: Pallete.checkoutBarColor2,
                            iconSize: widget.viewSize / 2,
                            icon: Icon(Icons.remove),
                            onPressed: () => store.modifyItemQtyinCart(widget.index, 'SUB')
                          // changeQuantity(0),
                        )),
                  ),
                  Container(
                    color: Pallete.addItemButtonColor0,
                    width: widget.viewSize,
                    height: widget.viewSize,
                    child: Center(
                        child: Text(
                          store.getItemQtyInCart(widget.index).toString(),
                          style: StyleUtil.textAddQuantityStyle,
                        )),
                  ),
                  Container(
                    width: widget.viewSize,
                    height: widget.viewSize,
                    child: Center(
                        child: IconButton(
                            color: Pallete.checkoutBarColor2,
                            icon: Icon(Icons.add),
                            iconSize: widget.viewSize / 2,
                            onPressed: () => store.modifyItemQtyinCart(widget.index, 'ADD')
                        )),
                  ),
                ],
              ),
            ),
          ),
          widget.isFromCart ?         Container(
            child: IconButton(
                icon: Icon(MaterialIcons.delete,color: Colors.grey[700]),
                onPressed: () => store.modifyItemQtyinCart(widget.index, 'REMOVE')
            ),
          ) : Container(),
        ],
      ),
    );
  }
}

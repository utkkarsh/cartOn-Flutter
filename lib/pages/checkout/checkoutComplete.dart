import 'package:CartOn/models/MyStore.dart';
import 'package:provider/provider.dart';

import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';
import 'package:CartOn/util/Router.dart';


class CheckoutComplete extends StatefulWidget {
  @override
  _CheckoutCompleteState createState() => _CheckoutCompleteState();
}

class _CheckoutCompleteState extends State<CheckoutComplete> {
  ConfettiController _controllerCenter;

  @override
  Widget build(BuildContext context) {
    String orderAmount = ModalRoute.of(context).settings.arguments;
    print(orderAmount);
    var store = Provider.of<MyStore>(context);

    return
      Scaffold(
        appBar: NewAppBar(
          text: 'Checkout',
          isCenterTitle: false,
          isHideSearch: true,
          showCartIcon:false,
          showHomeIcon:true,
          context: context,
          showBackButton:true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(Constant.PADDING_VIEW),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                  true, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], // manually specify the colors to be used
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('${Constant.PATH_IMAGE}/svg/clearance.svg',
                              height: 180,
                            ),
                            SizedBox(height: 10,),
                            TextWidget(
                              text: 'Your order is placed successfully.',
                              fontColor: Pallete.textSubTitle,
                              fontSize: Constant.SMALL_TEXT_FONT + 3,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            )
                          ],
                        )
                        ,
                      )
                  ),
                )),
              SizedBox(height: 25,),
              OutlinedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(Routers.ORDERS,arguments: 'checkoutPage' );
                  },
                 // highlightedBorderColor: Colors.green,

            child: Text('View Your Orders')),
              OutlinedButton(
                  onPressed: (){
                    Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
                  },
                  // highlightedBorderColor: Colors.green,
                  child: Text('Shop More'))

            ],
          ),
        ),
      );
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();

    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();

    super.dispose();

  }

}


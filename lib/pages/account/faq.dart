
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:CartOn/models/FAQs.dart';


class FAQs extends StatefulWidget {
  @override
  _FAQsState createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> with WidgetsBindingObserver {
 
  @override
  Widget build(BuildContext context) {

    Future getDatafromAPI() async {

        List<FAQ> faqs = await getFAQs('CATEGORY_LIST');
        // List<Shop> shops = await getShopsFromDB();
        return faqs;
      }


    return Scaffold(
      appBar: NewAppBar(
        text: 'FAQs',
        isCenterTitle: false,
        isHideSearch: true,
        showCartIcon:false,
        showHomeIcon:false,
        context: context,
        showBackButton:true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constant.PADDING_VIEW),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getDatafromAPI() ,
              builder: (BuildContext context, AsyncSnapshot snapshot ){
                if (snapshot.data == null)
                {
                  return Container(
                    child: SpinKitPulse(
                      color: Colors.grey,
                      size: 50.0,
                    ),
                  );
                }
                if (snapshot.data.length>0)
                {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          snapshot.data.length, (index) =>
                          faqWidget(snapshot.data[index].faqQues,snapshot.data[index].faqAns))
                    ],
                  );

                }
                else
                {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget faqWidget (String question, String answer)
  {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '• ${question}',
            maxLines: 2,
            style: TextStyle(
              fontSize: Constant.ORDER_HEADING_PRIMARY1,
              fontFamily: Constant.ROBOTO_MEDIUM,
              color: Pallete.textColor,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 4,),
          Text(
            answer,
            maxLines: 6,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
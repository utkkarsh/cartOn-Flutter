import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/ShopCategory.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/pages/category_wid/CategoryCard.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override

  Future getDatafromAPI() async {
    var store = Provider.of<MyStore>(context);

    if(store.getCategoryListLength()>0)
    {
      return store.categoryList;
    }
    else
    {
      List<ShopCategory> catg = await getCategories('CATEGORY_LIST');
      // List<Shop> shops = await getShopsFromDB();

      if(catg.length>0 )
      {
      //   if(shops.length>0 )
      // {
      //   store.addtoShopList(shops);
      // }
        store.addtoCategoryList(catg);
      }
      return catg;
    }
  }

  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    final ParamType data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: NewAppBar(
        text: data.title,
        isCenterTitle: false,
        context: context,
        showHomeIcon: true,
        showCartIcon: true,
        showBackButton:true,

      ),
      body: SafeArea(
        child: Container(
            color: Pallete.appBgColor,
            child:  FutureBuilder(
              future: getDatafromAPI(),
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
                  return  Container(
                    child: GridView.builder(
                        physics:  AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                        shrinkWrap: true, // Important else view disappears
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,   // number of items in a list
                          crossAxisSpacing: Constant.HALF_PADDING_VIEW / 2,
                          // mainAxisSpacing: Constant.HALF_PADDING_VIEW / 1,
                          // childAspectRatio: MediaQuery.of(context).size.width /
                          //                   (MediaQuery.of(context).size.height /
                          // (Platform.isIOS ? 1.40 : 1.45))
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          return CategoryCard(category: snapshot.data[index],isGridList: true,);
                        }),
                  );
                }
                else
                {
                  return Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('${Constant.PATH_IMAGE}/svg/binoculars.svg',
                              height: 180,
                            ),
                            SizedBox(height: 10,),
                            TextWidget(
                              text: '',
                              fontColor: Pallete.textSubTitle,
                              fontSize: Constant.SMALL_TEXT_FONT + 3,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            )
                          ],
                        )
                        ,
                      )
                  );
                }
              },
            ),
        ),
      ),
    );
  }
}

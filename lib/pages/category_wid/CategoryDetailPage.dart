import 'package:CartOn/models/ShopCategory.dart';
import 'package:CartOn/pages/category_wid/CategoryCard.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/list/FilterSortView.dart';
import 'package:CartOn/pages/shops/list/ShopViewList.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/TextWidget.dart';


class CategoryDetailPage extends StatefulWidget {
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    final ShopCategory data = ModalRoute.of(context).settings.arguments;
    var store = Provider.of<MyStore>(context);
    List extractedData = store.shopList;

    if (data.categoryName!=null)
    {
      extractedData =  store.shopList.where((element) => element.shopCategories.join(' | ').toString().toLowerCase().contains(data.categoryName.toLowerCase())).toList();
      // category.toString().toLowerCase() ==
      // extractedData = store.shopList.where(
      //         (element) {
      //           if(element.shopMulCat == true )
      //             {
      //               // print('Shop Category ' + exists.toString());
      //               // return element.shopCategories.where((category) => category.toString().toLowerCase() == data.categoryName.toLowerCase());
      //               return element.shopCategory.toLowerCase() == data.categoryName.toLowerCase();
      //
      //             }
      //           else
      //             {
      //               return element.shopCategory.toLowerCase() == data.categoryName.toLowerCase();
      //
      //             }
      //         }
      //
      // ).toList();
    }
    //     (element) =>
    // element.shopCategory.toLowerCase() == data.categoryName.toLowerCase()
    const ColorFilter greyscale = ColorFilter.matrix(<double>[
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0,      0,      0,      1, 0,
    ]);

    return Scaffold(
      appBar: NewAppBar(
        text: data.categoryName,
        isCenterTitle: false,
        showCartIcon: true,
        isHideSearch: true,
        showHomeIcon: true,
        showBackButton:true,
        context: context,
      ),
      body: SafeArea(
        child:

        Container(
            color: Pallete.appBgColor,
            child: extractedData.length > 0 ? Column(
              children: [
                // CategoryCard(category: data,isGridList: false,),
                // FilterSortView(),
                SizedBox(height: 10,),
                Expanded(
                    child:
                    ShopViewList(listShop:extractedData,category: data.categoryName,))
              ],
            ) : noShopPage(data,greyscale)
        )  ,
      ),
    );
  }
  Widget noShopPage(data,greyscale)
  {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ColorFiltered(
            colorFilter: greyscale,
            child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/boxShop.svg',
              height: 180,
            ),
          ),
              SizedBox(height: 10,),
              TextWidget(
                text: 'No '+ data.categoryName + ' shops in this area.' ,
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              ),
              TextWidget(
                text: 'We are working hard to list more shops in your area.',
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              )
            ],
          ),
        )
    );
  }
}
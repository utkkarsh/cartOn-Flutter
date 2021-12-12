import 'package:flutter/material.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/Constant.dart';
// import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
// import 'package:CartOn/util/StyleUtil.dart';
import 'package:CartOn/widgets/TextAppBar.dart';
import 'package:flutter_icons/flutter_icons.dart';

// class HomeAppBar extends AppBar {
//   final String text;
//   final bool isCenterTitle;
//   final BuildContext context;
//   final int selectedIndex;
//   var customerAddress;
//
//   getData() async
//   {
//     customerAddress = getCustomerAddress();
//     print(customerAddress);
//   }
//
//   HomeAppBar(
//       {
//         this.text,
//       this.isCenterTitle,
//       @required this.context,
//       this.selectedIndex})
//       : super();
//
//   @override
//   bool get centerTitle => isCenterTitle;
//
//   @override
//   Color get backgroundColor => Pallete.toolbarColor;
//
//   @override
//   Widget get leading =>      IconButton(
//         icon: Image.asset(
//           '${Constant.PATH_IMAGE}/clearance.png',
//           // color: Pallete.toolbarItemColor,
//           width: 300,
//         ),
//         onPressed: () => {},
//       );
//
//
//   @override
//   Widget get title => TextAppBar(text:'CartOn');
//
//
//
//   @override
//   List<Widget> get actions => [
//
//         IconButton(
//           icon: Icon(
//             Feather.search,
//             color: selectedIndex == 0
//                 ? Pallete.toolbarItemColor
//                 : Colors.transparent,
//             size: 26,
//           ),
//           onPressed: () => {
//             if (selectedIndex == 0)
//               Navigator.of(context).pushNamed(Routers.SEARCH)
//           },
//         ),
//
//         IconButton(
//           icon: Icon(
//             Feather.bookmark,
//             color: Pallete.toolbarItemColor,
//             size: 26,
//           ),
//           onPressed: () => {},
//         ),
//       ];
// }
//



class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String text;
  final bool isCenterTitle;
  final BuildContext context;
  final int selectedIndex;

  HomeAppBar(
      {
        this.text,
        this.isCenterTitle,
        this.selectedIndex,
        @required this.context,
      }): preferredSize = Size.fromHeight(56.0),
        super();

  @override
  Widget build(context) {

    return AppBar(
      title: TextAppBar(text: text),
      backgroundColor: Pallete.appBgColor,
      centerTitle: isCenterTitle,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          '${Constant.PATH_IMAGE}/clearance.png',
          // color: Pallete.toolbarItemColor,
          width: 300,
        ),
        onPressed: () => {},
      )
      ,

      actions: [

        IconButton(
          icon: Icon(
            Feather.search,
            color: selectedIndex == 0
                ? Pallete.toolbarItemColor
                : Colors.transparent,
            size: 26,
          ),
          onPressed: () => {
            if (selectedIndex == 0)
              Navigator.of(context).pushNamed(Routers.SEARCH)
          },
        ),

        // IconButton(
        //   icon: Icon(
        //     Feather.bookmark,
        //     color: Pallete.toolbarItemColor,
        //     size: 26,
        //   ),
        //   onPressed: () => {},
        // ),
      ],
    );
  }

}


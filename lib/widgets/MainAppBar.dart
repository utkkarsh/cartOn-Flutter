import 'package:flutter/material.dart';
import 'package:CartOn/models/Cart.dart';
// import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
// import 'package:CartOn/util/StyleUtil.dart';
import 'package:CartOn/widgets/TextAppBar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MainAppBar extends AppBar{
  final String text;
  final bool isCenterTitle;
  final bool isHideSearch;
  final BuildContext context;

  MainAppBar(
      {
        this.text,
      this.isCenterTitle,
      this.isHideSearch,
      @required this.context})
      : super();

  @override
  bool get centerTitle => isCenterTitle;



  @override
  Color get backgroundColor => Pallete.countViewColor;

  @override
  Widget get leading => IconButton(
        icon: Icon(
          Feather.chevron_left,
          color: Pallete.toolbarItemColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        iconSize: 36,
      );

  @override
  Widget get title => TextAppBar(text: text);

  @override
  List<Widget> get actions => [
        IconButton(
          icon: Icon(
            Feather.search,
            color: isHideSearch != null && isHideSearch
                ? Colors.transparent
                : Pallete.toolbarItemColor,
          ),
          // highlightColor: isHideSearch != null && isHideSearch
          //     ? Colors.transparent
          //     : Pallete.toolbarItemColor,
          // splashColor: isHideSearch != null && isHideSearch
          //     ? Colors.transparent
          //     : Pallete.toolbarItemColor,
          onPressed: () {
            // isHideSearch ? null :{if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH)};
            if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH);
          },
          iconSize: 26,
        ),
        IconButton(
          icon: Icon(
            Feather.home,
            color: Pallete.toolbarItemColor,
          ),
          onPressed: () {
            if (context != null)
              Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
          },
          iconSize: 26,
        ),
          IconButton(
            icon: Icon(
              Feather.shopping_bag,
              color: Pallete.toolbarItemColor,
            ),
            onPressed: () {
              if (context != null)
                Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
            },
            iconSize: 26,
          ),
    // Stack(
    //   children: <Widget>[
    //     IconButton(
    //         icon: Icon(Icons.notifications),
    //             onPressed: null,
    //     ),
    //       Positioned(
    //       right: 11,
    //       top: 11,
    //       child: new Container(
    //         padding: EdgeInsets.all(2),
    //         decoration: new BoxDecoration(
    //           color: Colors.red,
    //           borderRadius: BorderRadius.circular(6),
    //         ),
    //         constraints: BoxConstraints(
    //           minWidth: 14,
    //           minHeight: 14,
    //         ),
    //         child: Text(
    //           '1',
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 8,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     )
    //   ],
    // ),
      ];

}

//
// class MainAppBar extends StatelessWidget with PreferredSizeWidget {
//   @override
//   final Size preferredSize;
//   final String text;
//   final bool isCenterTitle;
//   final bool isHideSearch;
//   final bool showCartIcon;
//
//   final BuildContext context;
//
//   MainAppBar(
//       {
//         this.text,
//         this.isCenterTitle,
//         this.isHideSearch,
//         this.showCartIcon,
//         @required this.context,
//       }): preferredSize = Size.fromHeight(56.0),
//         super();
//
//   @override
//   Widget build(context) {
//     // var store = Provider.of<MyStore>(context);
//     return AppBar(
//       title: TextAppBar(text: text),
//       elevation: 0,
//       backgroundColor: Pallete.toolbarColor,
//       centerTitle: isCenterTitle,
//       leading: IconButton(
//         icon: Icon(
//           Feather.chevron_left,
//           color: Pallete.toolbarItemColor,
//         ),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         iconSize: 36,
//       )
//       ,
//
//       actions: [
//       IconButton(
//           icon: Icon(
//             Feather.search,
//             color: isHideSearch != null && isHideSearch
//                 ? Colors.transparent
//                 : Pallete.toolbarItemColor,
//           ),
//           onPressed: () {
//             // isHideSearch ? null :{if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH)};
//             if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH);
//           },
//           iconSize: 26,
//         ),
//         IconButton(
//           icon: Icon(
//             Feather.home,
//             color: Pallete.toolbarItemColor,
//           ),
//           onPressed: () {
//             if (context != null)
//               Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
//           },
//           iconSize: 26,
//         ),
//           IconButton(
//             icon: Icon(
//               Feather.shopping_bag,
//               color: Pallete.toolbarItemColor,
//             ),
//             onPressed: () {
//               if (context != null)
//                 Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
//             },
//             iconSize: 26,
//           )
//       ],
//     );
//   }
//
// }
//
//

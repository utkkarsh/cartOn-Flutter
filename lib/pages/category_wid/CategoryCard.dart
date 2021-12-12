import 'package:CartOn/models/ShopCategory.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';

class CategoryCard extends StatefulWidget {
  final ShopCategory category;
  final bool isGridList;
  CategoryCard({this.category,this.isGridList});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routers.CATEGORY_DETAIL,
                arguments: widget.category),
            child: Container(
              width: widget.isGridList ? 100:170,
              // color: Colors.red,
              margin: widget.isGridList ? EdgeInsets.fromLTRB(16, 5, 0, 0):EdgeInsets.fromLTRB(16, 10, 0, 0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Column(
                    children: [
                      Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          color:Colors.white,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                child: Text (
                                    widget.category.categoryName,
                                    style: TextStyle(
                                      color: Pallete.itemDescColor,
                                      fontSize: Constant.TEXT_FONT,
                                      fontFamily: Constant.ROBOTO_MEDIUM,
                                    )
                                ),
                              ),
                              SizedBox(height: 110,width: 115,),
                            ],
                          )
                      )
                    ],
                  ),
                  Align(
                    child: Image.network(
                      widget.category.categoryImage,
                          height: 150,
                          width: 150,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null ?
                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                  // Align(
                  //   child: Image (
                  //     height: 150,
                  //     width: 150,
                  //     image: NetworkImage(widget.category.categoryImage),
                  //   ),
                  // )
                ],
              ),
            ),
          );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:wp05/models/Article.dart';
import 'package:html/dom.dart' as dom;

Widget articleBox(BuildContext context, Article article, String heroId) {
  var imagurl = article.image;
  var deviceSize = MediaQuery.of(context).size;
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 20.0,
          shadowColor: Colors.white54,
          shape: BoxShape.circle,
          child: Card(
            margin: EdgeInsets.only(bottom: 20),
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(45.0),
              //   topRight: Radius.circular(64.0)
              // ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 7.0, left: 5.0, right: 5.0),
                    child: Text(
                      article.title,
                      style: TextStyle(
                          fontFamily: 'Al-Qabas',
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 170,
                    width: deviceSize.width - 10,
                    child: CachedNetworkImage(
                      imageUrl: imagurl,
                      width: deviceSize.width,
                      placeholder: (context, url) => LinearProgressIndicator(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,top:12.0,bottom: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "التاريخ: " + article.date,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "الكاتب: " + article.author,
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                        // Text("التصنيف: " + article.category, style: TextStyle(color: Colors.grey[700]),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

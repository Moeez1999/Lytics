import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WebViewContainer extends StatelessWidget {
  final List? imageurl;
  final String? thumbnailPath;
  final String? programDes;
  final String? programDate;
  final String? source;
  final String? anchorName;

  const WebViewContainer(
      {Key? key,
      this.imageurl,
      this.thumbnailPath,
      this.programDes,
      this.programDate,
      this.source,
      this.anchorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 210,
          width: Get.width,
          child: imageurl!.length == 0
              ? CachedNetworkImage(
                  imageUrl: thumbnailPath!,
                  placeholder: (c, e) => Lottie.asset(
                      "assets/images/imgload.json",
                      fit: BoxFit.contain),
                  errorWidget: (c, e, r) => Lottie.asset(
                      "assets/images/imgload.json",
                      fit: BoxFit.contain),
                  fit: BoxFit.cover,
                )
              : CarouselSlider.builder(
                  itemCount: imageurl!.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      child: CachedNetworkImage(
                        imageUrl: imageurl![index],
                        placeholder: (c, e) => Lottie.asset(
                            "assets/images/imgload.json",
                            fit: BoxFit.fill),
                        errorWidget: (c, e, r) => Lottie.asset(
                            "assets/images/imgload.json",
                            fit: BoxFit.fill),
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
        ).marginOnly(left: 15.0, right: 15.0),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
              thickness: 2.0,
              height: 1.0,
              color: source!.toLowerCase() == 'website' ||
                      source!.toLowerCase() == 'blog'
                  ? Color(0xffFFD76F)
                  : source!.toLowerCase() == 'print'
                      ? Color(0xffB48AE8)
                      : Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width / 1.3,
                  child: Text(
                    "$programDes",
                    textScaleFactor: 1.0,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ).marginOnly(top: 10.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0),
                ),
                color: source!.toLowerCase() == 'website' ||
                        source!.toLowerCase() == 'blog'
                    ? Color(0xffFFD76F)
                    : source!.toLowerCase() == 'print'
                        ? Color(0xffB48AE8)
                        : Colors.white,
              ),
              child: Text(
                source!.toLowerCase() == 'website' ||
                        source!.toLowerCase() == 'blog'
                    ? 'WEB  '
                    : '${source!.toUpperCase()}  ',
                style: TextStyle(
                  color: source!.toLowerCase() == 'website' ||
                          source!.toLowerCase() == 'blog'
                      ? Colors.black
                      : Colors.white,
                  fontSize: 10.0,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ).paddingOnly(left: 10.0, right: 2.0, top: 5.0, bottom: 5.0),
            )
          ],
        ).marginOnly(left: 15.0, right: 15.0),
        SizedBox(
          height: 10.0,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "By $anchorName",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Color(0xffd3d3d3),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(
                width: 13.0,
              ),
              Icon(
                Icons.access_time,
                size: 10.0,
                color: Colors.white,
              ).marginOnly(bottom: 0),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "$programDate",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Color(0xffd3d3d3),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(
                width: 2.0,
              ),
            ]).marginOnly(left: 15.0, right: 15.0),
      ],
    );
  }
}

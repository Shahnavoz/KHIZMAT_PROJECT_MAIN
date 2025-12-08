import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:shimmer/shimmer.dart';

class ApplicationsShimmer extends StatelessWidget {
  const ApplicationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey[200]!,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            // height: 200,
            // width: 300,
            decoration: BoxDecoration(
              // border: Border.all(),
              // color: Colors.green,
              // borderRadius: BorderRadius.circular(55),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.otstup15,
                vertical: size.otstup25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: size.otstup18),
                      Container(
                        width: 80,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.otstup18),
                  Container(
                    width: size.screenWidth * 0.85,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(height: size.otstup18),
                  Container(
                    width: size.screenWidth * 0.7,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  SizedBox(height: size.otstup18),
                  Row(
                    children: [
                      Container(
                        width: size.screenWidth * 0.2,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(width: size.otstup15),
                      Container(
                        width: size.screenWidth * 0.2,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(width: size.otstup15),
                      Container(
                        width: size.screenWidth * 0.2,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

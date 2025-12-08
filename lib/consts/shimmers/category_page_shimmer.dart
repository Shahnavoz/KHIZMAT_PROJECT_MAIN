import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPageShimmer extends StatelessWidget {
  const CategoryPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[300]!,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.otstup20,
            vertical: size.otstup50,
          ),
          child: SizedBox(
            child: Column(
              children: List.generate(5, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: size.otstup5),
                  child: SizedBox(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      title: Container(
                        // width: 70,
                        // height: 15,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 270,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(height: size.otstup5),
                            Container(
                              width: 180,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

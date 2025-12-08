import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatefulWidget {
  const HomePageShimmer({super.key});

  @override
  State<HomePageShimmer> createState() => _HomePageShimmerState();
}

class _HomePageShimmerState extends State<HomePageShimmer> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);

    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Color(0xFF90C0BD),
        // highlightColor: Colors.grey[300]!,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFFFFFFF),
                            const Color.fromARGB(0, 249, 247, 247),
                          ],
                          stops: [0.0, 0.7, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[500],
                            child: Image.asset("assets/images/Union (1).png"),
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Shahnavoz,салом",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.otstup18),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(15, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: size.otstup15),
                          child: Container(
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 100,
                            height: 35,
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: size.otstup20),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(height: size.otstup18),

                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: size.otstup18),

                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [CircleAvatar(), Text("dfghjkl;")],
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: size.otstup20),
                      itemCount: 6,
                    ),
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

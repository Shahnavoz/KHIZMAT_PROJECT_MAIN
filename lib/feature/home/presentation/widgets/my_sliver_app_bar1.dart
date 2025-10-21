import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';
import 'package:khizmat_new/feature/home/presentation/pages/scan_qr_page.dart';

class MySliverAppBar1 extends StatefulWidget {
  const MySliverAppBar1({super.key, required this.size});
  final AdaptiveSizes size;
  @override
  State<MySliverAppBar1> createState() => _MySliverAppBar1State();
}

class _MySliverAppBar1State extends State<MySliverAppBar1> {
  String qrResult = "Scanned data will appear here";

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      forceElevated: false,
      backgroundColor: Color(0xFF308470),
      // backgroundColor: Color.fromARGB(255, 214, 246, 232),
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      // backgroundColor: Colors.black,
      pinned: true,
      expandedHeight: 90,
      toolbarHeight: 90,
      // collapsedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Container(
            decoration: BoxDecoration(
              // gradient: newGradientColor,
              gradient: RadialGradient(
                radius: 20.0,
                center: Alignment.topLeft,
                colors: [
                  Color(0xFF015057),
                  Color(0xFF26AC71),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.0, 0.12, 1.9],
              ),
              // color: Colors.transparent,

              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(10),
              //   bottomRight: Radius.circular(10),
              // ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 60,
                left: widget.size.otstup20,
                right: widget.size.otstup20,
                bottom: widget.size.otstup10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(width: 15),
                          textWithH1Style(
                            "Shahnavoz,салом",
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.white,
                            ),
                          ),

                          IconButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanQrPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.qr_code, color: Colors.white),
                          ),
                        ],
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

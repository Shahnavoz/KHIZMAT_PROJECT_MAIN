import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  List<Widget> icons = [
    Icon(Icons.home),
    Icon(Icons.payment),
    Icon(Icons.grid_view),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    // final size = AdaptiveSizes(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Center(child: Text("data")),

      // Stack(
      //   children: [
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       child: Container(
      //         width: size.screenWidth,
      //         height: 80,
      //         // color: Colors.grey,
      //         child: Stack(
      //           children: [
      //             CustomPaint(
      //               size: Size(size.screenWidth, size.screenHeight),
      //               painter: BNBCustomPainter(),
      //             ),

      //             Center(
      //               heightFactor: 0.6,
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   shape: BoxShape.circle,
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(18.0),
      //                   child: Icon(Icons.qr_code, color: Colors.amber),
      //                 ),
      //               ),

      //               //  FloatingActionButton(
      //               //   shape: ShapeBorder.lerp(a, b, t),
      //               //   onPressed: () {},
      //               //   backgroundColor: Colors.amber,
      //               //   child: Icon(Icons.qr_code),
      //               //   elevation: 0.1,
      //               // ),
      //             ),

      //             Container(
      //               width: size.screenWidth,
      //               height: 80,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children:List.generate(icons.length, (index)=>IconButton(onPressed: (){}, icon: icons[index])),
      //                 //  [
      //                 //   IconButton(onPressed: (){}, icon: Icon(Icons.home)),
      //                 //   IconButton(onPressed: (){}, icon: Icon(Icons. payment)),
      //                 //   SizedBox(width: size.screenWidth*0.020,),
      //                 //   IconButton(onPressed: (){}, icon: Icon(Icons.grid_view)),
      //                 //   IconButton(onPressed: (){}, icon: Icon(Icons.person)),
      //                 //   // IconButton(onPressed: (){}, icon: Icon(Icons.home)),
      //                 // ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        // letIndexChange: (value) {
        //   if(currentIndex==2){
        //     return false;
        //   }else{
        //     return true;
        //   }
        // },
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        index: currentIndex,
        // color:currentIndex==2? activeIconColor : Colors.white,
        buttonBackgroundColor:
            currentIndex == 2 ? activeIconColor : nonActiveIconColor,
        backgroundColor: Colors.transparent,
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_filled,
                color: currentIndex == 0 ? activeIconColor : nonActiveIconColor,
              ),
              currentIndex != 0
                  ? Text("Главная", style: TextStyle(color: nonActiveIconColor))
                  : SizedBox.shrink(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payments_rounded,
                color: currentIndex == 1 ? activeIconColor : nonActiveIconColor,
              ),
              Text("Платежи", style: TextStyle(color: nonActiveIconColor)),
            ],
          ),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(
              Icons.qr_code,
              size: 50,
              color: currentIndex == 2 ? Colors.white : activeIconColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view_rounded,
                color: currentIndex == 3 ? activeIconColor : nonActiveIconColor,
              ),
              Text("Услуги", style: TextStyle(color: nonActiveIconColor)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_2,
                color: currentIndex == 4 ? activeIconColor : nonActiveIconColor,
              ),
              Text("Документы", style: TextStyle(color: nonActiveIconColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: Radius.circular(10),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

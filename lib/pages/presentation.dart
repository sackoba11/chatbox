// import 'package:flutter/material.dart';

// class Presentation extends StatefulWidget {
//   const Presentation({super.key});

//   @override
//   State<Presentation> createState() => _PresentationState();
// }

// class _PresentationState extends State<Presentation> {
//   final _pageController2 = PageController();
//   final _currentPageNotifier2 = ValueNotifier<int>(0);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//     );
//   }

//   // _buildCircleIndicator() {
//   //   return CirclePageIndicator(
//   //     size: 10.0,
//   //     dotColor: Colors.black,
//   //     selectedSize: 13.0,
//   //     itemCount: pages.length,
//   //     currentPageNotifier: _currentPageNotifier2,
//   //   );
//   // }

//   _buildBody() => ListView(
//         padding: const EdgeInsets.all(8.0),
//         children: <Widget>[
//           SizedBox(
//             height: 500,
//             child: PageView.builder(
//                 itemCount: pages.length,
//                 controller: _pageController2,
//                 itemBuilder: (BuildContext context, int index) =>
//                     Pagewidget(entry: pages[index]),
//                 onPageChanged: (int index) {
//                   if (index <= 4) {
//                     _currentPageNotifier2.value = index;
//                   }
//                 }),
//           ),
//           ArrowPageIndicator(
//             iconPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//             isInside: false,
//             iconSize: 60,
//             leftIcon: const Icon(Icons.arrow_circle_left_outlined),
//             rightIcon: const Icon(Icons.arrow_circle_right_outlined),
//             pageController: _pageController2,
//             currentPageNotifier: _currentPageNotifier2,
//             itemCount: pages.length,
//             child: Center(
//                 child: SmoothPageIndicator(
//               controller: _pageController2,
//               count: pages.length,
//               axisDirection: Axis.horizontal,
//               effect: const SlideEffect(
//                   spacing: 10.0,
//                   //radius: 4.0,
//                   dotWidth: 10.0,
//                   dotHeight: 2.5,
//                   paintStyle: PaintingStyle.stroke,
//                   strokeWidth: 1.5,
//                   dotColor: Colors.grey,
//                   activeDotColor: Colors.black),
//             ) //_buildCircleIndicator(),
//                 ),
//           )
//         ]
//             .map((item) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: item,
//                 ))
//             .toList(),
//       );
// }

// class Pageinfo {
//   final String image;
//   final String description;
//   const Pageinfo(this.image, this.description);
// }

// final List<Pageinfo> pages = [
//   const Pageinfo("images/shopping.jpg",
//       "Cette application est une application de shopping depuis votre Téléphone ou votre ordinateur"),
//   const Pageinfo("images/phone.webp",
//       "Depuis votre Smartphone, vous avez la possibilité de faire vos achats partout et à tout moment"),
//   const Pageinfo("images/e-commerce.jpg",
//       "Commandez vos articles hors-ligne depuis votre ordinateur"),
//   const Pageinfo(
//       "images/clic.jpg", "En un clic, votre article est commandé sans effort"),
//   const Pageinfo("images/paiement.webp",
//       "Le paiement est sûr et sécurisé avec système de paiement multi-plateforme"),

//   // Navigator.of(context).push( MaterialPageRoute(
//   //     builder: (BuildContext context) => const MyHomePage()););
// ];

// class Pagewidget extends StatefulWidget {
//   final Pageinfo entry;
//   const Pagewidget({super.key, required this.entry});

//   @override
//   State<Pagewidget> createState() => _PagewidgetState();
// }

// class _PagewidgetState extends State<Pagewidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: ListView(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 300,
//             width: 300,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage(
//                     widget.entry.image,
//                   ),
//                 )),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           Center(
//             child: Text(
//               widget.entry.description,
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 17,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.bold),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

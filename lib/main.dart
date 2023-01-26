import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_web_1/views/screens/geek.dart';
import 'package:multi_web_1/views/screens/link.dart';
import 'package:multi_web_1/views/screens/school.dart';
import 'package:multi_web_1/views/screens/tutorial.dart';
import 'package:multi_web_1/views/screens/wiki.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'tutorial': (context) => const Tutorial(),
        'school': (context) => const School(),
        'geek': (context) => const Geeks(),
        'wiki': (context) => const Wikipedia(),
        'link': (context) => const Link(),
      },
    ),
  );
}

class Global {
  static List bookmarkList = [];
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    'https://savemydeals.com/wp-content/uploads/2020/08/screen-10-300x300.jpg',
    'https://tse2.mm.bing.net/th?id=OIP.YLzV1t5lbEEFMoEXxLtvngAAAA&pid=Api&P=0',
    'https://tse2.mm.bing.net/th?id=OIP.72WzVBF3t0iGwx68T5MsUwAAAA&pid=Api&P=0',
    'https://cdn.freebiesupply.com/images/large/2x/wikipedia-logo-transparent.png',
  ];

  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Learning websites",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 55,
              child: TextField(
                onSubmitted: (val){
                  setState((){
                    if(val=="tutorialspoint" || val=="Tutorialspoint"){Navigator.pushNamed(context, 'tutorial');}
                    else if(val=="w3school" || val=="W3school"){Navigator.pushNamed(context, 'school');}
                    else if(val=="geeksforgeeks" || val == "Geeksforgeeks"){Navigator.pushNamed(context, 'geek');}
                    else if(val=="wikipedia" || val == "Wikipedia"){Navigator.pushNamed(context, 'wiki');}
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey.shade400,height: 1),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade400),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: Colors.white,
            height: 300,
            child: CarouselSlider(
              carouselController: carouselController,
              items: images
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (images.indexOf(e) == 0) {
                            Navigator.pushNamed(context, 'tutorial');
                          } else if (images.indexOf(e) == 1) {
                            Navigator.pushNamed(context, 'school');
                          } else if (images.indexOf(e) == 2) {
                            Navigator.pushNamed(context, 'geek');
                          } else if (images.indexOf(e) == 3) {
                            Navigator.pushNamed(context, 'wiki');
                          }
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(e, fit: BoxFit.fill),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                initialPage: currentPage,
                onPageChanged: (val, _) {
                  setState(() {
                    currentPage = val;
                  });
                },
                enlargeCenterPage: true,
                height: 260,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 100,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: images.map(
                (e) {
                  int i = images.indexOf(e);
                  return GestureDetector(
                    onTap: () {
                      carouselController.animateToPage(
                        i,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: (currentPage == i)
                          ? Colors.blue.shade600
                          : Colors.grey.shade400,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

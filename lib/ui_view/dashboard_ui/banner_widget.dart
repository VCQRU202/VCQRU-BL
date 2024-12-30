import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../providers_of_app/banner_provider/banner_provider.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;

  List<String> imgList = [
    'assets/banner_demo.png',
    'assets/banner_demo.png',
    'assets/banner_demo.png'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<BannerProvider>(context, listen: false).getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Consumer<BannerProvider>(builder: (context, valustate, child) {
        if (valustate.isLoading) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please Wait"),
                  CircularProgressIndicator(),
                ],
              ));
        } else {
          if (valustate.hasError && valustate.bannerModel == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' ${valustate.errorMessage}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      valustate.getBanner();
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: valustate.bannerModel!.data?.length,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 150,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    reverse: false,
                    aspectRatio: 5.0,
                  ),
                  itemBuilder: (context, i, id) {
                    //for onTap to redirect to another screen
                    return GestureDetector(
                      child: Container(
                        // decoration: BoxDecoration(
                        //     borderRadius:
                        //     BorderRadius.circular(15),
                        //     border: Border.all(
                        //       color: Colors.white,
                        //     )
                        // ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            valustate.bannerModel!.data![i].imagePath.toString(),
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent?
                                loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      onTap: () {

                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                      },
                    );
                  },
                ),
            //     Positioned(
            //         top: 130,
            //         left: 0,
            //         right: 0,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: List.generate(imgList.length, (index) {
            //             return AnimatedOpacity(
            //               duration: Duration(milliseconds: 300),
            //               opacity: _currentIndex == index ? 1.0 : 0.5,
            //               child: AnimatedContainer(
            //                 duration: Duration(milliseconds: 300),
            //                 margin: EdgeInsets.all(4),
            //                 width: 8.0,
            //                 height: 8.0,
            //                 decoration: BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   border: Border.all(width: 1,color: Colors.white),
            //                   color: _currentIndex == index
            //                       ? Colors.red
            //                       : Colors.grey,
            //                 ),
            //               ),
            //             );
            //           }),
            //         )
            //       /*Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(imgList.length, (index) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //       child: AnimatedContainer(
            //         duration: Duration(milliseconds: 300),
            //         width: 10,
            //         height: 10,
            //         decoration: BoxDecoration(
            //           shape: _currentIndex==index? BoxShape.circle:BoxShape.circle,
            //           color: Colors.white,
            //         ),
            //       ),
            //     );
            //   }),
            // ),*/
            //     ),
              ],
            );
          }
        }
      }),
    );
  }
}


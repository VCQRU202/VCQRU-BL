import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../models/product_cat_model/product_cat_details_model.dart';
import '../../providers_of_app/product_catlog_provider/product_catlog_list_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Colors.dart';


class ProductCatDetails extends StatefulWidget {
  final String productId;
  final String productName;

  ProductCatDetails({
    required this.productId,
    required this.productName,
  });

  @override
  State<ProductCatDetails> createState() => _ImagesSurieState();
}

class _ImagesSurieState extends State<ProductCatDetails> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductCatListProvider>(context, listen: false).getproductDetailList(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName,style: TextStyle(fontSize: 18,color: Colors.white),),
        centerTitle: true,
        backgroundColor: splashProvider.color_bg,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:Container(
        width: double.infinity,
        height:double.infinity ,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F4FC),
              Color(0xFFE1D7FF),
              Color(0xFFFDE0E7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding:EdgeInsets.all(10) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Consumer<ProductCatListProvider>(
                    builder: (context, valustate, child) {
                      if (valustate.isLoading_detail) {
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Please Wait"),
                                CircularProgressIndicator(),
                              ],
                            ));
                      } else {
                        if (valustate.hasError_detail) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
          
                                Container(
                                  child: Image.asset(
                                    'assets/notificatins.png',
                                  ),
                                ),
                                Text(' ${valustate.errorMessage_detail}'),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    valustate.retrygetDetailList(widget.productId);
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final productList = valustate.productDetailData?.data ?? [];
                          return productList.isNotEmpty
                              ?GridView.builder(
                            padding: EdgeInsets.all(8),
                            shrinkWrap: true, // Makes ListView take only the required height
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                            ),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final pointData = productList[index];
                              return Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  children: [
                                    // Background Image
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: pointData.imagePath != null && pointData.imagePath!.isNotEmpty
                                            ? DecorationImage(
                                          image: NetworkImage(
                                            pointData.imagePath!.replaceAll('~', ''),
                                          ),
                                          fit: BoxFit.cover, // Cover the full card area
                                        )
                                            : null, // No background image if path is empty
                                      ),
                                    ),
          
                                    // Foreground Overlay (Optional, e.g., for gradients or labels)
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(
                                          colors: [Colors.black54, Colors.transparent], // Fade effect
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
          
                                    // Content
                                    Positioned(
                                      bottom: 8,
                                      left: 8,
                                      right: 8,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pointData.productName ?? "No Name",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            pointData.productDescription ?? "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
          
                                    // Label
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          pointData.price ?? "0", // Example label
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                              : Center(child: Text("No data available."));
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
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
                              crossAxisSpacing:10,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.68,
                            ),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final pointData = productList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Image Section
                                  GestureDetector(
                                    onTap: (){
                                      if (index >= 0 && index < productList.length) {
                                        _presentBottomSheet(context, valustate, index);
                                      } else {
                                        print('Index out of bounds: $index');
                                      }
                                    },
                                    child: Card(
                                      color: Color(0xFFF5F5F5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                                      ),
                                    elevation: 0,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140, // Adjust image height as needed
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                            image: pointData.imagePath != null && pointData.imagePath!.isNotEmpty
                                                ? DecorationImage(
                                              image: NetworkImage(
                                                pointData.imagePath!.replaceAll('~', ''),
                                              ),
                                              fit: BoxFit.contain, // Cover the full card area
                                            )
                                                : null, // No background image if path is empty
                                          ),
                                        ),
                                        // Quantity Badge
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color:Color(0xFF5207F7).withOpacity(0.16),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8)
                                              ),
                                            ),
                                            child: Text(
                                              "${pointData.price} Qty",
                                              style: GoogleFonts.roboto(
                                                color: Color(0xFF5207F7),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ),
                                  ),
                                  Text(
                                    pointData.productName ?? "No Name",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Points Label
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.16),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Text(
                                        "${pointData.productId} Points",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
void _presentBottomSheet(BuildContext context, ProductCatListProvider provider, index) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 6, // 10%
                  child: Container(
                    width: double.infinity,
                    margin:
                     EdgeInsets.only(left: 20, top: 0, right: 10),
                    child:  Text(
                      provider.productDetailData?.data?[index].productName.toString()??"",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontSize: 18),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Text(
                        "Product Points",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Text(
                    ":",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        provider.productDetailData?.data?[index].point.toString()??"",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Text(
                    ":",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "₹ "+(provider.productDetailData?.data?[index].price.toString()??"0")+" /-",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Text(
                        "Stock",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Text(
                    ":",
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        (provider.productDetailData?.data?[index].stockQuantity.toString()??"0")+" Qty",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}
}

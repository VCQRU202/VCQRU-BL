import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vcqru_bl/ui_view/product_catlogs/product_details_list.dart';


import '../../providers_of_app/product_catlog_provider/product_catlog_list_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';

class ProductCatListPage extends StatefulWidget {
  const ProductCatListPage({super.key});

  @override
  State<ProductCatListPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<ProductCatListPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductCatListProvider>(context, listen: false).getproductList();
  }
  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product catalog ',style: TextStyle(fontSize: 18,color: Colors.white),),
        backgroundColor: splashProvider.color_bg,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
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
                      if (valustate.hasError) {
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
                              Text(' ${valustate.errorMessage}'),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  valustate.retrygetNotificationList();
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final productList = valustate.productListData?.data ?? [];
                        return productList.isNotEmpty
                            ? ListView.builder(
                          itemCount: productList.length,
                          shrinkWrap: true, // Makes ListView take only the required height
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final notification = productList[index];
                            return GestureDetector(
                              onTap: () {
                                print("-----click------");

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CatagryTile(
                                    title:notification.productName ?? "No message",
                                    id: notification.productId??"",
                                  ),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1.0,
                                    indent: 10.0,
                                    endIndent: 10.0,
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
    );
  }
}

class CatagryTile extends StatelessWidget {
   var title;
   var id;

  CatagryTile({required this.title,required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16), // Arrow icon
      onTap: () {
        // Handle click event here
        Navigator.push(context, MaterialPageRoute(builder:
            (context)=>ProductCatDetails(
          productId: id,
          productName: title,
        )));
      },
    );
  }
}
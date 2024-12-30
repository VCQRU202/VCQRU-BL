import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import '../../providers_of_app/blogs_provider/blogs_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/social_media.dart';
class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Add back functionality here
        //   },
        // ),
      ),
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, child) {
          if (blogProvider.blogs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: blogProvider.blogs.length,
              itemBuilder: (context, index) {
                final blog = blogProvider.blogs[index];
                return BlogContainer(
                  header: blog.header,
                  description: blog.description,
                  date: blog.uploadedDate,
                  imagePath: blog.imagePath,
                  fileType: blog.fileType,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class BlogContainer extends StatefulWidget {
  final String header;
  final String description;
  final String date;
  final String imagePath;
  final String fileType;

  BlogContainer({
    required this.header,
    required this.description,
    required this.date,
    required this.imagePath,
    required this.fileType,
  });

  @override
  _BlogContainerState createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  bool isLiked = false;
  int likeCount = 0;
  bool showFullDescription = false;
  bool isVideoPlaying = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.fileType == 'Video') {
      _controller = VideoPlayerController.network(widget.imagePath)
        ..initialize().then((_) {
          setState(() {});
        }).catchError((error) {
          print("Video initialization error: $error");
        });
    }
  }

  @override
  void dispose() {
    if (widget.fileType == 'Video') {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40.0, // Height of the circular container
                width: 40.0,  // Width of the circular container
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Ensures the container is circular
                  image: DecorationImage(
                    image: NetworkImage(splashProvider.logoUrlF), // Replace with your image URL
                    fit: BoxFit.cover, // Adjust fit to cover the entire circle
                  ),
                  color: Colors.grey.shade200, // Optional background color while the image loads
                ),
                child: splashProvider.logoUrlF.isNotEmpty
                    ? null
                    : Center(
                  child: CircularProgressIndicator(), // Loader while the image is being fetched
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.header,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            widget.description,
            maxLines: showFullDescription ? null : 2,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showFullDescription = !showFullDescription;
              });
            },
            child: Text(
              showFullDescription ? 'Show less' : 'more',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 10),
          widget.fileType == 'Video' ? buildVideoPlayer() : buildImage(),
          SizedBox(height: 10),
          // Below Video - Like count, Shares, Views
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                likeCount==0?"":'👍 ${likeCount}K',
                style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              ),
              // Text('1.3K Shares'),
              // Text('6.3M Views'),
            ],
          ),
          SizedBox(height: 10),
          // Like, Send, Share buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: isLiked ? Colors.purple : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                    likeCount += isLiked ? 1 : -1;
                  });
                },
              ),
              TextButton.icon(
                icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                label: Text('Send'),
                onPressed: () async {
                  isInstalled();
                  bool install=await isInstalled()??false;
                  bool installbuss=await isInstalledBuss()??false;
                  print('Whatsapp  is installed: $install');
                  print('Whatsapp Business is installed: $installbuss');
                  if(install){
                    shareReferral(widget.description,widget.imagePath);
                  }else if(installbuss){
                    shareReferralbuss(widget.description,widget.imagePath);
                  } else{
                    toastRedC("Whatsapp not installed ");
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share('${widget.description} ${widget.imagePath}');
                  // // Share functionality here
                  // SocialShare.shareSms(widget.description,url: widget.imagePath
                  // ).then((data) {
                  //   print(data);
                  // });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> shareReferral(code,url1) async {
    // await WhatsappShare.share(
    //   text: 'Hey!! Sign-up on the orio app using my referral code and get 100 '
    //       'points.So sign-up now before the offer expires! \n Download the app :',
    //   linkUrl: 'https://play.google.com/store/apps/details?id=com.app.orioapp',
    // );
    SocialShare.shareWhatsapp(
      "${code+url1}",
    ).then((data) {
      print(data);
    });
  }
  Future<void> shareReferral1(code,url1) async {
    // await WhatsappShare.share(
    //   text: 'Hey!! Sign-up on the orio app using my referral code and get 100 '
    //       'points.So sign-up now before the offer expires! \n Download the app :',
    //   linkUrl: 'https://play.google.com/store/apps/details?id=com.app.orioapp',
    // );
    SocialShare.shareWhatsapp(
      "${code+url1}",
    ).then((data) {
      print(data);
    });
  }

  Future<void> shareReferralbuss(String code,String url1) async {
    String message = Uri.encodeComponent(
        "${code+url1}");

    bool installbuss=await isInstalledBuss()??false;

    String url = installbuss == true ? "whatsapp://send?text=$message"
        : "https://wa.me/?text=$message";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch WhatsApp.");
    }
  }

  Future<bool?> isInstalled() async {
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    return val;
  }
  Future<bool?> isInstalledBuss() async {
    final val = await WhatsappShare.isInstalled(
        package: Package.businessWhatsapp
    );
    return val;
  }
  Widget buildVideoPlayer() {
    return _controller.value.isInitialized
        ? GestureDetector(
      onTap: () {
        setState(() {
          isVideoPlaying = !isVideoPlaying;
          if (isVideoPlaying) {
            _controller.play();
          } else {
            _controller.pause();
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          Visibility(
            visible: !isVideoPlaying,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.replay_5, color: Colors.white),
                  onPressed: () {
                    _controller.seekTo(
                        _controller.value.position - Duration(seconds: 5));
                  },
                ),
                IconButton(
                  icon: Icon(
                    isVideoPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isVideoPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                      isVideoPlaying = !isVideoPlaying;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.forward_5, color: Colors.white),
                  onPressed: () {
                    _controller.seekTo(
                        _controller.value.position + Duration(seconds: 5));
                  },
                ),
              ],
            ),
          ),
          // ... (rest of the buildVideoPlayer function) ...

          Positioned(
            //top: 10,
              right: 5,
              bottom: 20,
              child: ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, VideoPlayerValue value, child) {
                  // Format current time
                  String twoDigits(int n) => n.toString().padLeft(2, "0");
                  String twoDigitMinutes = twoDigits(value.position.inMinutes.remainder(60));
                  String twoDigitSeconds = twoDigits(value.position.inSeconds.remainder(60));
                  String currentTime = "${twoDigits(value.position.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
                  if (value.position.inHours == 0) {
                    currentTime = "$twoDigitMinutes:$twoDigitSeconds";
                  }

                  // Format total time
                  String twoDigitMinutesTotal = twoDigits(value.duration.inMinutes.remainder(60));
                  String twoDigitSecondsTotal = twoDigits(value.duration.inSeconds.remainder(60));
                  String totalTime = "${twoDigits(value.duration.inHours)}:$twoDigitMinutesTotal:$twoDigitSecondsTotal";
                  if (value.duration.inHours == 0) {
                    totalTime = "$twoDigitMinutesTotal:$twoDigitSecondsTotal";
                  }

                  return Text(
                    '$currentTime/$totalTime',
                    style: TextStyle(color: Colors.white),
                  );
                },
              )
          ),

// ... (rest of the buildVideoPlayer function) ...
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: Colors.purple,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ),
          // Positioned( // Positioned widget for the current and total time
          //   top: 10,
          //   right: 10,
          //   child: ValueListenableBuilder(
          //     valueListenable: _controller,
          //     builder: (context, VideoPlayerValue value, child) {
          //       String currentTime = value.position.toString().split('.')[0];
          //       String totalTime = value.duration.toString().split('.')[0];
          //       return Text(
          //         '$currentTime/$totalTime',
          //         style: TextStyle(color: Colors.white),
          //       );
          //     },
          //   ),
          // ),
          Visibility(
            visible: _controller.value.position >= _controller.value.duration,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.replay, color: Colors.white, size: 40),
                onPressed: () {
                  _controller.seekTo(Duration.zero);
                  _controller.play();
                  setState(() {
                    isVideoPlaying = true; // Reset isVideoPlaying to true
                  });
                },
              ),
            ),
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }
  Widget buildImage() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black12,
      child: Image.network(
        widget.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
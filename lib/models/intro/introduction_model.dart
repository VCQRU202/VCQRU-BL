class IntroData {
  final String? header;
  final String? contains;
  final String? imagePath;

  IntroData({this.header, this.contains, this.imagePath});

  factory IntroData.fromJson(Map<String, dynamic> json) {
    return IntroData(
      header: json['header'],
      contains: json['contains'],
      imagePath: json['imagePath'],
    );
  }
}

class Blog {
  final String header;
  final String description;
  final String imagePath;
  final String fileType;
  final String uploadedDate;

  Blog({
    required this.header,
    required this.description,
    required this.imagePath,
    required this.fileType,
    required this.uploadedDate,
  });

  // Factory method to create Blog from API response
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      header: json['header'] ?? '',
      description: json['contains'] ?? '',
      imagePath: json['imagePath'] ?? '',
      fileType: json['filetype'] ?? 'Image',
      uploadedDate: json['uploaded_date'] ?? '',
    );
  }
}
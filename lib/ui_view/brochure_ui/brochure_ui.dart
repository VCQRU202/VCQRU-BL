import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';
import '../../providers_of_app/brochure_provider/brochure_provider.dart';
import '../../providers_of_app/splash_screen_provider/splash_screen_provider.dart';
import '../../res/app_colors/Colors.dart';


class BrochureShow extends StatefulWidget {
  @override
  _PDFViewerSingleWidgetState createState() => _PDFViewerSingleWidgetState();
}

class _PDFViewerSingleWidgetState extends State<BrochureShow> {
  String? pdfUrl;
  late Future<void> _fetchPDFFuture;
  @override
  void initState() {
    super.initState();
   // Fetch the brochure data when the widget is initialized
   //  Future.microtask(() {
   //    Provider.of<BochureProvider>(context, listen: false).getBochureProvider();
   //  });
    _fetchPDFFuture = fetchAndDisplayPDF();
  }
  /// Downloads a PDF from the given URL and saves it to the device.
  Future<String?> downloadPDF(String url) async {
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$filename");

      // Check if the file already exists
      if (await file.exists()) {
        return file.path;
      }

      // Perform the download
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        await file.writeAsBytes(bytes, flush: true);
        return file.path;
      } else {
        debugPrint("HTTP error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error downloading PDF: $e");
      return null;
    }
  }

  /// Fetches the brochure data and downloads the PDF.
  Future<void> fetchAndDisplayPDF() async {
    final provider = Provider.of<BochureProvider>(context, listen: false);
    // Wait for brochure data to be fetched
    await provider.getBochureProvider();
    if (provider.brochureData != null) {
      final url = provider.brochureData!.data?.brochure ?? "";
      debugPrint("Fetched URL: $url");
      if (url.isNotEmpty) {
        pdfUrl = await downloadPDF(url);
        if (pdfUrl != null) {
          debugPrint("PDF downloaded to: $pdfUrl");
        } else {
          debugPrint("Failed to download PDF");
          throw Exception("Failed to download PDF");
        }
      } else {
        throw Exception("No URL found in brochure data");
      }
    } else {
      throw Exception("No brochure data available");
    }
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Brochure",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: splashProvider.color_bg,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _fetchPDFFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Failed to load PDF",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _fetchPDFFuture = fetchAndDisplayPDF(); // Retry on error
                      });
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (pdfUrl == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No brochure available at the moment.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _fetchPDFFuture = fetchAndDisplayPDF(); // Retry loading
                      });
                    },
                    child: const Text("Reload"),
                  ),
                ],
              ),
            );
          } else {
            return PDFView(
              filePath: pdfUrl!,
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error displaying PDF: $error")),
                );
              },
              onRender: (pages) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text("PDF Loaded: $pages pages")),
                // );
              },
            );
          }
        },
      ),
    );
  }
}

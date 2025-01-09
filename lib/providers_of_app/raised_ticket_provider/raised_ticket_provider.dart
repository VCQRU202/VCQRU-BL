import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../data/repositorys/repositories_app.dart';
import '../../res/api_url/api_url.dart';
import '../../res/shared_preferences.dart';

class RaisedTicketProvider with ChangeNotifier{
  final _api = RepositoriesApp();

  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  List<XFile?> _images = [];
  List<XFile?> get images => _images;

  Future<void> addImage() async {
    if (_images.length >= 3) {
      _errorMessage = 'Maximum 3 images allowed.';
      _hasError = true;
      notifyListeners();
      return;
    }

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _images.add(image);
        _hasError = false;
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to pick image.';
    }
    notifyListeners();
  }

  void removeImage(XFile image) {
    _images.remove(image);
    notifyListeners();
  }

  Future<void> submitTicket(String description,String cate) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      var compId = AppUrl.Comp_ID;
      var consumerId = await SharedPrefHelper().get("M_Consumerid");

      Map<String, String> fields = {
        'Description': description,
        'Comp_id': compId,
        'M_Consumerid': consumerId.toString(),
        'Category': cate.toString(),
      };

      List<File> files = _images.map((e) => File(e!.path)).toList();

      final response = await _api.multipartRequest(
        fields,
        files,
        'Images',
        AppUrl.RAISE_TICKET,
      );
      print(response);
      if (response['success']) {
        _errorMessage = '';
        _hasError = false;
        _images.clear();
      } else {
        _hasError = true;
        _errorMessage = response['message'] ?? 'Failed to submit ticket.';
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Something went wrong. Please try again later.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
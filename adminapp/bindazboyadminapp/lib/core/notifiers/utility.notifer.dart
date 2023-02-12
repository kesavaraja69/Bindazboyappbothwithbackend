import 'dart:convert';
import 'dart:io';
import 'package:bindazboyadminapp/app/routes/api.routes.dart';
import 'package:bindazboyadminapp/core/models/images.model.dart';
import 'package:bindazboyadminapp/credentials/cloudnary.credential.dart';
import 'package:bindazboyadminapp/meta/widgets/snackbarutitly.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class UtilityNotifer extends ChangeNotifier {
  final _logger = Logger();
  String? _imageURL;
  String? get imageURL => _imageURL;

  Map<int, dynamic>? _imagesUrl;
  Map<int, dynamic>? get imagesUrl => _imagesUrl;

  List<String>? _myListimages = [];
  List<String>? get myListimages => _myListimages;

  List<String>? _myListfnimages = [];
  List<String>? get myListfnimages => _myListfnimages;

  List<String>? _myListdatafnimages = [];
  List<String>? get myListdatafnimages => _myListdatafnimages;

  String? _audioURL;
  String? get audioURL => _audioURL;

  String? _audioName;
  String? get audioName => _audioName;

  File? _previewblogimage;
  File? get previewblogimage => _previewblogimage;

  File? _fnpreviewblogimage;
  File? get fnpreviewblogimage => _fnpreviewblogimage;

  List<File>? _previewlistblogimages = [];
  List<File>? get previewlistblogimages => _previewlistblogimages;

  File? _previewblogaudio;
  File? get previewblogaudio => _previewblogaudio;

  pickblogimage(BuildContext context) async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image!.path.isNotEmpty) {
      _previewblogimage = File(image.path);
      _fnpreviewblogimage = await FlutterNativeImage.compressImage(
        _previewblogimage!.path,
        quality: 10,
      );
      print(_fnpreviewblogimage!.path);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Select Image"),
      ));
    }
  }

  Future pickblogimages(BuildContext context) async {
    final picker = FilePicker.platform;
    var images = await picker.pickFiles(allowMultiple: true);
    if (images!.paths.isNotEmpty) {
      _previewlistblogimages = images.paths.map((path) => File(path!)).toList();
      _myListimages = images.paths.cast();

      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Select Image"),
      ));
    }
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 5,
    );
    return compressedFile;
  }

  Future<String?> pickblogaudio(BuildContext context) async {
    final picker = FilePicker.platform;
    var audio = await picker.pickFiles();

    if (audio!.files.single.path!.isNotEmpty) {
      _previewblogaudio = File(audio.files.single.path!);
      _audioName = audio.files.single.name;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Select Audio"),
      ));
    }
    return _audioName;
  }

  Future removepreviewimage() async {
    await _previewblogimage?.delete();
    await _fnpreviewblogimage!.delete();
    _previewblogimage = null;
  }

  Future removeimgall() async {
    _myListdatafnimages?.clear();
    _myListdatafnimages = [];
    _myListfnimages?.clear();
    _myListfnimages = [];
    notifyListeners();
  }

  Future removepreviewimages() async {
    await _previewlistblogimages?.removeLast();
    _previewlistblogimages = null;
  }

  Future removepreviewaudio() async {
    await _previewblogaudio?.delete();
    _previewblogaudio = null;
    _audioName = null;
    notifyListeners();
  }

  Future removeaudioname() async {
    await _previewblogaudio?.delete();
    _previewblogaudio = null;
    _audioURL = null;
    _audioName = null;
    notifyListeners();
  }

  Future addimagefiles({required BuildContext context}) async {
    final suburl = "/blogs/addimagesupload/${_previewlistblogimages!.length}";
    var responses;
    var request =
        http.MultipartRequest('PATCH', Uri.parse(APIRoutes.LocalHost + suburl));
    // final httpDio = Dio();

    // var formData = FormData();

    // for (var file in _myListimages!) {
    //   formData.files.addAll([
    //     MapEntry("images", MultipartFile.fromFileSync(file)),
    //   ]);
    // }

    // final response = await httpDio.patch(
    //   ApiRoutes.LocalHost + suburl,
    //   data: formData,
    // );

    // List<http.MultipartFile> newList = [];
    // for (var i = 0; i < _allpreviewlistblogimages!.length; i++) {
    //   var multipartFile = http.MultipartFile(
    //     'Images',
    //     File(_allpreviewlistblogimages![i].path).readAsBytes().asStream(),
    //     File(_allpreviewlistblogimages![i].path).lengthSync(),
    //     // filename: img.path.split('/').last,
    //   );
    //   newList.add(multipartFile);
    // }
    // request.files.addAll(newList);
    if (_previewlistblogimages!.isNotEmpty) {
      for (var i = 0; i < _previewlistblogimages!.length; i++) {
        print("imagepath ${_previewlistblogimages![i].path}");
        request.files.addAll([
          http.MultipartFile(
              'images',
              File(_previewlistblogimages![i].path).readAsBytes().asStream(),
              File(_previewlistblogimages![i].path).lengthSync(),
              filename:
                  _previewlistblogimages![i].path.toString().split('/').last)
        ]);
        if (i == _previewlistblogimages!.length - 1) {
          print("loop is closed");
          var reqsendresponse = await request.send();
          responses = await http.Response.fromStream(reqsendresponse);
        }
      }
      //   // var reqsendresponse = await request.send();
    }

    // }
    // send
    // var response = await request.send();
    // request.files.add(http.MultipartFile(
    //     'images',
    //     File(_imagefilepath!.path.toString()).readAsBytes().asStream(),
    //     File(_imagefilepath!.path.toString()).lengthSync(),
    //     filename: "techking"));
    //   var reqsendresponse = await request.send();

    if (responses.statusCode == 200) {
      final parsedData = Imagespostmodel.fromJson(jsonDecode(responses.body));
      final customstatuscode = parsedData.code;
      final customdata = parsedData.message.toString();

      List<String?>? customdataurl = parsedData.data;
      _logger.i("mes $customstatuscode");
      _logger.i("mes list $customdata");
      notifyListeners();

      switch (customstatuscode) {
        case 201:
          // _videoURL = customdataurl;

          _myListfnimages = List<String>.from(customdataurl!);

          _myListdatafnimages =
              _myListfnimages?.map((e) => "${APIRoutes.LocalHost}$e").toList();

          notifyListeners();
          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
        case 301:
          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
        case 302:
          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
      }

      if (kDebugMode) {
        print("Uploaded! ");
        print('response.body ${responses.body}');
      }
      return responses.body;
    }
    // _responseData = response.body;
    return null;
  }

  Future addAllTypeFile(
      {required BuildContext context, dynamic filetype}) async {
    final suburl = "/blogs/addimageupload/$filetype";
    var response;
    var request =
        http.MultipartRequest('PATCH', Uri.parse(APIRoutes.LocalHost + suburl));

    if (filetype == "audio") {
      request.files.add(http.MultipartFile(
          'image',
          File(_previewblogaudio!.path.toString()).readAsBytes().asStream(),
          File(_previewblogaudio!.path.toString()).lengthSync(),
          filename:
              _previewblogaudio!.path.toString().split('/').last.toString()));
      var reqsendresponse = await request.send();

      response = await http.Response.fromStream(reqsendresponse);
    } else {
      request.files.add(http.MultipartFile(
          'image',
          File(_fnpreviewblogimage!.path.toString()).readAsBytes().asStream(),
          File(_fnpreviewblogimage!.path.toString()).lengthSync(),
          filename:
              _fnpreviewblogimage!.path.toString().split('/').last.toString()));
      var reqsendresponse = await request.send();

      response = await http.Response.fromStream(reqsendresponse);
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsedData = await jsonDecode(response.body);
      final customstatuscode = parsedData['code'];
      final customdata = parsedData['message'];

      final customdataurl = parsedData['data'];
      _logger.i("mes $customstatuscode");
      _logger.i("mes list $customdata");

      //  _videoURL = customdataurl;
      //  notifyListeners();

      switch (customstatuscode) {
        case 201:
          if (filetype == "audio") {
            _audioURL = "${APIRoutes.LocalHost}$customdataurl";
            notifyListeners();
          } else {
            _imageURL = "${APIRoutes.LocalHost}$customdataurl";
            notifyListeners();
          }

          // _videoURL = customdataurl;

          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
        case 301:
          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
        case 302:
          ShowsnackBarUtiltiy.showSnackbar(
              message: customdata, context: context);
          break;
      }

      if (kDebugMode) {
        print("Uploaded! ");
        print('response.body ${response.body}');
      }
    }
    // _responseData = response.body;
    return response.body;
  }

  // Future uploadblogImage({required BuildContext context}) async {
  //   final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
  //       CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
  //   await _cloudinary
  //       .uploadFile(
  //           filePath: _previewblogimage!.path,
  //           resourceType: CloudinaryResourceType.image,
  //           folder: "Bindazboy blog images")
  //       .then((value) {
  //     _imageURL = value.secureUrl;
  //     _previewblogimage!.delete();
  //     _previewblogimage = null;
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Image uploaded"),
  //     ));

  //     notifyListeners();
  //   }).catchError((error) {
  //     print(error);
  //   });
  // }

  // Future uploadblogImages(
  //     {required BuildContext context, required int index}) async {
  //   final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
  //       CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
  //   await _cloudinary
  //       .uploadFiles(
  //           filePaths: _myListimages,
  //           resourceType: CloudinaryResourceType.image,
  //           folder: "Bindazboy blog option images")
  //       .then((responses) {
  //     _myListfnimages =
  //         responses.asMap().values.map((e) => e.secureUrl.toString()).toList();
  //     // .map((i, res) => MapEntry(i, res.secureUrl.toString()));

  //     // _imagesUrl?.forEach((key, value) {
  //     //   _myListfnimages?.add(value);
  //     // });
  //     _logger.i(_myListfnimages);
  //     _previewlistblogimages!.clear();
  //     _previewlistblogimages = null;
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Images uploaded"),
  //     ));

  //     notifyListeners();
  //   }).catchError((error) {
  //     print(error);
  //   });
  // }

  // Future uploadblogAudio({required BuildContext context}) async {
  //   final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
  //       CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
  //   await _cloudinary
  //       .uploadFile(
  //           filePath: _previewblogaudio!.path,
  //           resourceType: CloudinaryResourceType.auto,
  //           folder: "Bindazboy blog Audios")
  //       .then((value) {
  //     _audioURL = value.secureUrl;
  //     _audioName = value.originalFilename;
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Audio uploaded"),
  //     ));
  //     notifyListeners();
  //   }).catchError((error) {
  //     print(error);
  //   });
  // }

  Future deleteblogImage({required BuildContext context, required url}) async {
    final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
        CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
    await _cloudinary
        .deleteFile(
      url: url,
      resourceType: CloudinaryResourceType.image,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Image Removed"),
      ));
      notifyListeners();
      return true;
    }).catchError((error) {
      print(error);
    });
  }

  Future deleteblogImages(
      {required BuildContext context, required dynamic urls}) async {
    final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
        CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
    await _cloudinary
        .deleteFiles(
      urls: urls,
      resourceType: CloudinaryResourceType.image,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Image Removed"),
      ));
      notifyListeners();
      return true;
    }).catchError((error) {
      print(error);
    });
  }

  Future deleteblogAudio({required BuildContext context, required url}) async {
    final _cloudinary = Cloudinary(CloudnaryCredentials.ApiKey,
        CloudnaryCredentials.ApiScrect, CloudnaryCredentials.Cloudname);
    await _cloudinary
        .deleteFile(
      url: url,
      resourceType: CloudinaryResourceType.auto,
    )
        .then((value) {
      _audioURL = null;
      _audioName = null;
      _previewblogaudio = null;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Audio Removed"),
      ));
      notifyListeners();
      return true;
    }).catchError((error) {
      print(error);
    });
  }
}

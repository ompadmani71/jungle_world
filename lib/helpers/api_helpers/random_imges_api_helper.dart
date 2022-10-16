import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../api/api_url.dart';

class RandImage {
  RandImage._();

  static final RandImage randImage = RandImage._();

 Future<String?> getRandImage() async {

  try{
   http.Response response = await http.get(Uri.parse(ApiUrl.random_animal));

   if(response.statusCode == 200){
    log("Response ==> ${response.body}");
    Map<String, dynamic> data = jsonDecode(response.body);
    return data["image_link"];
   }else{
    log("${response.statusCode}",error: "Status Code");
   }

  } catch (e){
   log("$e",error: "HTTP Error");
  }
  return null;
 }

}

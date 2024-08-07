import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String rgbToHex(Color color){
  return '${color.red.toRadixString(16).padLeft(2,'0')} ${color.green.toRadixString(16).padLeft(2,'0')} ${color.blue.toRadixString(16).padLeft(2,'0')}';


}

Color hexToColor(String hex) {
  hex = hex.trim().replaceAll("#", ""); // Remove the leading '#' and trim any whitespace
  print('Processed hex string: $hex'); // Debugging statement
  
  final validHexColor = RegExp(r'^[0-9A-Fa-f]{6}$|^[0-9A-Fa-f]{8}$');
  if (!validHexColor.hasMatch(hex)) {
    throw const FormatException("Hex color must be 6 or 8 characters long and contain only valid hexadecimal characters.");
  }
  
  if (hex.length == 6) {
    hex = "FF$hex "; // Add alpha value if not provided
  }
  
  return Color(int.parse(hex, radix: 16));
}



void showSnackBar(BuildContext context, String content){

  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar (content: Text(content)));

}

Future<File?> pickAudio() async {
  try{
    
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (filePickerRes != null){
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;





  }catch (e){
    return null;

  }
}


Future<File?> pickImage() async {
  try{
    
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (filePickerRes != null){
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;





  }catch (e){
    return null;

  }
}
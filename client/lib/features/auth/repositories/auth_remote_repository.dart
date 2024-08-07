import 'dart:convert';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/core/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref){
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  
   Future<Either<AppFailure,UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left( AppFailure(resBodyMap['detail']));
      }

      // Correctly decode the JSON response body without extra text
      
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      print('Exception: $e');
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure,UserModel>> login  ({

    required String email,
    required String password,



  }) async{

    try{

    final response = await http.post(Uri.parse('${ServerConstant.serverURL}/auth/login'),
    
    headers: {'Content-Type':'application/json;charset=UTF-8'},
    body: jsonEncode({
    'email':email,
    'password':password}),
    );

    final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200){
      return Left(AppFailure(resBodyMap['detail']));
    }
    

    return Right(UserModel.fromMap(resBodyMap['user']).copyWith(token: resBodyMap['token']));

    }

    catch (e){

      return Left(AppFailure(e.toString()));

    }



  }

   Future<Either<AppFailure,UserModel>> getCurrentUserData  (String token) async{

    try{

    final response = await http.get(Uri.parse('${ServerConstant.serverURL}/auth/'),
    
    headers: {'Content-Type':'application/json;charset=UTF-8',
              'x-auth-token': token
    
    
    },

  
    );

    final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200){
      return Left(AppFailure(resBodyMap['detail']));
    }
    

    return Right(UserModel.fromMap(resBodyMap).copyWith(token: token));

    }

    catch (e){

      return Left(AppFailure(e.toString()));

    }



  }




}



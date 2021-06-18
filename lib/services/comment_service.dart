



import 'dart:convert';
import 'package:blogapp/models/comment.dart';
import 'package:http/http.dart' as http;
import 'package:blogapp/models/api_response.dart';

import '../constant.dart';
import 'user_service.dart';

// Get post comments
Future<ApiResponse> getComments(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$postsURL/$postId/comments'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    
    switch(response.statusCode){
      case 200:
        // map each comments to comment model
        apiResponse.data = jsonDecode(response.body)['comments'].map((p) => Comment.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}



// Create comment
Future<ApiResponse> createComment(int postId, String? comment) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse('$postsURL/$postId/comments'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'comment': comment
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Delete comment
Future<ApiResponse> deleteComment(int commentId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$commentsURL/$commentId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}


// Edit comment
Future<ApiResponse> editComment(int commentId, String comment) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$commentsURL/$commentId'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'comment': comment
    });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch (e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}
// class ChatRequest {
//   final String inputText;
//
//   ChatRequest({required this.inputText});
//
//   Map<String, dynamic> toJson() => {'input_text': inputText};
// }
// class ChatResponse {
//   final String response;
//   final List<String> history;
//
//   ChatResponse({required this.response, required this.history});
//
//   factory ChatResponse.fromJson(Map<String, dynamic> json) {
//     return ChatResponse(
//       response: json['response'],
//       history: List<String>.from(json['history']),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'response': response,
//       'history': history.toList(),
//     };
//   }
// }
class ChatModel {

  String? inputText;
  PythonResponseAt? response;
  // dynamic response;
  // List? history;

  ChatModel({this.inputText, this.response});

  ChatModel.fromJson(Map<String, dynamic> json){
    inputText = json['inputText'];
    // response = json['response'] is String ? json['response'] : (json['response'] as Map<String, dynamic>)['text'];
    // response = json['response'];
    response = PythonResponseAt.fromJson(json['response']);

    // history = json['history'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inputText'] = inputText;
    data['response'] = response?.toJson();    // data['response'] = response;
    // data['history'] = history;
    return data;
  }
}

class PythonResponseAt {
  String? response;

  PythonResponseAt({this.response});

  factory PythonResponseAt.fromJson(Map<String, dynamic> json) {
    return PythonResponseAt(
      response: json['response'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    return data;
  }
}

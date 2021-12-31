// To parse this JSON data, do
//
//     final feedbackModels = feedbackModelsFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

FeedbackModels feedbackModelsFromJson(String str) => FeedbackModels.fromJson(json.decode(str));

String feedbackModelsToJson(FeedbackModels data) => json.encode(data.toJson());

class FeedbackModels {
    FeedbackModels({
        required this.message,
        required this.rating,
    });

    String message;
    String rating;

    factory FeedbackModels.fromJson(Map<String, dynamic> json) => FeedbackModels(
        message: json["message"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "rating": rating,
    };
}

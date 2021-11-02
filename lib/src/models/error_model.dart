import 'dart:convert';

ErrorModel ErrorModelFromMap(String str) => ErrorModel.fromMap(json.decode(str));

String ErrorModelToMap(ErrorModel data) => json.encode(data.toMap());


class ErrorModel{
    ErrorModel({
        required this.errors,
        
    });

    List<double> errors;


    factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        errors: List<double>.from(json["errors"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "errors": List<dynamic>.from(errors.map((x) => x)),
    };
}


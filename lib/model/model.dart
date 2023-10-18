
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    Body body;

    LoginModel({
        required this.body,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        body: Body.fromJson(json["Body"]),
    );

    Map<String, dynamic> toJson() => {
        "Body": body.toJson(),
    };
}

class Body {
    List<String> email;
    List<String> password;

    Body({
        required this.email,
        required this.password,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        email: List<String>.from(json["email"].map((x) => x)),
        password: List<String>.from(json["password"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
        "password": List<dynamic>.from(password.map((x) => x)),
    };
}

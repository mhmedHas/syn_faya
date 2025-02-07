// class ProfileData {
//   final String? image_api;
//   final String? name_api;
//   final String? email_api;
//   final int? age_api;
//   final int? order_Number_api;
//   final int? rate_api;
//   final String? about; //خبره 5 سنوات

//   ProfileData({
//     this.image_api,
//     this.name_api,
//     this.email_api,
//     this.age_api,
//     this.order_Number_api,
//     this.rate_api,
//     this.about,
//   });
//   factory ProfileData.fromJson(jsonData) {
//     return ProfileData(
//       image_api: jsonData["personal_info"]["profile_image"],
//       name_api: jsonData["personal_info"]["name"],
//       email_api: jsonData["personal_info"]["email"],
//       age_api: jsonData["personal_info"]["age"],
//       order_Number_api: jsonData["statistics"]["total_trips"],
//       rate_api: jsonData["statistics"]["rating"],
//       about: jsonData["personal_info"]["about"],
//     );
//   }
// }
class ProfileData {
  final String? image_api;
  final String? name_api;
  final String? email_api;
  final int? age_api;
  final int? order_Number_api;
  final int? rate_api;
  final String? about;

  ProfileData({
    this.image_api,
    this.name_api,
    this.email_api,
    this.age_api,
    this.order_Number_api,
    this.rate_api,
    this.about,
  });

  factory ProfileData.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> son) {
    return ProfileData(
      image_api: json["profile_image"],
      name_api: json["name"],
      email_api: json["email"],
      age_api: json["age"],
      order_Number_api: son["completed_orders"],
      rate_api: son["rating"],
      about: json["about"],
    );
  }
}

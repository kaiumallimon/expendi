class AddCategoryRequestModel{
  final String name;
  final String color;
  final String icon;

  AddCategoryRequestModel({
    required this.name,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  factory AddCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    return AddCategoryRequestModel(
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
    );
  }
}

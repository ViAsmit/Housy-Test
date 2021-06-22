import 'package:housy_test/models/CheckBoxModel.dart';

class HouseClean {
  Map<String, dynamic> data = {
    "typeService": "",
    "typeCleaning": "",
    "extras": "",
    "howOften": "",
    "details": "",
    "timing": "",
    "bedroom": "",
    "bathroom": "",
    "date": ""
  };

  List<dynamic> values = ["", "", "", "", [], "", "", "", []];

  List<CheckBoxModel> getFirstOptions = [
    CheckBoxModel(title: "Part-Time"),
    CheckBoxModel(title: "Full-Time"),
    CheckBoxModel(title: "Full-Time (Live-In)"),
  ];

  List<CheckBoxModel> getSecondOptions = <CheckBoxModel>[
    CheckBoxModel(title: "1"),
    CheckBoxModel(title: "2"),
    CheckBoxModel(title: "3"),
    CheckBoxModel(title: "4"),
    CheckBoxModel(title: "5"),
    CheckBoxModel(title: "6"),
  ];

  List<CheckBoxModel> getThirdOptions = <CheckBoxModel>[
    CheckBoxModel(title: "1"),
    CheckBoxModel(title: "2"),
    CheckBoxModel(title: "3"),
    CheckBoxModel(title: "4"),
    CheckBoxModel(title: "5"),
  ];

  List<CheckBoxModel> getFourthOptions = <CheckBoxModel>[
    CheckBoxModel(title: "Standard Cleaning"),
    CheckBoxModel(title: "Deep Cleaning"),
    CheckBoxModel(title: "Move out Cleaning"),
  ];

  List<CheckBoxModel> getFifthOptions = <CheckBoxModel>[
    CheckBoxModel(title: "Window Cleaning"),
    CheckBoxModel(title: "Fridge Cleaning"),
    CheckBoxModel(title: "Oven Cleaning"),
    CheckBoxModel(title: "Laundry"),
  ];

  List<CheckBoxModel> getSixthOptions = <CheckBoxModel>[
    CheckBoxModel(title: "Just Once"),
    CheckBoxModel(title: "Every Week"),
    CheckBoxModel(title: "Every Week"),
    CheckBoxModel(title: "Once a Month"),
  ];

  List<CheckBoxModel> getSeventhOptions = <CheckBoxModel>[
    CheckBoxModel(title: "Early Morning"),
    CheckBoxModel(title: "Morning"),
    CheckBoxModel(title: "Afternoon"),
    CheckBoxModel(title: "Evening"),
  ];

  Map<String, dynamic> mapValues() {
    data["typeService"] = values[0];
    data["bedroom"] = values[1];
    data["bathroom"] = values[2];
    data["typeCleaning"] = values[3];
    data["extras"] = values[4];
    data["howOften"] = values[5];
    data["details"] = values[6];
    data["date"] = values[7];
    data["timing"] = values[8];

    return data;
  }
}

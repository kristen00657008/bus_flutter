final cities = [
  City(chineseName: "基隆市", englishName: "Keelung"),
  City(chineseName: "臺北市", englishName: "Taipei"),
  City(chineseName: "新北市", englishName: "NewTaipei"),
  City(chineseName: "桃園市", englishName: "Taoyuan"),
  City(chineseName: "新竹市", englishName: "Hsinchu"),
  City(chineseName: "臺中市", englishName: "Taichung"),
  City(chineseName: "嘉義市", englishName: "Chiayi"),
  City(chineseName: "臺南市", englishName: "Tainan"),
  City(chineseName: "高雄市", englishName: "Kaohsiung"),
];

class City {
  final String chineseName;
  final String englishName;
  final bool? isChoose;

  City({
    required this.chineseName,
    required this.englishName,
    this.isChoose = true,
  });
}

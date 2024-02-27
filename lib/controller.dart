import 'package:get/get.dart';

import 'model/dbb.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  var relationship = Rx<String?>(null);
  var babyName = Rx<String?>(null);
  var gender = Rx<String?>(null);



  void setRelationship(String? newValue) => relationship.value = newValue;
  void setBabyName(String? newValue) => babyName.value = newValue;
  void setGender(String? newValue) => gender.value = newValue;
  void setSelectedDate(DateTime date) => selectedDatee.value = date;

  bool get isFormValid => relationship.value != null && babyName.value != null && gender.value != null;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Rx<DateTime?> babyBirthday = Rx<DateTime?>(null);

  void setBabyBirthday(DateTime? newDate) {
    babyBirthday.value = newDate;
  }

  RxBool val = false.obs;


  var selectedDatee = DateTime.now().obs;

  var vaccineHistory = <Map<String, dynamic>>[].obs;
  var medicineHistory = <Map<String, dynamic>>[].obs;
  var weightHistory = <Map<String, dynamic>>[].obs;
  var heightHistory = <Map<String, dynamic>>[].obs;

  final BabyTrackerDatabase babyTrackerDatabase = BabyTrackerDatabase();

  @override
  void onInit() {
    super.onInit();
    selectedDatee.listen((_) => fetchAllHistories());
    fetchAllHistories();
  }

  void fetchAllHistories() {
    fetchVaccineHistory();
    fetchMedicineHistory();
    fetchWeightHistory();
    fetchHeightHistory();
  }

  void fetchVaccineHistory() async {
    var data = await babyTrackerDatabase.readDataForDate('vaccine_history', selectedDatee.value);
    print("Fetched Vaccine Data: $data");
    vaccineHistory.assignAll(data);
  }


  void fetchMedicineHistory() async {
    var data = await babyTrackerDatabase.readDataForDate('medicine', selectedDatee.value);
    medicineHistory.assignAll(data);
  }

  void fetchWeightHistory() async {
    var data = await babyTrackerDatabase.readDataForDate('weight', selectedDatee.value);
    weightHistory.assignAll(data);
  }

  void fetchHeightHistory() async {
    var data = await babyTrackerDatabase.readDataForDate('height', selectedDatee.value);
    heightHistory.assignAll(data);
    print("Fetched sa Data: $data");
    heightHistory.assignAll(data);
  }


}



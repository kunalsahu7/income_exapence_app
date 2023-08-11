
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utills/DB_helper.dart';
import '../../Home/view/Home_Screen.dart';
import '../../filter/view/filter_screen.dart';

class   IncomeControllor extends GetxController {
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtCate = TextEditingController();
  TextEditingController txtdate = TextEditingController(
    text:
    "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
  );

  RxString ddstuts ="0".obs;

  RxInt status = 0.obs;

  RxString Filter = "0".obs;

  RxString payTypes = "online".obs;
  Rx<DateTime?> from = DateTime.now().obs;

  RxList incomeExapnce = [].obs;
  RxList cateList = [].obs;

  List Screens = [
    HomeScreen(),
    FilterScreen(),
  ];
  RxInt Secrreenindex = 0.obs;

  dbhelper db = dbhelper();

  void insertDate({
    required category,
    required amount,
    required stats,
    required date,
    required paytypes,
  }) {
    db.insertdb(
      category: category,
      amount: amount,
      stats: stats,
      date: date,
      paytypes: paytypes,
    );
  }

  Future<void> readDate() async {
    incomeExapnce.value = await db.readdata();
  }

  void delateData({
    required id,
  }) {
    db.delateData(id: id);

    readDate();
  }

  // cate

  void insertCate({
    required cate,
  }) {
    print("===============================$cate");
    db.insertCate(cate: cate);
  }

  Future<void> readCate() async {
    cateList.value = await db.readCate();
  }

  Future<void> Filterdata({required staus}) async {
    incomeExapnce.value = await db.FilterData(staus: staus);
  }

  void UpdateData({
    required stats,
    required paytypes,
    required date,
    required category,
    required amount,
    required id,
  }) {
    db.Update(
        stats: stats,
        paytypes: paytypes,
        date: date,
        category: category,
        amount: amount,
        id: id);
  }

  RxList<Map> total = <Map>[].obs;
  Future<void> TotalIncome() async {
    total.value = await db.TotalIncome(stats: 0);
    print(total);
  }
  RxList<Map> expanse = <Map>[].obs;
  Future<void> totalExpase() async {
    expanse.value = await db.totalExpanse(stats: 1);
    print(total);
  }

}

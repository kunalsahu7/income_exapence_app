import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controler/Insert_Controler.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  IncomeControllor incomeControllor = Get.put(
    IncomeControllor(),
  );

  @override
  void initState() {
    super.initState();

    incomeControllor.readCate();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Day to Day"),
            backgroundColor: Colors.black,
            bottom: TabBar(
              onTap: (value) {

              },
              tabs: [
                Tab(
                  child: Text(
                    "Income",
                  ),
                ),
                Tab(
                  child: Text(
                    "Expance",
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: incomeControllor.txtCate,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 600,
                                  color: Colors.grey,
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          TextEditingController txtcate = TextEditingController();
                                          Get.defaultDialog(
                                            content: Column(
                                              children: [
                                                TextField(
                                                  controller: txtcate,
                                                  decoration: InputDecoration(
                                                      label: Text("Add Category"),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      )
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    print(txtcate.text);
                                                    incomeControllor.insertCate(cate: txtcate.text);
                                                    incomeControllor.readCate();
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Add",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                        },
                                        child: Text(
                                          "Add Cate",
                                        ),
                                      ),
                                      Obx(
                                            () => Expanded(
                                          child: GridView.builder(
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                            ),
                                            itemCount: incomeControllor
                                                .cateList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.category,
                          ),
                        ),
                        label: Text("Select Category"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: incomeControllor.txtamount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.money_off),
                        label: Text("Amount"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                          () => DropdownButton(
                        isExpanded: true,
                        value: incomeControllor.payTypes.value,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "Offline",
                            ),
                            value: "offline",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Online",
                            ),
                            value: "online",
                          ),
                        ],
                        onChanged: (value) {
                          incomeControllor.payTypes.value = value!;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: incomeControllor.txtdate,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () async {
                            incomeControllor.from.value = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                            );

                            incomeControllor.txtdate = TextEditingController(
                                text:
                                "${incomeControllor.from.value!.day} / ${incomeControllor.from.value!.month} / ${incomeControllor.from.value!.year}");

                            setState(() {});
                          },
                          icon: Icon(
                            Icons.date_range,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        incomeControllor.insertDate(
                          category: incomeControllor.txtCate.text,
                          amount: incomeControllor.txtamount.text,
                          stats: 0,
                          date:
                          "${incomeControllor.from.value!.day} / ${incomeControllor.from.value!.month} / ${incomeControllor.from.value!.year}",
                          paytypes: incomeControllor.payTypes.value,
                        );

                        incomeControllor.readDate();
                        incomeControllor.TotalIncome();
                        //  incomeControllor.Secrreenindex.value = 1;
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black54),
                          color: Colors.black54,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Income",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: incomeControllor.txtCate,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  color: Colors.grey,
                                  child: GridView.builder(
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                    ),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.category,
                          ),
                        ),
                        label: Text("Select Category"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: incomeControllor.txtamount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.money_off),
                        label: Text("Amount"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                          () => DropdownButton(
                        isExpanded: true,
                        value: incomeControllor.payTypes.value,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "Offline",
                            ),
                            value: "offline",
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "Online",
                            ),
                            value: "online",
                          ),
                        ],
                        onChanged: (value) {
                          incomeControllor.payTypes.value = value!;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: incomeControllor.txtdate,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () async {
                            incomeControllor.from.value = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                            );

                            incomeControllor.txtdate = TextEditingController(
                                text:
                                "${incomeControllor.from.value!.day} / ${incomeControllor.from.value!.month} / ${incomeControllor.from.value!.year}");

                            setState(() {});
                          },
                          icon: Icon(
                            Icons.date_range,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        incomeControllor.insertDate(
                          category: incomeControllor.txtCate.text,
                          amount: incomeControllor.txtamount.text,
                          stats: 1,
                          date:
                          "${incomeControllor.from.value!.day} / ${incomeControllor.from.value!.month} / ${incomeControllor.from.value!.year}",
                          paytypes: incomeControllor.payTypes.value,
                        );

                        incomeControllor.readDate();
                        incomeControllor.totalExpase();
                        //( incomeControllor.Secrreenindex.value = 0;
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green.shade900),
                          color: Colors.red.shade300,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Exapnece",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

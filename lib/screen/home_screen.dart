import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:db_miner/helpers/api_helpers/animal_api_helper.dart';
import 'package:db_miner/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/db_helper/animal_db_helper.dart';
import '../model/animal_category_model.dart';
import '../model/animal_model.dart';
import '../uttils/gloable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Animal>>? fetchAnimal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isApiCall = prefs.getBool("isApiCall") ?? true;

      if(isApiCall){
        await AnimalDBHelper.animalDBHelper.deleteTable();
        await AnimalApiHelper.animalApiHelper.setAnimalData().then((value) async {
          await prefs.setBool("isApiCall", false);
        });
      }

      fetchAnimal =
          AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%dog%");
      setState(() {});
    });
  }

  List<AnimalCategory> animalCategoryList = [
    AnimalCategory(name: "Bear", image: "assets/images/category/bear.png"),
    AnimalCategory(name: "Cow", image: "assets/images/category/cow.png"),
    AnimalCategory(name: "Lion", image: "assets/images/category/lion.png"),
    AnimalCategory(name: "Parrot", image: "assets/images/category/parrot.png"),
    AnimalCategory(name: "Dog", image: "assets/images/category/pets.png"),
    AnimalCategory(name: "Monkey", image: "assets/images/category/monkey.png"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height * 0.38,
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/home.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "aplanet",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        "We Love the Planet",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.menu, color: Color(0xffecd1b3))
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Welcome To\nNew Aplanet",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: size.height * 0.65,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Color(0xffc19e81),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: (fetchAnimal != null)
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Related for you",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Expanded(
                            child: FutureBuilder(
                              future: fetchAnimal,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  log("${snapshot.error}", name: "Snapshot");
                                  return Center(
                                    child: Text("$snapshot.error"),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasData) {
                                  List<Animal> data = snapshot.data;

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(animal: data[index])));
                                        },
                                        child: Container(
                                          width: size.width * 0.5,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.35,
                                                  width: size.width * 0.5,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: (data[index].images_bytes == null || data[index].images_bytes == "null") ?
                                                      Image.asset("assets/images/placeholder.jpg",fit: BoxFit.cover,)
                                                          : Image.memory(
                                                        base64Decode(data[index]
                                                            .images_bytes!),
                                                        fit: BoxFit.cover,
                                                      ))),
                                              const SizedBox(height: 10),
                                              Flexible(
                                                child: Text(
                                                  data[index].name ?? "-",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: Text("ERROR :"),
                                );
                              },
                            ),
                          ),
                          const Text(
                            "Quick Categories",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState((){
                                        fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%Bear%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[0].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[0].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%cow%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[1].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[1].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%lion%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[2].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[2].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%parrot%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[3].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[3].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%Dog%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[4].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[4].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          fetchAnimal = AnimalDBHelper.animalDBHelper.fetchConditionalData(where: "%Monkey%");
                                        });
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffecd1b3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Image.asset(
                                            animalCategoryList[5].image,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      animalCategoryList[5].name,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
        )
      ],
    ));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/animal_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.animal}) : super(key: key);

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: size.width,
          height: size.height,
          color: Colors.black26,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xffc5996c),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * 0.3,
                      width: size.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: (animal.images_bytes == null ||
                                animal.images_bytes == "null") 
                            ? Image.asset("assets/images/placeholder.jpg")
                            : Image.memory(base64Decode(animal.images_bytes!))
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.15),
                text(field: "Name", name: animal.name),
                text(field: "Common Name", name: animal.common_name),
                text(field: "Location", name: animal.location),
                text(field: "Nesting Location", name: animal.nesting_location),
                text(field: "Color", name: animal.color),
                text(field: "Length", name: animal.length),
                text(field: "Weight", name: animal.weight),
                text(field: "Top Speed", name: animal.top_speed),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Column text({required String field, required String? name}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$field:",
              style: const TextStyle(fontSize: 18, color: Color(0xffc29462)),
            ),
            Flexible(
                child: Text(
              "  ${(name == null || name == "null") ? "-" : name}",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )),
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }
}

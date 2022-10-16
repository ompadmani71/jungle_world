import 'package:cached_network_image/cached_network_image.dart';
import 'package:db_miner/helpers/api_helpers/random_imges_api_helper.dart';
import 'package:db_miner/helpers/db_helper/subscription_db_helper.dart';
import 'package:db_miner/model/subscription_model.dart';
import 'package:db_miner/screen/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isIntroScreen2 = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await subscriptionDBHelper.dbHelper.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: isIntroScreen2 != true
              ? introScreen1(size: size)
              : introScreen2(size: size)),
    );
  }

  FutureBuilder introScreen1({required Size size}) {
    return FutureBuilder(
        future: RandImage.randImage.getRandImage(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                color: const Color(0xfff2d2b5),
                child: const CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: CachedNetworkImage(
                          imageUrl: "${snapshot.data}",
                          fit: BoxFit.cover,
                          placeholder: (context, _) {
                            return Image.asset("assets/images/placeholder.jpg",
                                fit: BoxFit.cover);
                          },
                        ),
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "aplanet",
                                      style: TextStyle(
                                          color: Color(0xfff2d2b5),
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "We Love the planet",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.menu,
                                  color:
                                      const Color(0xfff2d2b5).withOpacity(0.8),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "Ready to \nwatch?",
                                  style: TextStyle(
                                      fontSize: 45, color: Colors.white),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Aplanet is a global leader in real life entertainment, serving a passionate audience of superfans around the world with content that inspires, informs and entertains.",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Start Enjoying",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 30),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.85,
                  left: MediaQuery.of(context).size.width * 0.8,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isIntroScreen2 = true;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xffedd4b6),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: const Icon(Icons.arrow_right_alt_outlined,
                          color: Colors.white, size: 45),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  FutureBuilder introScreen2({required Size size}) {
    return FutureBuilder(
        future: subscriptionDBHelper.dbHelper.setUpSubscriptionData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                color: const Color(0xfff2d2b5),
                child: const CircularProgressIndicator());
          } else if (snapshot.hasData) {

            List<SubscriptionModel> data = snapshot.data;

            return Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(color: Color(0xffcba586)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "aplanet",
                                  style: TextStyle(
                                      color: Color(0xfff2d2b5), fontSize: 20),
                                ),
                                Text(
                                  "We Love the Planet",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.menu, color: Color(0xffecd1b3))
                          ],
                        ),
                        SizedBox(height: 35),
                        Text(
                          "Choose Plan",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Container(
                                    height: size.height * 0.20,
                                    padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 30),
                                    margin: const EdgeInsets.only(bottom: 15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(image: AssetImage(data[index].image),fit: BoxFit.cover)
                                    ),
                                    child: Row(
                                      children: [
                                        Text("${data[index].title}\nSubscription",style: const TextStyle(fontSize: 18,color: Colors.white),),
                                        const Spacer(),
                                        Text("\$${data[index].price}",style: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                  );
                            }),
                        ),
                        SizedBox(height: 30),
                        const Text(
                          "Last step to enjoy",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.85,
                  left: MediaQuery.of(context).size.width * 0.8,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: const Color(0xffedd4b6),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: const Icon(Icons.arrow_right_alt_outlined,
                          color: Colors.white, size: 45),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

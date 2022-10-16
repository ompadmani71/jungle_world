import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:db_miner/helpers/db_helper/animal_db_helper.dart';
import 'package:db_miner/model/animal_model.dart';
import 'package:db_miner/uttils/gloable.dart';
import 'package:http/http.dart' as http;

import '../api/api_url.dart';

class AnimalApiHelper{
  AnimalApiHelper._();

  static final AnimalApiHelper animalApiHelper = AnimalApiHelper._();

  List<String> bearImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Ursus_thibetanus_3_%28Wroclaw_zoo%29.JPG/330px-Ursus_thibetanus_3_%28Wroclaw_zoo%29.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Ours_brun_parcanimalierpyrenees_1.jpg/330px-Ours_brun_parcanimalierpyrenees_1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Bearded_Collie_600.jpg/330px-Bearded_Collie_600.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Bearded_Dragon_-_close-up.jpg/330px-Bearded_Dragon_-_close-up.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Bartgeier_Gypaetus_barbatus_front_Richard_Bartz.jpg/330px-Bartgeier_Gypaetus_barbatus_front_Richard_Bartz.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/2010-kodiak-bear-1.jpg/330px-2010-kodiak-bear-1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Grosser_Panda.JPG/330px-Grosser_Panda.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/GrizzlyBearJeanBeaufort.jpg/330px-GrizzlyBearJeanBeaufort.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/01_Schwarzb%C3%A4r.jpg/330px-01_Schwarzb%C3%A4r.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Polar_Bear_-_Alaska_%28cropped%29.jpg/330px-Polar_Bear_-_Alaska_%28cropped%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Owczarek_kaukaski_65556.jpg/330px-Owczarek_kaukaski_65556.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Urso_de_%C3%B3culos.jpg/330px-Urso_de_%C3%B3culos.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Sun-bear.jpg/330px-Sun-bear.jpg",
    "https://a-z-animals.com/media/2021/09/teddy-bear-hamster4-1024x535.jpg"
  ];

  List<String> cowImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg/360px-Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Moscow_watchdog_4.JPG/330px-Moscow_watchdog_4.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Hydrodamalis_gigas_skeleton_-_Finnish_Museum_of_Natural_History_-_DSC04529.JPG/375px-Hydrodamalis_gigas_skeleton_-_Finnish_Museum_of_Natural_History_-_DSC04529.JPG"
  ];

  List<String> lionImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Cape_Lion.jpg/330px-Cape_Lion.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Leontopithecus_rosalia_-_Copenhagen_Zoo_-_DSC09082.JPG/330px-Leontopithecus_rosalia_-_Copenhagen_Zoo_-_DSC09082.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lion_waiting_in_Namibia.jpg/330px-Lion_waiting_in_Namibia.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Largelionsmanejellyfish.jpg/330px-Largelionsmanejellyfish.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Red_lionfish_near_Gilli_Banta_Island.JPG/330px-Red_lionfish_near_Gilli_Banta_Island.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Mountain_Lion_in_Glacier_National_Park.jpg/330px-Mountain_Lion_in_Glacier_National_Park.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/California_sea_lion_in_La_Jolla_%2870568%29.jpg/330px-California_sea_lion_in_La_Jolla_%2870568%29.jpg",

  ];

  List<String> parrotImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Psittacus_erithacus_-perching_on_tray-8d.jpg/330px-Psittacus_erithacus_-perching_on_tray-8d.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Amazona_autumnalis_-side_-Belize_Zoo-8-3c.jpg/330px-Amazona_autumnalis_-side_-Belize_Zoo-8-3c.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Eclectus_roratus-20030511.jpg/330px-Eclectus_roratus-20030511.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Parrot_montage.jpg/450px-Parrot_montage.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Leptophis_ahaetulla.jpg/330px-Leptophis_ahaetulla.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Scarus_frenatus_by_Ewa_Barska.jpg/330px-Scarus_frenatus_by_Ewa_Barska.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Forpus_coelestis_-_male_pet.jpg/330px-Forpus_coelestis_-_male_pet.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Psittrichas_fulgidus_-Miami_Zoo%2C_USA-8-2c.jpg/390px-Psittrichas_fulgidus_-Miami_Zoo%2C_USA-8-2c.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Poicephalus_senegalus_-Maspalomas%2C_Gran_Canaria%2C_Canary_Islands%2C_Spain-8.jpg/330px-Poicephalus_senegalus_-Maspalomas%2C_Gran_Canaria%2C_Canary_Islands%2C_Spain-8.jpg",

  ];

  List<String> dogImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/African_wild_dog_%28Lycaon_pictus_pictus%29.jpg/330px-African_wild_dog_%28Lycaon_pictus_pictus%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Faithfullbull_Spike_of_Mightybull.jpg/330px-Faithfullbull_Spike_of_Mightybull.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Dermacentor_variabilis%2C_U%2C_Back%2C_MD%2C_Beltsville_2013-07-08-19.15.11_ZS_PMax.jpg/330px-Dermacentor_variabilis%2C_U%2C_Back%2C_MD%2C_Beltsville_2013-07-08-19.15.11_ZS_PMax.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/American_Eskimo_Dog_1.jpg/330px-American_Eskimo_Dog_1.jpg",
    "https://www.akc.org/wp-content/uploads/2017/11/Anatolian-Shepherd-Dog-On-White-01.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Eisa_Kessy_v_Br%C3%BCnggberg.jpg/330px-Eisa_Kessy_v_Br%C3%BCnggberg.jpg",
    "https://cdn-fastly.petguide.com/media/2022/02/16/8259028/australian-bulldog.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/ACD-blue-spud.jpg/330px-ACD-blue-spud.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Hilu_the_Australian_Kelpie_dog.jpg/330px-Hilu_the_Australian_Kelpie_dog.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Basenji_Profile_%28loosercrop%29.jpg/330px-Basenji_Profile_%28loosercrop%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Othello.jpg/330px-Othello.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/2/2b/BlueLacyPhoto1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/DocFile_Bolognese.jpg/330px-DocFile_Bolognese.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Male_fawn_Boxer_undocked.jpg/330px-Male_fawn_Boxer_undocked.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Rhipicephalus_sanguineus.jpg/330px-Rhipicephalus_sanguineus.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Bulldog_adult_male.jpg/330px-Bulldog_adult_male.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/CanaanDogChakede.jpg/330px-CanaanDogChakede.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Spoonsced.jpg/330px-Spoonsced.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg/330px-Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Gos-d%27Atura-Catala.jpg/330px-Gos-d%27Atura-Catala.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Gos-d%27Atura-Catala.jpg/330px-Gos-d%27Atura-Catala.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/TWH-jolly.JPG/330px-TWH-jolly.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Dermacentor_variabilis%2C_U%2C_Back%2C_MD%2C_Beltsville_2013-07-08-19.15.11_ZS_PMax.jpg/330px-Dermacentor_variabilis%2C_U%2C_Back%2C_MD%2C_Beltsville_2013-07-08-19.15.11_ZS_PMax.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/0Dogo-argentino-22122251920.jpg/330px-0Dogo-argentino-22122251920.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/French_Mastiff_female_4.jpg/330px-French_Mastiff_female_4.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Bulldog_adult_male.jpg/330px-Bulldog_adult_male.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Elio_v_Schaerlig_im_Juni_2007_klein.jpg/330px-Elio_v_Schaerlig_im_Juni_2007_klein.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/American_Eskimo_Dog_1.jpg/330px-American_Eskimo_Dog_1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Estrela_Mountain_Dog_6_month_old_male.jpg/330px-Estrela_Mountain_Dog_6_month_old_male.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/b/b0/Formosan_nina.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/2008-07-28_Dog_at_Frolick_Field.jpg/330px-2008-07-28_Dog_at_Frolick_Field.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Greater_Swiss_Mountain_Dog_2018.jpg/330px-Greater_Swiss_Mountain_Dog_2018.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Greenland_Dog.jpg/330px-Greenland_Dog.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Icelandic_Sheepdog_Alisa_von_Lehenberg.jpg/330px-Icelandic_Sheepdog_Alisa_von_Lehenberg.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Moscow_watchdog_4.JPG/330px-Moscow_watchdog_4.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Northern_Inuit_Dog.jpg/360px-Northern_Inuit_Dog.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/330px-Old_English_Sheepdog_%28side%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Polski_owczarek_nizinny_rybnik-kamien_pl.jpg/330px-Polski_owczarek_nizinny_rybnik-kamien_pl.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Black-Tailed_Prairie_Dog.jpg/330px-Black-Tailed_Prairie_Dog.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/%D0%84%D0%BD%D0%BE%D1%82%D0%BE%D0%B2%D0%B8%D0%B4%D0%BD%D0%B8%D0%B9_%D1%81%D0%BE%D0%B1%D0%B0%D0%BA%D0%B0_%28Nyctereutes_procyonoides%29.jpg/330px-%D0%84%D0%BD%D0%BE%D1%82%D0%BE%D0%B2%D0%B8%D0%B4%D0%BD%D0%B8%D0%B9_%D1%81%D0%BE%D0%B1%D0%B0%D0%BA%D0%B0_%28Nyctereutes_procyonoides%29.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Owczarek_kaukaski_65556.jpg/330px-Owczarek_kaukaski_65556.jpg"
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Oishani_Othari_van_Koekie%27s_Ranch.jpg/330px-Oishani_Othari_van_Koekie%27s_Ranch.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Squalus_acanthias_stellwagen.jpg/330px-Squalus_acanthias_stellwagen.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Trigonognathus_kabeyai_head_1.jpg/330px-Trigonognathus_kabeyai_head_1.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg/330px-Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg"
  ];

  List<String> monkeyImages = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Alouatta_guariba.jpg/330px-Alouatta_guariba.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Bonnet_macaque_%28Macaca_radiata%29_Photograph_By_Shantanu_Kuveskar.jpg/330px-Bonnet_macaque_%28Macaca_radiata%29_Photograph_By_Shantanu_Kuveskar.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Patas_Monkey.jpg/330px-Patas_Monkey.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Proboscis_Monkey_in_Borneo.jpg/330px-Proboscis_Monkey_in_Borneo.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Dv%C3%A6rgsilkeabe_Callithrix_pygmaea.jpg/330px-Dv%C3%A6rgsilkeabe_Callithrix_pygmaea.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Ateles_fusciceps_Colombia.JPG/330px-Ateles_fusciceps_Colombia.JPG",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Saimiri_sciureus-1_Luc_Viatour.jpg/330px-Saimiri_sciureus-1_Luc_Viatour.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Black_faced_vervet_monkey.jpg/330px-Black_faced_vervet_monkey.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Lagothrix_lagotricha.jpg/330px-Lagothrix_lagotricha.jpg",

  ];

  Future getBearData() async {

    try{

      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
          Uri.parse("${ApiUrl.animal}?name=bear"),
          headers:headers
      );

      if(response.statusCode == 200){
        List<Animal> bearDataList = animalFromJson(response.body);

        for(var i = 0; i<bearDataList.length; i++){
          bearDataList[i].images_bytes = await getImagesBytes(url: bearImages[i]);
        }

        print("bearDataList ==> ${bearDataList.length} ${bearImages.length}");

       await  AnimalDBHelper.animalDBHelper.insertRecord(data: bearDataList);
      }
      print("Bear Status Code ${response.statusCode}");

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future getCowData() async {
    try{

      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
          Uri.parse("${ApiUrl.animal}?name=cow"),
          headers:headers
      );

      print("Cow Status Code ${response.statusCode}");
      if(response.statusCode == 200){
        List<Animal> cowDataList = animalFromJson(response.body);

        print("cowDataList ==> ${cowDataList.length} ${cowImages.length}");
        for(var i = 0; i<cowDataList.length; i++){
          cowDataList[i].images_bytes = await getImagesBytes(url: cowImages[i]);
        }

        await  AnimalDBHelper.animalDBHelper.insertRecord(data: cowDataList);
      }

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future getLionData() async {

    try{

      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
        Uri.parse("${ApiUrl.animal}?name=lion"),
        headers:headers
      );

      print("Lion Status Code ${response.statusCode}");
      if(response.statusCode == 200){
        List<Animal> lionDataList = animalFromJson(response.body);

        print("lionDataList ==> ${lionDataList.length} ${lionImages.length}");
        for(var i = 0; i<lionDataList.length; i++){
          String? bytes = await getImagesBytes(url: lionImages[i]);

          lionDataList[i].images_bytes = bytes ?? "0";

        }

        await  AnimalDBHelper.animalDBHelper.insertRecord(data: lionDataList);

      }

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future getParrotData() async {

    try{

      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
        Uri.parse("${ApiUrl.animal}?name=parrot"),
        headers:headers
      );

      print("Parrot Status Code ${response.statusCode}");
      if(response.statusCode == 200){
        List<Animal> parrotDataList = animalFromJson(response.body);
        print("parrotDataList ==> ${parrotDataList.length} ${parrotImages.length}");

        for(var i = 0; i<parrotDataList.length; i++){
          parrotDataList[i].images_bytes = await getImagesBytes(url: parrotImages[i]);
        }

        await  AnimalDBHelper.animalDBHelper.insertRecord(data: parrotDataList);

      }

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future getDogData() async {

    try{

      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
        Uri.parse("${ApiUrl.animal}?name=dog"),
        headers:headers
      );

      print("Dog Status Code ${response.statusCode}");
      if(response.statusCode == 200){
        List<Animal> dogDataList = animalFromJson(response.body);
        print("dogDataList ==> ${dogDataList.length} ${dogImages.length}");

        for(var i = 0; i<dogDataList.length; i++){
          dogDataList[i].images_bytes = await getImagesBytes(url: dogImages[i]);
        }

        await  AnimalDBHelper.animalDBHelper.insertRecord(data: dogDataList);
      }

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future getMonkeyData() async {

    try{
      Map<String, String> headers = {'X-Api-Key': "QWYBkvti5512FNPtjIYr8w==a0SlHdkuiPgEp9bS"};
      http.Response response = await http.get(
        Uri.parse("${ApiUrl.animal}?name=monkey"),
        headers:headers
      );

      print("Monkey Status Code ${response.statusCode}");
      if(response.statusCode == 200){
        List<Animal> monkeyDataList = animalFromJson(response.body);
        print("monkeyDataList ==> ${monkeyDataList.length} ${monkeyImages.length}");

        for(var i = 0; i<monkeyDataList.length; i++){
          monkeyDataList[i].images_bytes = await getImagesBytes(url: monkeyImages[i]);
        }
        await  AnimalDBHelper.animalDBHelper.insertRecord(data: monkeyDataList);

      }

    }catch (e){
      log("$e",error: "Http Error");
    }

  }

  Future setAnimalData() async {
    await AnimalDBHelper.animalDBHelper.deleteTable();

    await getBearData();
    await getCowData();
    await getLionData();
    await getParrotData();
    await getDogData();
    await getMonkeyData();

    isData = true;
  }

  Future<String?> getImagesBytes({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      Uint8List bytes = response.bodyBytes;
      return base64Encode(bytes);
    }
    return null;
  }

  Future<Uint8List?> getImages({required String bytes}) async {
    Uint8List images = base64Decode(bytes);
    return images;
  }
}
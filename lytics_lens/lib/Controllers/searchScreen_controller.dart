import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lytics_lens/Constants/app_strrings.dart';
import 'package:lytics_lens/Constants/common_color.dart';
import 'package:lytics_lens/views/player_Screen.dart';
import 'package:lytics_lens/widget/common_snackbar.dart';
import 'package:lytics_lens/Models/alltopicmodel.dart';
import 'package:lytics_lens/Models/channelmodel.dart';
import 'package:lytics_lens/Models/programtypemodel.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/utils/api.dart';
import '../Models/channel.dart';
import '../Models/guestmodel.dart';
import '../Models/hostmodel.dart';
import '../widget/multiselectDropdown/utils/multi_select_item.dart';

class SearchController extends GetxController {
  var isLoading = true.obs;
  bool isExpanded1 = false;

  late NetworkController networkController;

  Random random = new Random();
  List listofRamdomNo = [];

  var isSocketError = false.obs;
  var isHeadline = false.obs;

  final storage = GetStorage();

  // <----------- Filter Data ----------->

  var filterChannelList = [].obs;
  List filterProgramType = [];

  // List<String> filterHost = [];

  // List<String> filterGuests = [];
  List clist = [];
  List uniquechanellist = [];
  List cchannellist = [];

  List programList = [];
  List programTypeList = [];
  List uniqueProgramList = [];

  List aList = [];
  List uniqueanchorlist = [];
  List anchorlistonly = [];

  List gList = [];
  List uniqueguestsList = [];
  List guestListonly = [];

  var isMore = false.obs;
  var totalPages = 0.obs;
  var pageno = 1.obs;
  var tpageno = 1.obs;
  var job = [].obs;
  DateTime now = DateTime.now();
  DateTime sixmonth = DateTime.now().subtract(Duration(days: 180));

  //<----------------------------------->

  var searchjob = [].obs;

  var filterlist = [].obs;

  var selectformDate = DateTime.now().obs;
  var selecttoDate = DateTime.now().obs;

  RegExp stringvalidate = RegExp(r'^[a-zA-Z0-9&|| ]+$');

  Rx<TextEditingController> lastSearchText = TextEditingController().obs;

  TextEditingController startDate = TextEditingController(
      text:
          '${DateTime.now().year}/${DateTime.now().month - 1}/${DateTime.now().day}');
  TextEditingController endDate = TextEditingController(
      text:
          '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}');

  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  Rx<TextEditingController> guestselect = TextEditingController().obs;
  Rx<TextEditingController> hostselect = TextEditingController().obs;

  DateTime selectedDays = DateTime.now();
  TimeOfDay prviousDays = TimeOfDay.now();

  var dateFormat = DateFormat("h:mm a");

  static CollectionReference headline =
      FirebaseFirestore.instance.collection('Headline');

  var headlinelist = [].obs;

  List topiclist = [];

  Rx<TextEditingController> searchdata = TextEditingController().obs;

  PersistentBottomSheetController? controller; // <------ Instance variable
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // <------------- Filer Data ------------------>
  List<ChannelModel> channellist = [];
  List<HostModel> hostList = [];
  List<GuestModel> guestModelList = [];
  var filterHost = [].obs;
  var filterGuests = [].obs;

  List<String> channellistonly = [];
  List<ProgramTypeModel> programType = [];

  List<String> selectedchannel = [];
  List<String> anchorList = [];
  List<String> guestsList = [];

  List jobsdate = [];

  // List topiclist = [];
  List topic2list = [];
  List topic3list = [];
  List allData = [];
  List topic2allData = [];
  List<AllTopicModel> alltopic = [];

  List<Channel> channels = [];
  List allChannels = [];

  List<MultiSelectItem<Channel>> item = [];

  List<Channel> selectedChannels = [];

  List<dynamic> checkNames = [];

  @override
  void onInit() async {
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }

    await gettopic();

    allChannels.add('All Channels');
    update();
    cchannellist.add({
      'id': 'all',
      'name': 'All Channels',
    });
    channellistonly.add('All Channels');
    selectedchannel.add('All Channels');
    update();
    storage.read('UsersChannels').forEach((e) {
      if(e.toString().isLowerCase == 'all')
        {

        }
      else
        {
          allChannels.add(e);
          channellistonly.add(e);
          filterChannelList.add(e);
          cchannellist.add({
            'id': e,
            'name': e,
          });
        }
    });

    cchannellist.forEach((element) {
      channellist.add(ChannelModel.fromJSON(element));
    });
    update();

    filterlist.clear();
    filterlist.add('All Channels');
    // filterChannelList.add('All Channels');
    channellist.forEach((element) {
      if (element.name == 'All Channels') {
        print('All Channel is true');
        element.check.value = true;
      }
    });

    // Channel For BottomSheet
    for (int i = 1; i < allChannels.length; i++) {
      channels.add(Channel(id: i, name: allChannels[i]));
    }
    update();
    item = channels.map((e) => MultiSelectItem<Channel>(e, e.name!)).toList();

    if (Get.arguments != null) {
      searchdata.value.text = Get.arguments.toString();
      update();
      print("Search text ${Get.arguments}");
      await getFilterJobs(Get.arguments.toString(), 1);
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await getProgramType();
    await getAllHost();
    await getAllGuests();
    getHeadlines();
    update();
    isLoading.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // <---------------- Get Program Type From Api's ---------------------->

  Future<void> getProgramType() async {
    print('Program Type Function');
    List responseprogramtyperesult = [];
    List responseprogramlist = [];
    programType.clear();
    responseprogramtyperesult.clear();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res =
            await http.get(Uri.parse(url + ApiData.programTypes), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print('Programtype Response $response');
        responseprogramtyperesult.addAll(response['results']);
        responseprogramtyperesult.forEach((element) {
          if(element['name'] == 'EE - Training' || element['name'] == 'UU - Training')
          {}
          else
          {
            responseprogramlist
                .add({'id': element['name'], 'name': element['name']});
          }
          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        update();
        responseprogramlist.forEach((element) {
          programType.add(ProgramTypeModel.fromJSON(element));
        });
        update();
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.programTypes), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print('Programtype Response $response');
        responseprogramtyperesult.addAll(response['results']);
        responseprogramtyperesult.forEach((element) {
          print("Program Type is $element");
          if(element['name'] == 'EE - Training' || element['name'] == 'UU - Training')
            {}
          else
            {
              responseprogramlist
                  .add({'id': element['name'], 'name': element['name']});
            }
          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        update();
        responseprogramlist.forEach((element) {
          programType.add(ProgramTypeModel.fromJSON(element));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: CommonColor.snackbarColour,
      //     isWarning: true);
    } catch (e) {
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // <---------------- Get All Host From Api's --------------------->

  Future<void> getAllHost() async {
    List allanchorList = [];
    anchorList.clear();
    List aList = [];
    List host = [];
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.get(Uri.parse(url + ApiData.hosts), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        allanchorList.addAll(response['results']);
        update();
        allanchorList.forEach((e) {
          aList.add(e['name']);
        });
        aList = Set.of(aList).toList();
        aList.forEach((e) {
          anchorList.add(e);
        });
        anchorList.sort((a, b) => a.toString().compareTo(b.toString()));

        anchorList.forEach((e) {
          host.add({
            "id": e,
            "name": e,
          });
        });

        host.forEach((element) {
          hostList.add(HostModel.fromJSON(element));
        });
        update();
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.hosts), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print('Hosts $response');
        allanchorList.addAll(response['results']);

        allanchorList.forEach((e) {
          aList.add(e['name']);
        });
        aList = Set.of(aList).toList();
        aList.forEach((e) {
          anchorList.add(e);
        });
        anchorList.sort((a, b) => a.toString().compareTo(b.toString()));

        anchorList.forEach((e) {
          host.add({
            "id": e,
            "name": e,
          });
        });

        host.forEach((element) {
          hostList.add(HostModel.fromJSON(element));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: CommonColor.snackbarColour,
      //     isWarning: true);
    } catch (e) {
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // <---------------- Get All Guests From Api's --------------------->

  Future<void> getAllGuests() async {
    List allGuestsList = [];
    guestsList.clear();
    List gList = [];
    List guest = [];
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.get(Uri.parse(url + ApiData.guest), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        allGuestsList.addAll(response['results']);
        allGuestsList.forEach((e) {
          gList.add(e['name']);
        });
        gList = Set.of(gList).toList();
        gList.forEach((e) {
          guestsList.add(e);
        });
        guestsList.sort((a, b) => a.toString().compareTo(b.toString()));
        guestsList.forEach((e) {
          guest.add({"id": e, "name": e});
        });
        guest.forEach((ele) {
          guestModelList.add(GuestModel.fromJSON(ele));
        });
        update();
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.guest), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print('Hosts $response');
        allGuestsList.addAll(response['results']);

        allGuestsList.forEach((e) {
          gList.add(e['name']);
        });
        gList = Set.of(gList).toList();
        gList.forEach((e) {
          guestsList.add(e);
        });
        guestsList.sort((a, b) => a.toString().compareTo(b.toString()));
        guestsList.forEach((e) {
          guest.add({"id": e, "name": e});
        });
        guest.forEach((ele) {
          guestModelList.add(GuestModel.fromJSON(ele));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: CommonColor.snackbarColour,
      //     isWarning: true);
    } catch (e) {
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> gettopic() async {
    try {
      String token = await storage.read("AccessToken");
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        var res = await http.get(Uri.parse(url + ApiData.topic), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        topiclist.addAll(data['results']);
        update();
      } else {
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.topic), headers: {
          'Authorization': "Bearer $token",
        });
        var data = json.decode(res.body);
        Get.log('Data is $data');
        // print('Data is $data');
        allData.addAll(data['results']);
        update();
        allData.forEach((e) {
          topiclist.add({'id': e['name'], 'name': e['name']});
          e['topic2'].forEach((a) {
            topic2allData.add(a);
          });
        });
        update();
        topic2allData.forEach((element) {
          topiclist.add({'id': element['name'], 'name': element['name']});
          element['topic3'].forEach((a) {
            topic3list.add(a);
          });
        });
        update();
        topic3list.forEach((q) {
          topiclist.add({'id': q['name'], 'name': q['name']});
        });
        update();
        topiclist = Set.of(topiclist).toList();
        update();
        topiclist.forEach((w) {
          alltopic.add(AllTopicModel.fromJSON(w));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      isLoading.value = false;
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: CommonColor.snackbarColour,
      //     isWarning: true);
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future<void> getHeadlines() async {
    isHeadline.value = true;
    try {
      Stream<QuerySnapshot> data = headline.snapshots();
      await data.forEach((e) {
        headlinelist.clear();
        for (var value in e.docs) {
          headlinelist.add(value.data());
        }
        isHeadline.value = false;
      }).catchError((e) {
        CustomSnackBar.showSnackBar(
            title: AppStrings.unable,
            message: "",
            backgroundColor: CommonColor.snackbarColour);
      });
    } on FirebaseException catch (e) {
      print(e);
      CustomSnackBar.showSnackBar(
          title: AppStrings.unable,
          message: "",
          backgroundColor: CommonColor.snackbarColour,
          isWarning: true);
    }
  }

  Future<void> check(String c) async {
    if (stringvalidate.hasMatch(c)) {
      print("Match True");
    } else {
      print("Not MATCH");
    }
  }

  // Future<void> getSearchJobs(String searchText, int p) async {
  //   // isLoading = true;
  //   // update();
  //   print("Search Text $searchText");
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   // ignore: unused_local_variable
  //   var sd = formatter.format(selectedDays);
  //   var pm =
  //       DateTime(selectedDays.year, selectedDays.month - 1, selectedDays.day);
  //   // ignore: unused_local_variable
  //   var ed = formatter.format(pm);
  //   bool searchValid = RegExp(r'^[a-zA-Z]*$').hasMatch(searchText);
  //   print('Search Valid $searchValid');
  //   // job.clear();
  //   jobsdate.clear();
  //   var res;
  //   try {
  //     if (storage.hasData("Url") == true) {
  //       if (p == 1) {
  //         isLoading.value = true;
  //         print('Check Storage Function');
  //         job.clear();
  //
  //         clist.clear();
  //         uniquechanellist.clear();
  //         programList.clear();
  //         uniqueProgramList.clear();
  //         aList.clear();
  //         uniqueanchorlist.clear();
  //         anchorlistonly.clear();
  //         gList.clear();
  //         uniqueguestsList.clear();
  //         guestListonly.clear();
  //
  //         filterlist.clear();
  //         filterChannelList.clear();
  //         filterProgramType.clear();
  //
  //         String url = storage.read("Url");
  //         String token = await storage.read("AccessToken");
  //         print("Bearer $token");
  //         searchValid == true
  //             ? res = await http.get(
  //                 Uri.parse(
  //                     '$url${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchEnglish=$searchText'),
  //                 headers: {
  //                     'Authorization': "Bearer $token",
  //                   })
  //             : res = await http.get(
  //                 Uri.parse(
  //                     '$url${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchUrdu=$searchText'),
  //                 headers: {
  //                     'Authorization': "Bearer $token",
  //                   });
  //         print('Check Storage Function ${res.statusCode}');
  //         print(res.statusCode);
  //         print('Else FUnction');
  //         var data = json.decode(res.body);
  //         job.addAll(data['results']);
  //         if (p == 1) {
  //           totalPages = data['totalPages'];
  //           update();
  //         }
  //
  //         // <---------- Filter Screen -------->
  //
  //         job.forEach((j) {
  //           clist.add(j['channel']);
  //           programList.add(j['programType']);
  //           aList.add(j['anchor']);
  //           if (j['guests'].toString().length != 2) {
  //             gList.add(j['guests']);
  //           }
  //           print(
  //               'Job Date is ${j['programDate'].toString().split('T').first}');
  //         });
  //         update();
  //         if (aList.length != 0) {
  //           aList.forEach((element) {
  //             anchorlistonly.add(element[0]);
  //           });
  //         }
  //         print('break ${gList.length}');
  //         if (gList.length != 0) {
  //           for (int i = 0; i < gList.length; i++) {
  //             gList[i].forEach((e) {
  //               guestListonly.add(e['name']);
  //             });
  //           }
  //           update();
  //         }
  //         print('break');
  //         // guestListonly.forEach((element) {
  //         //   print('All Guests ${element['name']}');
  //         // });
  //         uniquechanellist = Set.of(clist).toList();
  //         uniqueProgramList = Set.of(programList).toList();
  //         uniqueanchorlist = Set.of(anchorlistonly).toList();
  //         uniqueguestsList = Set.of(guestListonly).toList();
  //         update();
  //
  //         //<-------- Program List ---------->
  //
  //         uniqueProgramList.forEach((e) {
  //           programTypeList.add({
  //             'id': '$e',
  //             'name': '$e',
  //           });
  //         });
  //
  //         update();
  //         channellist.forEach((element) {
  //           // print('All channellist is $element');
  //         });
  //         isLoading.value = false;
  //       } else {
  //         if (tpageno.value <= totalPages) {
  //           isMore.value = true;
  //           String url = storage.read("Url");
  //           String token = await storage.read("AccessToken");
  //           searchValid == true
  //               ? res = await http.get(
  //                   Uri.parse(
  //                       '$url${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchEnglish=$searchText'),
  //                   headers: {
  //                       'Authorization': "Bearer $token",
  //                     })
  //               : res = await http.get(
  //                   Uri.parse(
  //                       '$url${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchUrdu=$searchText'),
  //                   headers: {
  //                       'Authorization': "Bearer $token",
  //                     });
  //           print(res.statusCode);
  //           print('Else FUnction');
  //           var data = json.decode(res.body);
  //           // debugPrint('Search Data $data');
  //           // print('chanels ${data['results'][0]['channel']}');
  //           job.addAll(data['results']);
  //           if (p == 1) {
  //             totalPages = data['totalPages'];
  //             update();
  //           }
  //           // <---------- Filter Screen -------->
  //
  //           job.forEach((j) {
  //             clist.add(j['channel']);
  //             programList.add(j['programType']);
  //             aList.add(j['anchor']);
  //             if (j['guests'].toString().length != 2) {
  //               gList.add(j['guests']);
  //             }
  //             print(
  //                 'Job Date is ${j['programDate'].toString().split('T').first}');
  //           });
  //           update();
  //           if (aList.length != 0) {
  //             aList.forEach((element) {
  //               anchorlistonly.add(element[0]);
  //             });
  //           }
  //           print('break ${gList.length}');
  //           if (gList.length != 0) {
  //             for (int i = 0; i < gList.length; i++) {
  //               gList[i].forEach((e) {
  //                 guestListonly.add(e['name']);
  //               });
  //             }
  //             update();
  //           }
  //           print('break');
  //           // guestListonly.forEach((element) {
  //           //   print('All Guests ${element['name']}');
  //           // });
  //           uniquechanellist = Set.of(clist).toList();
  //           uniqueProgramList = Set.of(programList).toList();
  //           uniqueanchorlist = Set.of(anchorlistonly).toList();
  //           uniqueanchorlist = Set.of(anchorlistonly).toList();
  //           uniqueguestsList = Set.of(guestListonly).toList();
  //
  //
  //
  //           update();
  //           channellist.forEach((element) {
  //             // print('All channellist is $element');
  //           });
  //           isLoading.value = false;
  //           isMore.value = false;
  //         } else {
  //           isMore.value = false;
  //           print('Result Not Found');
  //         }
  //       }
  //     } else {
  //       if (p == 1) {
  //         isLoading.value = true;
  //
  //         print('Check Storage Function');
  //         job.clear();
  //
  //         clist.clear();
  //         uniquechanellist.clear();
  //         programList.clear();
  //         programTypeList.clear();
  //         uniqueProgramList.clear();
  //         aList.clear();
  //         uniqueanchorlist.clear();
  //         anchorlistonly.clear();
  //         gList.clear();
  //         uniqueguestsList.clear();
  //         guestListonly.clear();
  //
  //         filterlist.clear();
  //         filterChannelList.clear();
  //         filterProgramType.clear();
  //
  //         String token = await storage.read("AccessToken");
  //         print("Bearer $token");
  //         searchValid == true
  //             ? res = await http.get(
  //                 Uri.parse(
  //                     '${ApiData.baseUrl}${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchEnglish=$searchText'),
  //                 headers: {
  //                     'Authorization': "Bearer $token",
  //                   })
  //             : res = await http.get(
  //                 Uri.parse(
  //                     '${ApiData.baseUrl}${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchUrdu=$searchText'),
  //                 headers: {
  //                     'Authorization': "Bearer $token",
  //                   });
  //         print('Check Storage Function ${res.statusCode}');
  //         print(res.statusCode);
  //         print('Else FUnction');
  //         var data = json.decode(res.body);
  //         job.addAll(data['results']);
  //         if (p == 1) {
  //           totalPages = data['totalPages'];
  //           update();
  //         }
  //
  //         // <---------- Filter Screen -------->
  //
  //         job.forEach((j) {
  //           clist.add(j['channel']);
  //           programList.add(j['programType']);
  //           aList.add(j['anchor']);
  //           if (j['guests'].toString().length != 2) {
  //             gList.add(j['guests']);
  //           }
  //           print(
  //               'Job Date is ${j['programDate'].toString().split('T').first}');
  //         });
  //         update();
  //         if (aList.length != 0) {
  //           aList.forEach((element) {
  //             anchorlistonly.add(element[0]);
  //           });
  //         }
  //         print('break ${gList.length}');
  //         if (gList.length != 0) {
  //           for (int i = 0; i < gList.length; i++) {
  //             gList[i].forEach((e) {
  //               guestListonly.add(e['name']);
  //             });
  //           }
  //           update();
  //         }
  //         print('break');
  //         // guestListonly.forEach((element) {
  //         //   print('All Guests ${element['name']}');
  //         // });
  //         uniquechanellist = Set.of(clist).toList();
  //         uniqueProgramList = Set.of(programList).toList();
  //         uniqueanchorlist = Set.of(anchorlistonly).toList();
  //         uniqueanchorlist = Set.of(anchorlistonly).toList();
  //         uniqueguestsList = Set.of(guestListonly).toList();
  //
  //         update();
  //         channellist.forEach((element) {
  //           // print('All channellist is $element');
  //         });
  //         isLoading.value = false;
  //       } else {
  //         if (tpageno.value <= totalPages) {
  //           isMore.value = true;
  //
  //           String token = await storage.read("AccessToken");
  //           print("Bearer $token");
  //           searchValid == true
  //               ? res = await http.get(
  //                   Uri.parse(
  //                       '${ApiData.baseUrl}${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchEnglish=$searchText'),
  //                   headers: {
  //                       'Authorization': "Bearer $token",
  //                     })
  //               : res = await http.get(
  //                   Uri.parse(
  //                       '${ApiData.baseUrl}${ApiData.jobs}?start_date=${now.year}/${now.month - 1}/${now.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&searchUrdu=$searchText'),
  //                   headers: {
  //                       'Authorization': "Bearer $token",
  //                     });
  //           print(res.statusCode);
  //           print('Else FUnction');
  //           var data = json.decode(res.body);
  //           // debugPrint('Search Data $data');
  //           // print('chanels ${data['results'][0]['channel']}');
  //           job.addAll(data['results']);
  //           if (p == 1) {
  //             totalPages = data['totalPages'];
  //             update();
  //           }
  //           // <---------- Filter Screen -------->
  //
  //           job.forEach((j) {
  //             clist.add(j['channel']);
  //             programList.add(j['programType']);
  //             aList.add(j['anchor']);
  //             if (j['guests'].toString().length != 2) {
  //               gList.add(j['guests']);
  //             }
  //             print(
  //                 'Job Date is ${j['programDate'].toString().split('T').first}');
  //           });
  //           update();
  //           if (aList.length != 0) {
  //             aList.forEach((element) {
  //               anchorlistonly.add(element[0]);
  //             });
  //           }
  //           print('break ${gList.length}');
  //           if (gList.length != 0) {
  //             for (int i = 0; i < gList.length; i++) {
  //               gList[i].forEach((e) {
  //                 guestListonly.add(e['name']);
  //               });
  //             }
  //             update();
  //           }
  //
  //           update();
  //           print('break');
  //           // guestListonly.forEach((element) {
  //           //   print('All Guests ${element['name']}');
  //           // });
  //           uniquechanellist = Set.of(clist).toList();
  //           uniqueProgramList = Set.of(programList).toList();
  //           uniqueanchorlist = Set.of(anchorlistonly).toList();
  //           uniqueanchorlist = Set.of(anchorlistonly).toList();
  //           uniqueguestsList = Set.of(guestListonly).toList();
  //
  //           update();
  //           channellist.forEach((element) {
  //             // print('All channellist is $element');
  //           });
  //           isLoading.value = false;
  //           isMore.value = false;
  //         } else {
  //           isMore.value = false;
  //           print('Result Not Found');
  //         }
  //       }
  //     }
  //   } on SocketException catch (e) {
  //     isLoading.value = false;
  //     isSocketError.value = true;
  //     CustomSnackBar.showSnackBar(
  //         title: e.message.toString(),
  //         message: "",
  //         backgroundColor: CommonColor.snackbarColour);
  //   } catch (e) {
  //     isLoading.value = false;
  //     print(e.toString());
  //     // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  //   }
  // }

  Future<void> getFilterJobs(String searchText, int p) async {
    print('filter function');
    isSocketError.value = false;
    print('Selected Date is ${startDate.text} - ${endDate.text}');
    bool searchValid = RegExp(r'^[a-zA-Z]*$').hasMatch(searchText);
    print('Search Valid $searchValid');
    if (searchText.isEmpty || searchText == '') {
      searchText = lastSearchText.value.text;
    } else {
      lastSearchText.value.text = searchText;
    }
    // lastSearchText.value.text = searchText;
    // job.clear();
    var res;
    try {
      if (storage.hasData("Url") == true) {
        if (p == 1) {
          String url = storage.read("Url");
          print('filter function if condition');
          var fh = json.encode(filterHost);
          var fg = json.encode(filterGuests);
          var fpt = json.encode(filterProgramType);
          print(fg);
          print(fpt);
          print('Filter host  $fh');
          isLoading.value = true;
          job.clear();
          searchjob.clear();

          String token = await storage.read("AccessToken");
          print("Bearer $token");
          Get.log(
              'Check Query $url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}');
          searchValid == true
              ? res = await http.get(
                  Uri.parse(
                      '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                  headers: {
                      'Authorization': "Bearer $token",
                    })
              : res = await http.get(
                  Uri.parse(
                      '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                  headers: {
                      'Authorization': "Bearer $token",
                    });
          // searchValid == true
          //     ? res = await http.get(
          //         Uri.parse(
          //             '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&device=mobile'),
          //         headers: {
          //             'Authorization': "Bearer $token",
          //           })
          //     : res = await http.get(
          //         Uri.parse(
          //             '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&device=mobile'),
          //         headers: {
          //             'Authorization': "Bearer $token",
          //           });

          var data = json.decode(res.body);
          print('Result is filter${res.body}');

          searchjob.addAll(data['results']);
          // searchjob
          //     .sort((b, a) => a["programDate"].compareTo(b["programDate"]));
          if (p == 1) {
            totalPages = data['totalPages'];
            update();
          }
          getRandomNumberList(searchjob.length);
          isLoading.value = false;
          searchjob.forEach((element) {
            print('Serach Job $element');
          });
        } else {
          print('filter function else function');
          if (tpageno.value <= totalPages.value) {
            isMore.value = true;
            String token = await storage.read("AccessToken");
            String url = storage.read("Url");
            print("Bearer $token");
            var fh = json.encode(filterHost);
            var fg = json.encode(filterGuests);
            var fpt = json.encode(filterProgramType);
            print('Filter host  $fg');
            print('CHeck Function Work');
            searchValid == true
                ? res = await http.get(
                    Uri.parse(
                        '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                    headers: {
                        'Authorization': "Bearer $token",
                      })
                : res = await http.get(
                    Uri.parse(
                        '$url${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                    headers: {
                        'Authorization': "Bearer $token",
                      });
            // searchValid == true
            //     ? res = await http.get(
            //         Uri.parse(
            //             '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
            //         headers: {
            //             'Authorization': "Bearer $token",
            //           })
            //     : res = await http.get(
            //         Uri.parse(
            //             '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
            //         headers: {
            //             'Authorization': "Bearer $token",
            // });
            print(res.statusCode);
            print('Else FUnction');

            var data = json.decode(res.body);
            // debugPrint('Search Data $data');
            // print('chanels ${data['results'][0]['channel']}');
            searchjob.addAll(data['results']);
            // searchjob
            //     .sort((b, a) => a["programDate"].compareTo(b["programDate"]));

            if (p == 1) {
              totalPages = data['totalPages'];
              update();
            }
            getRandomNumberList(searchjob.length);
            isLoading.value = false;
            isMore.value = false;
          } else {
            isMore.value = false;
            print('Result Not Found');
          }
        }
      } else {
        if (p == 1) {
          print('filter function if condition');
          tpageno.value = 1;
          var fh = json.encode(filterHost);
          var fg = json.encode(filterGuests);
          var fpt = json.encode(filterProgramType);
          print('Filter host  $fh');
          isLoading.value = true;
          job.clear();
          searchjob.clear();
          String token = await storage.read("AccessToken");
          print("Bearer $token");
          Get.log(
              'Check Query ${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}');
          searchValid == true
              ? res = await http.get(
                  Uri.parse(
                      '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                  headers: {
                      'Authorization': "Bearer $token",
                    })
              : res = await http.get(
                  Uri.parse(
                      '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                  headers: {
                      'Authorization': "Bearer $token",
                    });

          var data = json.decode(res.body);
          print('Result is filter${res.body}');
          searchjob.addAll(data['results']);
          // searchjob
          //     .sort((b, a) => a["programDate"].compareTo(b["programDate"]));

          if (p == 1) {
            print('Total No of Pages ${data['totalPages']}');
            print('Total No of Pages ${tpageno.value}');
            totalPages.value = data['totalPages'];
            update();
          }
          getRandomNumberList(searchjob.length);
          isLoading.value = false;
          searchjob.forEach((element) {
            print('Serach Job $element');
          });
        } else {
          print('filter function else function');
          if (tpageno.value <= totalPages.value) {
            isMore.value = true;
            String token = await storage.read("AccessToken");
            print("Bearer $token");
            var fh = json.encode(filterHost);
            var fg = json.encode(filterGuests);
            var fpt = json.encode(filterProgramType);
            print('Filter host  $fg');
            searchValid == true
                ? res = await http.get(
                    Uri.parse(
                        '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                    headers: {
                        'Authorization': "Bearer $token",
                      })
                : res = await http.get(
                    Uri.parse(
                        '${ApiData.baseUrl}${ApiData.jobs}?start_date=${startDate.text}&end_date=${endDate.text}&limit=30&page=$p&source=All&searchEnglish=$searchText&hosts=$fh&guest=$fg&programType=$fpt&device=mobile&channel=${json.encode(filterChannelList)}'),
                    headers: {
                        'Authorization': "Bearer $token",
                      });
            print(res.statusCode);
            print('Else FUnction');
            var data = json.decode(res.body);
            // debugPrint('Search Data $data');
            // print('chanels ${data['results'][0]['channel']}');
            searchjob.addAll(data['results']);
            // searchjob
            //     .sort((b, a) => a["programDate"].compareTo(b["programDate"]));

            // if (p == 1) {
            //   totalPages = data['totalPages'];
            //   update();
            // }
            getRandomNumberList(searchjob.length);
            isLoading.value = false;
            isMore.value = false;
          } else {
            isMore.value = false;
            print('Result Not Found');
          }
        }
      }
    } on SocketException catch (e) {
      isLoading.value = false;
      isSocketError.value = true;
      print(e.toString());
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: CommonColor.snackbarColour);
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  String convertDateUtc(String cdate) {
    var strToDateTime = DateTime.parse(cdate);
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat("dd MM");
    String updatedDt = newFormat.format(convertLocal);
    String q = updatedDt.split(' ').last;
    String a = updatedDt.split(' ').first;
    print(updatedDt);
    return a + convertIntoDateTime(q);
  }

  String convertIntoDateTime(String month) {
    if (month == "01") {
      return ' Jan';
    } else if (month == "02") {
      return ' Feb';
    } else if (month == "03") {
      return ' Mar';
    } else if (month == "04") {
      return ' Apr';
    } else if (month == "05") {
      return ' May';
    } else if (month == "06") {
      return ' Jun';
    } else if (month == "07") {
      return ' Jul';
    } else if (month == "08") {
      return ' Aug';
    } else if (month == "09") {
      return ' Sep';
    } else if (month == "10") {
      return ' Oct';
    } else if (month == "11") {
      return ' Nov';
    } else {
      return ' Dec';
    }
  }

  String convertTime(String time) {
    var dateList = time.split(" ").first;

    return dateList;
  }

  void getRandomNumberList(int l) {
    listofRamdomNo.clear();
    for (int i = 0; i < l; i++) {
      listofRamdomNo.add({'id': i, 'value': random.nextInt(100)});
    }
    update();
  }

  int generateRandomNumber(int i) {
    // int  c = i + ;
    int c = 0;
    listofRamdomNo.forEach((element) {
      if (element['id'] == i) {
        c = element['value'];
      }
    });
    return c;
  }

  void addhostdata() {
    if (hostselect.value.text != "0") {
      bool isAvailable = false;
      filterlist.forEach((element) {
        if (element == hostselect.value.text) {
          isAvailable = true;
          update();
        }
      });
      if (isAvailable == false) {
        filterlist.add(hostselect.value.text);
      } else {
        isAvailable = false;
        update();
      }
      update();
    }
  }

  void addGuestsdata() {
    if (guestselect.value.text != "0") {
      bool isAvailable = false;
      filterlist.forEach((element) {
        if (element == guestselect.value.text) {
          isAvailable = true;
          update();
        }
      });
      if (isAvailable == false) {
        filterlist.add(guestselect.value.text);
      } else {
        isAvailable = false;
        update();
      }
      update();
    }
  }

  void deleteData(String c) {
    for (int i = 0; i < channellist.length; i++) {
      if (channellist[i].name.toString() == c) {
        filterChannelList.removeWhere((element) => element == c);
        channellist[i].check.value = false;
        update();
      }
    }
    for (int i = 0; i < programType.length; i++) {
      if (programType[i].name.toString() == c) {
        filterProgramType.removeWhere((element) => element == c);
        programType[i].check.value = false;
        update();
      }
    }
  }

  String getTopicString(List segment) {
    List topic2 = [];
    List topic3 = [];

    String topic2string = "";
    String topic3string = "";

    String topic = "";

    //_.job[index]['segments'][0]['topics']['topic1']
    segment.forEach((element) {
      print('Segment is ${element['topics']['topic2']}');
      if (element['topics']['topic2'].toString().length != 2) {
        element['topics']['topic2'].forEach((q) {
          topic2.add(q);
        });
      }
      if (element['topics']['topic3'].toString().length != 2) {
        element['topics']['topic3'].forEach((qw) {
          topic3.add(qw);
        });
      }
      topic2.forEach((element) {});
    });

    if (topic2.isNotEmpty) {
      topic2string = topic2.join('-');
    }
    if (topic3.isNotEmpty) {
      topic3string = topic3.join('-');
    }
    if (topic2.isEmpty && topic3.isNotEmpty) {
      topic = topic3.join('-');
    }
    if (topic2.isNotEmpty && topic3.isEmpty) {
      topic = topic2.join('-');
    }
    if (topic2.isNotEmpty && topic3.isNotEmpty) {
      topic = "$topic2string | $topic3string";
    }
    if (topic2.isEmpty && topic3.isEmpty) {
      topic = '';
    }
    return topic;
  }

  String getGuestsString(List guest) {
    List allguest = [];
    guest.forEach((element) {
      allguest.add(element['name']);
    });
    return allguest.join(', ');
  }

  // FOR REad UnReAD

  bool escalations(List escalationsList) {
    bool isRead = false;
    var name = '${storage.read("firstName")} ${storage.read("lastName")}';
    escalationsList.forEach((e) {
      if (e['to'].toString().toLowerCase() == name.toLowerCase()) {
        print('Is Available');
        isRead = true;
      } else {
        isRead = false;
      }
    });
    return isRead;
  }

  // Future<void> jobStatus(String id) async {
  //   print('Job Function Call');

  //   String token = await storage.read("AccessToken");

  //   if (storage.hasData('Url') == true) {
  //     String url = storage.read("Url");
  //     var res = await http.post(
  //       Uri.parse(url + ApiData.escalationsread),
  //       // body: json.encode({'id': id}),
  //       body: {'id': id},
  //       headers: {
  //         'Authorization': "Bearer $token",
  //       },
  //     );

  //     print('Job Request is ${res.body}');
  //     await getFilterJobs(searchdata.value.text, 1);
  //     Get.to(
  //       () => PlayerScreen(),
  //       arguments: {
  //         "id": id,
  //       },
  //     );
  //   } else {
  //     var res = await http.post(
  //       Uri.parse(ApiData.baseUrl + ApiData.escalationsread),
  //       body: json.encode({'id': id}),
  //       headers: {
  //         'Authorization': "Bearer $token",
  //       },
  //     );

  //     print('Job Read Request is ${res.body}');
  //     await getFilterJobs(searchdata.value.text, 1);
  //     Get.to(
  //       () => PlayerScreen(),
  //       arguments: {
  //         "id": id,
  //       },
  //     );
  //   }
  // }

  String escalationsJob(List escalationsList) {
    String c = '';
    var name = '${storage.read("firstName")} ${storage.read("lastName")}';
    for (int i = 0; i < escalationsList.length; i++) {
      if (escalationsList[i]['to'].toString().toLowerCase() ==
          name.toLowerCase()) {
        print('Is Available read value check ${escalationsList[i]}');
        c = escalationsList[i]['read'].toString();
      }
    }
    return c;
  }

  Future<void> jobStatus(String id, String imageUrl) async {
    print('Job Function Call');

    String token = await storage.read("AccessToken");

    if (storage.hasData('Url') == true) {
      String url = storage.read("Url");
      var res = await http.post(
        Uri.parse(url + ApiData.escalationsread),
        // body: json.encode({'id': id}),
        body: {'id': id},
        headers: {
          'Authorization': "Bearer $token",
        },
      );

      print('Job Request is ${res.body}');
      await getFilterJobs(searchdata.value.text, 1);
      Get.to(
        () => PlayerScreen(),
        arguments: {"id": id},
      );
    } else {
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.escalationsread),
        body: {'id': id},
        headers: {
          'Authorization': "Bearer $token",
        },
      );
      print('Job Read Request is ${res.body}');
      await getFilterJobs(searchdata.value.text, 1);
      Get.to(
        () => PlayerScreen(),
        arguments: {"id": id},
      );
    }
  }

  String listToString(List c) {
    List g = [];
    for (int i = 0; i < c.length; i++) {
      g.add(c[i]);
    }
    // update();
    var channel = g.join(", ");
    // var guest = " ";
    return channel;
  }
}

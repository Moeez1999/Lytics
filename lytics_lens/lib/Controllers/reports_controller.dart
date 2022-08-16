import 'dart:convert';
import 'dart:io';

import 'package:change_case/change_case.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lytics_lens/Models/alltopicmodel.dart';
import 'package:lytics_lens/Models/channelmodel.dart';
import 'package:lytics_lens/Models/channelmodel2.dart';
import 'package:lytics_lens/Models/datesmodel.dart';
import 'package:lytics_lens/Models/datesmodel1.dart';
import 'package:lytics_lens/Models/programnamemodel.dart';
import 'package:lytics_lens/Models/programtypemodel.dart';
import 'package:lytics_lens/Models/programtypemodel1.dart';
import 'package:lytics_lens/Models/reprotHostModel.dart';
import 'package:lytics_lens/Models/simplechartmodel.dart';
import 'package:lytics_lens/Services/internetcheck.dart';
import 'package:lytics_lens/Views/graphs.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/utils/api.dart';

class ReportsController extends GetxController {
  bool isLoading = true;
  bool isPieChartData = true;

  bool isChartData = true;
  bool isSocket = false;
  bool isSocketFirstGraph1 = false;
  bool isSocketFirstGraph2 = false;
  bool isDefaultGraph = false;

  // List<PieChartSectionData> data = [];
  List<ChartSampleData> chartdata = [];

  List piechartlist = [];

  List graphData = [];
  List graphData1 = [];
  double total = 0.0;
  double? percentage;
  double total1 = 0.0;
  double? percentage1;

  late NetworkController networkController;

  // <------ For First time Graph Data ---------->

  List<String> allDropdownChannels = [];
  List allChanelsList = [];
  List allprogramList = [];

  List responseresult = [];
  List responseTopicresult = [];
  List responseTopic2result = [];
  List responseprogramtyperesult = [];
  List responsechannellist = [];
  List responseprogramlist = [];

  List<ReportHostModel> hostList = [];

  List programresult = [];
  List resprogramresult = [];
  List serachprogramresult = [];
  List allprogramresult = [];

  List<GraphData> dataValues = [];
  List graphchartlist = [];

  final storage = new GetStorage();

  TextEditingController searchController = TextEditingController();
  TextEditingController channelselect = TextEditingController();
  TextEditingController programselect = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  Rx<TextEditingController> hostselect = TextEditingController().obs;
  Rx<TextEditingController> hostselect1 = TextEditingController().obs;

  // List channels = [];
  List programTypesList = [];
  String channelSelected = "Geo News";
  List<dynamic> timeFrame = [];
  String timeFrameSelected = "Today";

  DateTime selectedDays = DateTime.now();

// <------------- Filer Data ------------------>

  var filterlist = [].obs;
  var filterlist1 = [].obs;

  List filterchannellist = [];

  List<ChannelModel> channellist = [];
  List<ChannelModel2> channellist2 = [];

  List<ChannelModel> channellist3 = [];
  List<ChannelModel2> channellist4 = [];

  List<ProgramNameModel> programslist = <ProgramNameModel>[].obs;

  // var programslist = [].obs;
  Rx<TextEditingController> programSelect = TextEditingController().obs;

  List channelsAll = [];

  List<ProgramTypeModel> programType = [];
  List<ProgramTypeModel1> programType1 = [];

  List programTypefilter = [];

  List programTypefilterdata = [];
  List selectprogramType = [];

  var filterHost = [].obs;
  List<String> anchorList = [];


  List anchorList1 = [];

  List allanchorList = [];
  List guestsList = [];

  List topiclist = [];
  List topic2list = [];
  List topic3list = [];
  List allData = [];
  List topic2allData = [];
  List<AllTopicModel> alltopic = [];

  List<String> selectedchannel = [];
  List<String> channellistonly = [];

  DateTime now = DateTime.now();
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
  DateTime week = DateTime.now().subtract(Duration(days: 7));
  DateTime quarter = DateTime.now().subtract(Duration(days: 15));

  List datelist = [];
  List<DatesModel> alldatelist = [];
  List<DatesModel1> alldatelist1 = [];

  // <---- Search data List ------------------->

  var channelsearchlist = [].obs;
  List programsearchlist = [];

  TextEditingController startSearchDate = TextEditingController();
  TextEditingController endSearchDate = TextEditingController();

  //<---------- PaiChart Filter ----------->

  List paichartchannel = [];
  List paichartprogramtype = [];
  List programtypegraph = [];

  String topTopics = 'Top 10';

  List paicharthost = [];
  TextEditingController startpaichartSearchDate = TextEditingController();
  TextEditingController endpaichartSearchDate = TextEditingController();

  @override
  void onInit() {
    if (Get.isRegistered<NetworkController>()) {
      networkController = Get.find<NetworkController>();
    } else {
      networkController = Get.put(NetworkController());
    }
    datelist = [
      {
        'id': 'Today',
        'name': 'Today',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${now.year}-${now.month}-${now.day}',
      },
      {
        'id': 'Yesterday',
        'name': 'Yesterday',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${yesterday.year}-${yesterday.month}-${yesterday.day}',
      },
      {
        'id': 'This Week',
        'name': 'This Week',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${week.year}-${week.month}-${week.day}',
      },
      {
        'id': 'This Month',
        'name': 'This Month',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': now.month - 1 == 0
            ? '${now.year - 1}-12-${now.day}'
            : '${now.year}-${now.month - 1}-${now.day}',
      },
      {
        'id': 'This Quarter',
        'name': 'This Quarter',
        'startDate': '${now.year}-${now.month}-${now.day}',
        'endDate': '${quarter.year}-${quarter.month}-${quarter.day}',
      },
    ];

    update();
    filterlist1.add('All Channels');
    filterlist.add('All channels');
    super.onInit();
  }

  @override
  void onReady() async {
    await getAllHost();
    await getChannels();
    await getProgram();
    await getProgramType();
    await getTopic();
    await firstTimeGraphData('Top 10');
    await firstTimePieChartData();
    selectedchannel.add('All Channels');

    getdates();

    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getdates() {
    datelist.forEach((element) {
      print("All Dates $element");
      alldatelist.add(DatesModel.fromJSON(element));
      alldatelist1.add(DatesModel1.fromJSON(element));
    });
    update();
  }

  void deleteData(String c) {
    if (c == 'All Channels') {
      // channelsearchlist.clear();
      // programsearchlist.clear();
      // programslist.clear();
      // filterlist1.removeWhere((element) => element == 'All Programs Name');
      // for (int i = 0; i < channellist2.length; i++) {
      //   if (channellist2[i].name == 'All Channels') {
      //     channellist2[i].check.value = false;
      //   }
      // }
      // filterlist1.removeWhere((element) => element == 'All Channels');
    } else if (c == 'All Programs Name') {
      programsearchlist.clear();
      for (int i = 0; i < programslist.length; i++) {
        if (programslist[i].name == 'All Programs Name') {
          programslist[i].check.value = false;
        }
      }
    } else {
      for (int i = 0; i < channellist2.length; i++) {
        channelsearchlist
            .removeWhere((element) => element == channellist2[i].name);
        if (channellist2[i].name.toString() == c) {
          channellist2[i].check.value = false;
          deleteSearchChannelProgram(channellist2[i].name!);
          // programslist.clear();
          programSelect.value.clear();
          update();
        }
      }
      for (int i = 0; i < programslist.length; i++) {
        if (programslist[i].name == c) {
          print('Program Value is True');
          programsearchlist.removeWhere((element) => element == c);
          update();
          programslist[i].check.value = false;
          print('Program Value is True ${programslist[i].check.value}');
        }
      }
      for (int i = 0; i < alldatelist1.length; i++) {
        print('Check For Date Function');
        if ('${alldatelist1[i].endDate.toString()} - ${alldatelist1[i].startDate.toString()}' ==
            c) {
          filterlist1.removeWhere((item) =>
              item ==
              '${alldatelist1[i].endDate.toString()} - ${alldatelist1[i].endDate.toString()}');
          alldatelist1[i].check.value = false;
          endSearchDate.clear();
          startSearchDate.clear();
          update();
        }
      }
    }
  }

  void deleteDataFilter(String c) {
    if (c == 'All Channels') {
      for (int i = 0; i < channellist.length; i++) {
        if (channellist[i].name == 'All Channels') {
          channellist[i].check.value = false;
        }
      }
      channelsearchlist.clear();
      programsearchlist.clear();
      programslist.clear();
      filterlist.removeWhere((element) => element == 'All Programs Name');
      filterlist.removeWhere((element) => element == 'All Channels');
    } else if (c == 'All Programs Name') {
      programsearchlist.clear();
    } else {
      for (int i = 0; i < channellist.length; i++) {
        if (channellist[i].name.toString() == c) {
          channellist[i].check.value = false;
          deleteSearchChannelProgram(channellist[i].name!);
          // programslist.clear();
          programSelect.value.clear();
          update();
        }
      }
      for (int i = 0; i < programslist.length; i++) {
        if (programslist[i].name == c) {
          print('Program Value is True');
          programsearchlist.removeWhere((element) => element == c);
          update();
          programslist[i].check.value = false;
          print('Program Value is True ${programslist[i].check.value}');
        }
      }
      for (int i = 0; i < alldatelist.length; i++) {
        print('Check For Date Function');
        if ('${alldatelist[i].endDate.toString()} - ${alldatelist[i].startDate.toString()}' ==
            c) {
          filterlist.removeWhere((item) =>
              item ==
              '${alldatelist[i].endDate.toString()} - ${alldatelist[i].endDate.toString()}');
          alldatelist[i].check.value = false;
          startpaichartSearchDate.clear();
          endpaichartSearchDate.clear();
          update();
        }
      }
    }
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
        paicharthost.add(hostselect.value.text);
        update();
      } else {
        isAvailable = false;
        update();
      }
      update();
    }
  }

  //< ------------ Get All Host -------------->

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
          hostList.add(ReportHostModel.fromJSON(element));
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
          hostList.add(ReportHostModel.fromJSON(element));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
    } catch (e) {

    }
  }

  // <------------- Get Program type ------------>

  Future<void> getProgramType() async {
    print('Program Type Function');
    responseprogramtyperesult.clear();
    responseprogramlist.clear();
    programType.clear();
    programType1.clear();
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
              programTypefilter.add(element['name']);
              programTypefilterdata
                  .add({'id': element['name'], 'name': element['name']});
            }
          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        update();
        responseprogramlist.forEach((element) {
          programType.add(ProgramTypeModel.fromJSON(element));
          programType1.add(ProgramTypeModel1.fromJSON(element));
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
          if(element['name'] == 'EE - Training' || element['name'] == 'UU - Training'){}
          else
            {
              responseprogramlist
                  .add({'id': element['name'], 'name': element['name']});
              programTypefilter.add(element['name']);
              programTypefilterdata
                  .add({'id': element['name'], 'name': element['name']});
            }

          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        update();
        responseprogramlist.forEach((element) {
          programType.add(ProgramTypeModel.fromJSON(element));
          programType1.add(ProgramTypeModel1.fromJSON(element));
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      isLoading = false;
      update();
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // <------------- Get Topic type ------------>

  Future<void> getTopic() async {
    print('Topic Function');
    responseTopicresult.clear();
    topiclist.clear();
    responseTopic2result.clear();
    topic2list.clear();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.get(Uri.parse(url + ApiData.topic), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        // log('Topic Response $response');
        responseTopicresult.addAll(response['results']);
        responseTopicresult.forEach((element) {
          topiclist.add(element['name']);
          responseTopic2result.add(element['topic2']);
          // responseprogramlist.add(element['name']);
          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        responseTopic2result.forEach((e) {
          topic2list.add({
            'id': e['name'],
            'name': e['name'],
          });
        });
        update();
        topic2list.forEach((element) {
          // programType.add(ProgramTypeModel.fromJSON(element));
        });
        update();
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.topic), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        // log('Topic Response $response');
        responseTopicresult.addAll(response['results']);
        responseTopicresult.forEach((element) {
          topiclist.add(element['name']);
          responseTopic2result.add(element['topic2']);
          // responseprogramlist.add(element['name']);
          // programTypesList.add({"id": element['name'], "name": element['name']});
        });
        responseTopic2result.forEach((e) {
          topic2list.add({
            'id': e['name'],
            'name': e['name'],
          });
        });
        update();
        topic2list.forEach((element) {
          // programType.add(ProgramTypeModel.fromJSON(element));
        });
        update();
      }
    } on SocketException catch (e) {
      isLoading = false;
      print(e);
      update();
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  //<-------------- Get Channels Name ---------->

  Future<void> getChannels() async {
    print('Channel Function');
    responsechannellist.clear();
    filterchannellist.clear();
    List reverse = [];
    // allChanelsList.clear();
    channelsAll.clear();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.get(Uri.parse(url + ApiData.channels), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print('Chanel Response $response');
        responseresult.addAll(response['results']);
        responseresult.forEach((element) {
          if(element['name'].toString().isLowerCase == 'all')
            {}
          else
            {
              responsechannellist.add(element['name']);
              filterchannellist.add(element['name']);
            }
        });
        update();
        channelsAll.add({'id': 'All Channels', 'name': 'All Channels'});
        channellistonly.add('All Channels');
        responsechannellist.forEach((e) {
          channellistonly.add(e);
          channelsearchlist.add(e);
          channelsAll.add({'id': e, 'name': e});
          allChanelsList.add(e);
          allDropdownChannels.add(e);
        });
        channelsAll.forEach((element) {
          channellist.add(ChannelModel.fromJSON(element));
          channellist2.add(ChannelModel2.fromJSON(element));
        });
        update();
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.channels), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        // log('Chanel Response $response');
        responseresult.addAll(response['results']);
        responseresult.forEach((element) {
          if(element['name'].toString().isLowerCase == 'all')
            {}
          else
            {
              responsechannellist.add(element['name']);
              filterchannellist.add(element['name']);
            }
        });
        reverse = responsechannellist.reversed.toList();
        channelsAll.add({'id': 'All Channels', 'name': 'All Channels'});
        channellistonly.add('All Channels');
        reverse.forEach((e) {
          allChanelsList.add(e);
          channelsearchlist.add(e);
          allDropdownChannels.add(e);
          channellistonly.add(e);
          channelsAll.add({'id': e, 'name': e});
        });

        channelsAll.forEach((element) {
          channellist.add(ChannelModel.fromJSON(element));
          channellist2.add(ChannelModel2.fromJSON(element));
        });
        channellist2.forEach((e) {
          if (e.name == "All Channels") {
            e.check.value = true;
          }
        });
        channellist.forEach((q) {
          if (q.name == "All Channels") {
            q.check.value = true;
          }
        });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      isLoading = false;
      update();

      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  // <------------ Get Program --------------->

  Future<void> getProgram() async {
    print('Program Function');
    allprogramresult.clear();
    allprogramList.clear();
    programslist.clear();
    List programlist = [];
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res =
            await http.get(Uri.parse(url + ApiData.programNames), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        print("Program res $response");
        programresult.addAll(response['results']);
        programresult.forEach((element) {
          allprogramresult.add(element['title']);
        });
        update();
        allprogramresult = Set.of(allprogramresult).toList();
        update();
        allprogramresult.forEach((element) {
          allprogramList.add(element);
          programlist.add({
            'id': '$element',
            'name': '$element',
          });
        });
        update();
        // programlist.forEach((element) {
        //   print('All Program is $element');
        //   programslist.add(element);
        //   // programslist.add(ProgramNameModel.fromJSON(element));
        // });
      } else {
        String token = await storage.read("AccessToken");
        var res = await http
            .get(Uri.parse(ApiData.baseUrl + ApiData.programNames), headers: {
          'Authorization': 'Bearer $token',
        });
        var response = json.decode(res.body);
        // log("Program res $response");
        programresult.addAll(response['results']);
        programresult.forEach((element) {
          allprogramresult.add(element['title']);
        });
        update();
        allprogramresult = Set.of(allprogramresult).toList();
        update();
        allprogramresult.forEach((element) {
          allprogramList.add(element);
          programlist.add({
            'id': '$element',
            'name': '$element',
          });
        });
        update();
        // programlist.forEach((element) {
        //   print('All Program is $element');
        //   programslist.add(element);
        //   // programslist.add(ProgramNameModel.fromJSON(element));
        // });
        update();
      }
    } on SocketException catch (e) {
      print(e);
      isLoading = false;
      update();

      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);
    } catch (e) {
      isLoading = false;
      update();
      // Get.snackbar("Catch Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  searchFunction(String channelname) {
    List plist = [];
    List sortplist = [];
    List allProgramName = [];
    print('Chennel Name is $channelname');
    // programslist.clear();
    if (channelname == 'All Channels') {
      programslist.clear();
      programsearchlist.clear();
      programresult.forEach((e) {
        sortplist.add(e['title']);
      });
      update();
      sortplist = Set.of(sortplist).toList();
      update();
      sortplist.forEach((element) {
        programsearchlist.add(element);
        plist.add({"id": element, "name": element});
      });
      update();
      allProgramName
          .add({"id": 'All Programs Name', "name": 'All Programs Name'});
      update();
      allProgramName.forEach((element) {
        programslist.add(ProgramNameModel.fromJSON(element));
      });
      // plist.forEach((element) {
      //   programslist.add(ProgramNameModel.fromJSON(element));
      // });
      programslist.forEach((element) {
        element.check.value = true;
      });
      update();
      filterlist1.add('All Programs Name');
    } else {
      programresult.forEach((e) {
        if (e['channel'].toString().contains(channelname)) {
          print('Programs Search data is ${e['title']}');
          sortplist.add(e['title']);
        }
        update();
      });
      update();
      sortplist = Set.of(sortplist).toList();
      update();
      sortplist.forEach((element) {
        programsearchlist.add(element);
        plist.add({"id": element, "name": element});
      });
      update();
      plist.forEach((element) {
        programslist.add(ProgramNameModel.fromJSON(element));
      });
    }
  }

  deleteSearchChannelProgram(String channelname) {
    print('Chennel Name is $channelname');
    // programslist.clear();
    update();
    programresult.forEach((e) {
      if (e['channel'].toString().contains(channelname)) {
        print('Programs Search data is Deleted ${e['title']}');
        programslist.removeWhere((item) => item.name == e['title']);
        filterlist1.removeWhere((item) => item == e['title']);
        // plist.add({"id": e['title'], "name": e['title']});
        // serachprogramresult.add(e["title"]);
      }
      update();
    });
  }

  // <------- Pai Chart Data ------------>

  Future<void> getPieChartData() async {
    isLoading = true;
    isSocketFirstGraph2 = false;
    chartdata.clear();
    piechartlist.clear();
    graphchartlist.clear();
    List selectedchannellist = [];
    List selectedprogramresult = [];
    selectedchannellist.add(channelselect.text);
    selectedprogramresult.add(programselect.text);
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.post(Uri.parse(url + ApiData.guestsgraph),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              "Accept": "application/json",
            },
            body: json.encode({
              "startDate": endpaichartSearchDate.text,
              "endDate": startpaichartSearchDate.text,
              "channel": paichartchannel,
              "programType": paichartprogramtype,
              "programName": [],
              "anchor": filterHost,
            }));
        var data1 = json.decode(res.body);
        piechartlist.addAll(data1);
        update();
        print("Check Data piechartlist $data1");
        // for (var i = 0; i < 5; i++) {
        //   chartdata.add(
        //     ChartSampleData(
        //         x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
        //   );
        //   // chartdata.add(PieChartSectionData(
        //   //     //title: piechartlist[i]['guest'],
        //   //     titleStyle: TextStyle(color: Colors.white),
        //   //     value: piechartlist[i]['count'].toDouble(),
        //   //     color: Color(0xff22B161)));
        // }
        for (var i = 0; i < 5; i++) {
          // chartdata.add(
          //   ChartSampleData(
          //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
          // );
          total1 += piechartlist[i]['count'];
          print("The total value after filter is $total1 ");

          // data.add(PieChartSectionData(
          //     //title: piechartlist[i]['guest'],
          //     titleStyle: TextStyle(color: Colors.white),
          //     value: piechartlist[i]['count'].toDouble(),
          //     color: Color(0xff22B161)));
        }
        for (var i = 0; i < 5; i++) {
          percentage1 = (piechartlist[i]['count'] * 100 / total1);
          update();
          print("The total after filter is  $percentage1 ");
          chartdata.add(
            ChartSampleData(
                x: piechartlist[i]['guest'],
                y: percentage1!.roundToDouble(),
                text: '${percentage!.roundToDouble()}% '),
          );
          // chartdata.add(percentage);
          // update();
        }

        isLoading = false;
        update();
      } else {
        String token = await storage.read("AccessToken");
        print("Bearer $token");
        print('Date is ${endpaichartSearchDate.text}');
        print('Date is ${startpaichartSearchDate.text}');
        var res =
            await http.post(Uri.parse(ApiData.baseUrl + ApiData.guestsgraph),
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-type': 'application/json',
                  "Accept": "application/json",
                },
                body: json.encode({
                  "startDate": endpaichartSearchDate.text,
                  "endDate": startpaichartSearchDate.text,
                  "channel": paichartchannel,
                  "programType": paichartprogramtype,
                  "programName": [],
                  "anchor": filterHost,
                }));
        var data1 = json.decode(res.body);
        piechartlist.addAll(data1);
        update();
        print("Check Data piechartlist $data1");
        if (piechartlist.length > 5) {
          // for (var i = 0; i < 5; i++) {
          //   chartdata.add(
          //     ChartSampleData(
          //         x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
          //   );
          //   // data.add(PieChartSectionData(
          //   //     //title: piechartlist[i]['guest'],
          //   //     titleStyle: TextStyle(color: Colors.white),
          //   //     value: piechartlist[i]['count'].toDouble(),
          //   //     color: Color(0xff22B161)));
          // }
          for (var i = 0; i < 5; i++) {
            // chartdata.add(
            //   ChartSampleData(
            //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
            // );
            total1 += piechartlist[i]['count'];
            print("The total value is after filter $total1 ");

            // data.add(PieChartSectionData(
            //     //title: piechartlist[i]['guest'],
            //     titleStyle: TextStyle(color: Colors.white),
            //     value: piechartlist[i]['count'].toDouble(),
            //     color: Color(0xff22B161)));
          }
          for (var i = 0; i < 5; i++) {
            percentage1 = (piechartlist[i]['count'] * 100 / total1);
            update();
            print("The total  $percentage1 ");
            chartdata.add(
              ChartSampleData(
                  x: piechartlist[i]['guest'], y: percentage1!.roundToDouble()),
            );
            // chartdata.add(percentage);
            // update();
          }
        } else {
          // for (var i = 0; i < piechartlist.length; i++) {
          //   chartdata.add(
          //     ChartSampleData(
          //         x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
          //   );
          //   // data.add(PieChartSectionData(
          //   //     //title: piechartlist[i]['guest'],
          //   //     titleStyle: TextStyle(color: Colors.white),
          //   //     value: piechartlist[i]['count'].toDouble(),
          //   //     color: Color(0xff22B161)));
          // }
          total1 = 0.0;
          for (var i = 0; i < piechartlist.length; i++) {
            print("data is of pie chart ${piechartlist[i]} ");
            // chartdata.add(
            //   ChartSampleData(
            //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
            // );
            total1 = total1 + piechartlist[i]['count'];
            print("The total value is after filter  $total1 ");

            // data.add(PieChartSectionData(
            //     //title: piechartlist[i]['guest'],
            //     titleStyle: TextStyle(color: Colors.white),
            //     value: piechartlist[i]['count'].toDouble(),
            //     color: Color(0xff22B161)));
          }
          for (var i = 0; i < piechartlist.length; i++) {
            percentage1 = (piechartlist[i]['count'] * 100 / total1);
            update();
            print("The total  $percentage1 ");
            chartdata.add(
              ChartSampleData(
                  x: piechartlist[i]['guest'], y: percentage1!.roundToDouble()),
            );
            // chartdata.add(percentage);
            // update();
          }
        }

        isLoading = false;
        update();
      }
    } on SocketException catch (e) {
      isSocketFirstGraph2 = true;
      isLoading = false;
      update();
      print(e);
    }
  }

  Future<void> firstTimePieChartData() async {
    isLoading = true;
    chartdata.clear();
    piechartlist.clear();
    graphchartlist.clear();
    List selectedchannellist = [];
    List selectedprogramresult = [];
    selectedchannellist.add(channelselect.text);
    selectedprogramresult.add(programselect.text);
    update();
    if (storage.hasData("Url") == true) {
      String url = storage.read("Url");
      String token = await storage.read("AccessToken");
      var res = await http.post(Uri.parse(url + ApiData.guestsgraph),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: json.encode({
            "endDate": '${now.year}-${now.month}-${now.day}',
            "startDate": now.month - 1 == 0
                ? '${now.year - 1}-12-${now.day}'
                : '${now.year}-${now.month - 1}-${now.day}',
            "channel": filterchannellist,
            "programType": programTypefilter,
            "programName": [],
            "anchor": anchorList,
          }));
      var data1 = json.decode(res.body);
      piechartlist.addAll(data1);
      print("The pie chart is $piechartlist");
      update();
      print("Check Data piechartlist $data1");
      for (var i = 0; i < 5; i++) {
        // chartdata.add(
        //   ChartSampleData(
        //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
        // );
        total += piechartlist[i]['count'];
        print("The total value is $total ");

        // data.add(PieChartSectionData(
        //     //title: piechartlist[i]['guest'],
        //     titleStyle: TextStyle(color: Colors.white),
        //     value: piechartlist[i]['count'].toDouble(),
        //     color: Color(0xff22B161)));
      }
      for (var i = 0; i < 5; i++) {
        percentage = (piechartlist[i]['count'] * 100 / total);
        update();
        print("The total  $percentage ");
        chartdata.add(
          ChartSampleData(x: piechartlist[i]['guest'], y: percentage),
        );
        // chartdata.add(percentage);
        // update();
      }

      isLoading = false;
      update();
    } else {
      String token = await storage.read("AccessToken");
      print("Bearer $token");
      print('Date is ${endpaichartSearchDate.text}');
      print('Date is ${startpaichartSearchDate.text}');
      var res =
          await http.post(Uri.parse(ApiData.baseUrl + ApiData.guestsgraph),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-type': 'application/json',
                "Accept": "application/json",
              },
              body: json.encode({
                "endDate": '${now.year}/${now.month}/${now.day}',
                "startDate": now.month - 1 == 0
                    ? '${now.year - 1}/12/${now.day}'
                    : '${now.year}/${now.month - 1}/${now.day}',
                "channel": filterchannellist,
                "programType": programTypefilter,
                "programName": [],
                "anchor": anchorList,
              }));

      var data1 = json.decode(res.body);
      Get.log('print All Map  for Graph is $data1');
      piechartlist.addAll(data1);
      update();
      print("Check Data piechartlist $data1");
      if (piechartlist.length >= 5) {
        for (var i = 0; i < 5; i++) {
          // chartdata.add(
          //   ChartSampleData(
          //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
          // );
          total += piechartlist[i]['count'];
          print("The total value is $total ");

          // data.add(
          //   PieChartSectionData(
          //       //title: piechartlist[i]['guest'],
          //       titleStyle: TextStyle(color: Colors.white),
          //       value: piechartlist[i]['count'].toDouble(),
          //       color: Color(0xff22B161)),
          // );
        }
        for (var i = 0; i < 5; i++) {
          percentage = (piechartlist[i]['count'] * 100 / total);
          update();
          print("The total  $percentage ");
          chartdata.add(
            ChartSampleData(
                x: piechartlist[i]['guest'], y: percentage!.roundToDouble()),
          );
          // chartdata.add(percentage);
          // update();
        }
      } else {
        for (var i = 0; i < piechartlist.length; i++) {
          // chartdata.add(
          //   ChartSampleData(
          //       x: piechartlist[i]['guest'], y: piechartlist[i]['count']),
          // );
          total += piechartlist[i]['count'];
          print("The total value is $total ");

          // data.add(
          //   PieChartSectionData(
          //       //title: piechartlist[i]['guest'],
          //       titleStyle: TextStyle(color: Colors.white),
          //       value: piechartlist[i]['count'].toDouble(),
          //       color: Color(0xff22B161)),
          // );
        }
        for (var i = 0; i < 5; i++) {
          percentage = piechartlist[i]['count'] * 100 / total;
          update();
          print("The total  $percentage ");
          chartdata.add(
            ChartSampleData(
                x: piechartlist[i]['guest'], y: percentage!.roundToDouble()),
          );
          // chartdata.add(percentage);
        }
      }
      isLoading = false;
      update();
    }
  }

  // <========== barChart =========>

  Future<void> firstTimeGraphData(String topicstop) async {
    print("First Time Graph");
    dataValues.clear();
    graphData.clear();
    graphchartlist.clear();
    isLoading = true;
    isDefaultGraph = false;
    update();
    List selectedchannellist = [];
    List selectedprogramresult = [];
    selectedchannellist.add(channelselect.text);
    selectedprogramresult.add(programselect.text);
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.post(Uri.parse(url + ApiData.media),
            headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              "endDate": '${now.year}-${now.month}-${now.day}',
              "startDate": now.month - 1 == 0
                  ? '${now.year - 1}-12-${now.day}'
                  : '${now.year}-${now.month - 1}-${now.day}',
              // "endDate": endSearchDate.text,
              "channel": allChanelsList,
              "programType": programTypefilter,
              "topics": [topicstop]
            }));
        var data1 = json.decode(res.body);
        graphchartlist.addAll(data1);
        update();
        for (int i = 0; i < graphchartlist.length; i++) {
          print('Graph Data is ${graphchartlist[i]}');
          search(graphchartlist[i]);
        }
        getAllData(topicstop);
        isLoading = false;
        update();
        // await getPieChartData();
        isLoading = false;
        update();
        print(data1);
      }
      else {
        isLoading = true;
        update();
        Get.log('CHeck ProgramTypes Data ${json.encode(programTypefilter)}');
        String token = await storage.read("AccessToken");
        var res = await http.post(
          Uri.parse(ApiData.baseUrl + ApiData.media),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode(
            {
              "endDate": '${now.year}-${now.month}-${now.day}',
              "startDate": now.month - 1 == 0
                  ? '${now.year - 1}-12-${now.day}'
                  : '${now.year}-${now.month - 1}-${now.day}',
              "channel": allChanelsList,
              "programType": programTypefilter,
              "topics": [topicstop]
            },
          ),
        );
        Get.log('ALl Graph data first time is ${json.encode({
              "endDate": '${now.year}-${now.month}-${now.day}',
              "startDate": now.month - 1 == 0
                  ? '${now.year - 1}-12-${now.day}'
                  : '${now.year}-${now.month - 1}-${now.day}',
              // "endDate": endSearchDate.text,
              "channel": allChanelsList,
              "programType": programTypefilter,
              "topics": [topicstop]
            })}');
        var data1 = json.decode(res.body);
        Get.log("1st time Graph data is Main Topics: $data1");
        graphchartlist.addAll(data1);
        graphData.clear();
        update();
        for (int i = 0; i < graphchartlist.length; i++) {
          // print('Graph Data is ${graphchartlist[i]}');
          search(graphchartlist[i]);
        }
        getAllData(topicstop);
        isLoading = false;
        update();
        // print(body.toString());
      }
    } on SocketException catch (e) {
      isLoading = false;
      isDefaultGraph = true;
      update();
      print(e.message.toString());
    } catch (e) {}
  }

  //search from map

  void search(Map a) {
    a.entries.forEach((element) {
      if (element.key == 'topic1') {
      } else {
        // print('All Sub Topic Data is${element.value}');
        graphData.add(element.value);
      }
    });
    update();
  }

  void getAllData(String trendingTopic) {
    // List check = [];

    graphData.sort((a, b) => (b['Count']).compareTo(a['Count']));
    //<------------- Unique ------------------>
    final jsonList = graphData.map((item) => jsonEncode(item)).toList();
    final uniqueJsonList = jsonList.toSet().toList();
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();

    print("Check Result of Graph is $result");
    for (int i = 0; i < result.length; i++) {
      print('All Sub Topic Data is ${result[i]}');
    }
    print('Topic Trending $trendingTopic');
    if (trendingTopic == 'Top 5') {
      if (result.length >= 5) {
        for (int i = 0; i < 5; i++) {
          print('Topic Trending 1 ${result[i]['name']}');
          dataValues.add(GraphData(
            "${result[i]['name']}",
            result[i]['Count'],
            charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
          ));
        }
      } else {
        for (int i = 0; i < result.length; i++) {
          dataValues.add(GraphData(
            "${result[i]['name']}",
            result[i]['Count'],
            charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
          ));
        }
      }
    }
    else {
      print("Total  Graph Length is ${result.length}");
      if (result.length >= 10) {
        for (int i = 0; i < 10; i++) {
          print("Check Trending Topic Data ${result[i]}");
          dataValues.add(GraphData(
            "${result[i]['name']}",
            result[i]['Count'],
            charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
          ));
        }
      } else {
        for (int i = 0; i < result.length; i++) {
          print("All Graph Name is ${result[i]['name']}");
          dataValues.add(GraphData(
            "${result[i]['name']}",
            result[i]['Count'],
            charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
          ));
        }
      }
    }
  }

  Future<void> getGraphData() async {
    print("check");
    dataValues.clear();
    graphchartlist.clear();
    graphData1.clear();
    isLoading = true;
    isSocketFirstGraph1 = false;
    update();
    update();
    List selectedchannellist = [];
    List selectedprogramresult = [];
    selectedchannellist.add(channelselect.text);
    selectedprogramresult.add(programselect.text);
    update();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        var res = await http.post(Uri.parse(url + ApiData.media),
            headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              "endDate": startSearchDate.text,
              "startDate": endSearchDate.text,
              // "endDate": endSearchDate.text,
              "channel": channelsearchlist,
              "programType": programtypegraph,
              "topics": ["Top 10"]
            }));
        var data1 = json.decode(res.body);
        graphchartlist.addAll(data1);
        update();

        for (int i = 0; i < graphchartlist.length; i++) {
          // print('Graph Data is ${graphchartlist[i]}');
          search1(graphchartlist[i]);
        }
        getAllData1();
        isLoading = false;
        update();
        // await getPieChartData();

      } else {
        isLoading = true;
        update();
        String token = await storage.read("AccessToken");
        var res = await http.post(Uri.parse(ApiData.baseUrl + ApiData.media),
            headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              'Authorization': 'Bearer $token',
            },
            body: json.encode({
              "endDate": startSearchDate.text,
              "startDate": endSearchDate.text,
              "channel": channelsearchlist,
              "programType": programtypegraph,
              "topics": ["Top 10"]
            }));
        print('ALl Graph data is ${json.encode({
              "startDate": startSearchDate.text,
              "endDate": endSearchDate.text,
              "channel": channelsearchlist,
              "programType": programtypegraph,
              "topics": ["Top 10"]
            })}');
        var data1 = json.decode(res.body);
        print("Graph data is Main Topics: $data1");
        graphchartlist.addAll(data1);
        update();
        for (int i = 0; i < graphchartlist.length; i++) {
          search1(graphchartlist[i]);
        }
        getAllData1();
        isLoading = false;
        update();
        // print(body.toString());

      }
    } on SocketException catch (e) {
      isLoading = false;
      isSocketFirstGraph1 = true;
      update();
      print(e.message.toString());
    } catch (e) {}
  }

  void search1(Map a) {
    a.entries.forEach((element) {
      if (element.key == 'topic1') {
      } else {
        graphData1.add(element.value);
      }
    });
    update();
  }

  void getAllData1() {
    graphData1.sort((a, b) => (b['Count']).compareTo(a['Count']));
    final jsonList = graphData1.map((item) => jsonEncode(item)).toList();
    final uniqueJsonList = jsonList.toSet().toList();
    final result1 = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    for (int i = 0; i < result1.length; i++) {
      print('All Sub Topic Data is ${result1[i]}');
    }
    if (result1.length >= 10) {
      for (int i = 0; i < 10; i++) {
        dataValues.add(GraphData(
          "${result1[i]['name']}",
          result1[i]['Count'],
          charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
        ));
      }
    } else {
      for (int i = 0; i < result1.length; i++) {
        dataValues.add(GraphData(
          "${result1[i]['name']}",
          result1[i]['Count'],
          charts.ColorUtil.fromDartColor(Color(0xFF48beeb)),
        ));
      }
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

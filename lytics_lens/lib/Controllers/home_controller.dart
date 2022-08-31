import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lytics_lens/Constants/constants.dart';
import 'package:lytics_lens/Controllers/account_controller.dart';
import 'package:lytics_lens/Controllers/playerController.dart';
import 'package:lytics_lens/Models/jobsmodel.dart';
import 'package:http/http.dart' as http;
import 'package:lytics_lens/utils/api.dart';
import 'package:lytics_lens/views/player_Screen.dart';

class HomeScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final controller = Get.put(AccountController());

  var isLoading = true.obs;
  var isLoading1 = true.obs;
  var isSendLoading = true.obs;

  String id = '';

  var isAvailable = false.obs;
  var isRead = false.obs;

  var isMore = false.obs;
  var isSearchData = false.obs;

  var isDataFailed = false.obs;

  var isSocketError = false.obs;

  int totalPages = 0;

  // late NetworkController networkController;

  DateTime now = DateTime.now();
  DateTime sixmonth = DateTime.now().subtract(Duration(days: 3));

  var random = new Random();

  final storage = new GetStorage();

  List<String> headLines = [];

  var pageno = 1.obs;
  var tpageno = 1.obs;

  var job = [].obs;
  var searchjob = [].obs;
  var sentjob = [].obs;

  var receivedJobsList = [].obs;

  var escalation = <dynamic>[].obs;
  var hashtags = [];

  int i = 0;

  List<Jobs> jobslist = [];
  List s = [];
  List sourceOfInformation = [
    "Online video",
    "Web",
    "Social Media",
    "TV",
    "Print"
  ];

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    id = await storage.read('id');
    FlutterAppBadger.removeBadge();
    await getReceiveJob();
    await getSentJobs();
    await getJobs(pageno.value);
    await sendDeviceToken();

    update();

    isLoading.value = false;
    isLoading1.value = false;
    isSendLoading.value = false;
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Widget infoContainer(String imagePath, title) {
    return Row(
      children: [
        Image.asset(imagePath),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
        )
      ],
    );
  }

  Widget showSourceOfInfoContainer() {
    List<Widget> g = [];

    for (int i = 0; i < sourceOfInformation.length; i++) {
      g.add(FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.fill,
        child: Container(
          height: 27,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: sourceOfInformation[i] == 'Online video'
                  ? Color(0xffFD8894)
                  : sourceOfInformation[i] == 'TV'
                      ? Color(0xff33C6B0)
                      : sourceOfInformation[i] == 'Web'
                          ? Color(0xffFFD76F)
                          : sourceOfInformation[i] == 'Print'
                              ? Color(0xffB48AE8)
                              : Color(0xffF26A32),
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              "${sourceOfInformation[i]}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: sourceOfInformation[i] == 'Online video'
                    ? Color(0xffFD8894)
                    : sourceOfInformation[i] == 'TV'
                        ? Color(0xff33C6B0)
                        : sourceOfInformation[i] == 'Web'
                            ? Color(0xffFFD76F)
                            : sourceOfInformation[i] == 'Print'
                                ? Color(0xffB48AE8)
                                : Color(0xffF26A32),
              ),
            ).marginOnly(left: 15.0, right: 15.0),
          ),
        ),
      ).marginOnly(top: 15, left: 8, right: 8));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.center,
      children: g,
    );
  }

  //  For Notification

  Future<void> sendDeviceToken() async {
    print('check Send Device Token');
    print('Token ${Constants.token}');
    String token = await storage.read("AccessToken");
    if (storage.hasData("Url") == true) {
      String url = storage.read("Url");
      String id = await storage.read('id');
      print('User Id $id');
      var res = await http.post(Uri.parse(url + ApiData.deviceToken),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
          body: json.encode({
            "userId": id,
            "deviceToken": Constants.token,
            "addToken": "true",
          }));
      var data = json.decode(res.body);
      print("response of device token api" + res.statusCode.toString());
      print("response of device token api" + data.toString());
    } else {
      String id = await storage.read('id');
      var res = await http.post(
        Uri.parse(ApiData.baseUrl + ApiData.deviceToken),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-type": 'application/json',
        },
        body: json.encode({
          "userId": id,
          "deviceToken": Constants.token,
          "addToken": "true",
        }),
      );
      var data = json.decode(res.body);
      print("response of device token api" + data.toString());
    }
  }

  searchFunction(String v) {
    if (v.isEmpty || v == '') {
      searchjob.clear();
    } else {
      searchjob.clear();
      job.forEach((e) {
        if (e['programName']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchjob.add(e);
        } else if (e['anchor']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchjob.add(e);
        } else if (e['segments']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchjob.add(e);
        } else if (e['segments'][0]['topics']['topic1']
            .toString()
            .toLowerCase()
            .contains(v.toLowerCase())) {
          searchjob.add(e);
        }
        update();
      });
      if (searchjob.length == 0) {
        isSearchData.value = true;
        print("is CHeck Data ${searchjob.length}");
      } else {
        isSearchData.value = false;
        print("is CHeck Data else ${searchjob.length}");
      }
      // searchjob.forEach((element) {
      //   print("check Data $element");
      // });
    }
  }

  List<int> indexAdress = [];

  Future<void> getJobs(int p) async {
    print("Page No is $p");
    try {
      isSocketError.value = false;
      isDataFailed.value = false;
      // update();
      if (storage.hasData("Url") == true) {
        if (p == 1) {
          isLoading.value = true;
          job.clear();
          tpageno.value = 1;
          print("Page No is $p");
          String url = storage.read("Url");
          String token = await storage.read("AccessToken");
          String id = await storage.read('id');
          print('User Id $id');
          print("Bearer $token");
          var res = await http.get(
            Uri.parse(
                '$url${ApiData.jobs}?start_date=${sixmonth.year}/${sixmonth.month}/${sixmonth.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&device=mobile&escalation=$id'),
            headers: {
              'Authorization': 'Bearer $token',
              "Content-type": 'application/json',
            },
          );
          print('Home Api ${res.body}');
          var data = json.decode(res.body);
          if (p == 1) {
            totalPages = data['totalPages'];
            update();
          }
          print('Total Pages ${data['totalPages']}');
          print('Total Pages ${tpageno.value}');
          job.addAll(data['results']);
          isLoading.value = false;
        } else {
          if (tpageno.value <= totalPages) {
            isMore.value = true;
            // update();
            print("Page No is $p");
            String url = storage.read("Url");
            String token = await storage.read("AccessToken");
            String id = await storage.read('id');
            print('User Id $id');
            print("Bearer $token");
            var res = await http.get(
              Uri.parse(
                  '$url${ApiData.jobs}?start_date=${sixmonth.year}/${sixmonth.month}/${sixmonth.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&device=mobile&escalation=$id'),
              headers: {
                'Authorization': 'Bearer $token',
                "Content-type": 'application/json',
              },
            );

            print('Home Api ${res.body}');
            var data = json.decode(res.body);

            print('Total Pages ${data['totalPages']}');
            print('Total Pages ${tpageno.value}');
            job.addAll(data['results']);
            isMore.value = false;
          } else {
            isMore.value = false;
            print('Result Not Found');
          }
        }
      } else {
        String id = await storage.read('id');
        print("User Id is $id");
        String token = await storage.read("AccessToken");
        print("Bearer $token");
        if (p == 1) {
          isLoading.value = true;
          job.clear();
          update();
          tpageno.value = 1;
          print("Page No is $p");
          String token = await storage.read("AccessToken");
          print("Bearer $token");
          var res = await http.get(
            Uri.parse(
                '${ApiData.baseUrl}${ApiData.jobs}?start_date=${sixmonth.year}/${sixmonth.month}/${sixmonth.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&device=mobile&escalation=$id'),
            headers: {
              'Authorization': 'Bearer $token',
              "Content-type": 'application/json',
            },
          );
          var data = json.decode(res.body);
          Get.log('Home Api $data');
          if (p == 1) {
            totalPages = data['totalPages'];
            update();
          }
          print('Total Pages ${data['totalPages']}');
          print('Total Pages ${tpageno.value}');
          job.addAll(data['results']);
          // job.assignAll(List.from(job.reversed));
          // job.toList().sort((b ,a) => b['programDate'].compareTo(a))
          // job.sort((a,b) => a['programDate'].compareTo(b['programDate']));
          isLoading.value = false;
        } else {
          if (tpageno.value <= totalPages) {
            isMore.value = true;
            // update();
            print("Page No is $p");
            String token = await storage.read("AccessToken");
            print("Bearer $token");
            var res = await http.get(
              Uri.parse(
                  '${ApiData.baseUrl}${ApiData.jobs}?start_date=${sixmonth.year}/${sixmonth.month}/${sixmonth.day}&end_date=${now.year}/${now.month}/${now.day}&limit=30&page=$p&source=All&device=mobile&escalation=$id'),
              headers: {
                'Authorization': 'Bearer $token',
                "Content-type": 'application/json',
              },
            );
            print('Home Api ${res.body}');
            var data = json.decode(res.body);
            if (p == 1) {
              totalPages = data['totalPages'];
              update();
            }
            print('Total Pages ${data['totalPages']}');
            // job.assignAll(List.from(job.reversed));
            job.addAll(data['results']);
            // job.assignAll(List.from(job.reversed));
            isMore.value = false;
          } else {
            isMore.value = false;
            print('Result Not Found');
          }
        }
      }
    } on SocketException catch (e) {
      print(e);
      isLoading.value = false;
      isSocketError.value = true;
    } catch (e) {
      isLoading.value = false;
      isDataFailed.value = true;
    }
  }

  Future<void> getSentJobs() async {
    sentjob.clear();
    try {
      isSocketError.value = false;
      isDataFailed.value = false;
      isSendLoading.value = true;
      // receivedJobsList.clear();
      // update();
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        String id = await storage.read('id');
        var res = await http.get(
          Uri.parse('$url${ApiData.shareJobs}' + id),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
        );
        var data = json.decode(res.body);
        sentjob.addAll(data);
        isSendLoading.value = false;
        // await getJobs(pageno.value);
      } else {
        String id = await storage.read('id');
        String token = await storage.read("AccessToken");
        var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.shareJobs + id),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
        );
        var data = json.decode(res.body);
        // Get.log("Check ALL Shared Data ${res.body}");
        sentjob.addAll(data);
        isSendLoading.value = false;
        // await getJobs(pageno.value);
      }
    } on SocketException catch (e) {
      print(e);
      isSendLoading.value = false;
      isSocketError.value = true;
      // CustomSnackBar.showSnackBar(
      //     title: AppStrings.unable,
      //     message: "",
      //     backgroundColor: Color(0xff48beeb),
      //     isWarning: true);

    } catch (e) {
      isSendLoading.value = false;
      isDataFailed.value = true;

      print(e.toString());
      // Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> getReceiveJob() async {
    isLoading1.value = true;
    receivedJobsList.clear();
    try {
      if (storage.hasData("Url") == true) {
        String url = storage.read("Url");
        String token = await storage.read("AccessToken");
        String id = await storage.read('id');
        var res = await http.get(
          Uri.parse(url + ApiData.receiveJobs + id),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
        );
        var data = json.decode(res.body);
        // Get.log("Receiver Jobs $data");
        receivedJobsList.addAll(data);
        isLoading1.value = false;
      } else {
        String token = await storage.read("AccessToken");
        String id = await storage.read('id');
        print("User Id is $id");
        var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.receiveJobs + id),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-type": 'application/json',
          },
        );
        var data = json.decode(res.body);
        // Get.log("Receiver Jobs $data");
        receivedJobsList.addAll(data);
        isLoading1.value = false;
      }
    } on SocketException catch (e) {
      print(e);
      isLoading1.value = false;
      isSocketError.value = true;
    } catch (e) {
      isLoading1.value = false;
      isDataFailed.value = true;
    }
  }

  void reset() {
    searchController.text = '';
    update();
    // getJobs(1);
  }

  int searchForNews(String _data) {
    bool match = false;
    for (int i = 0; i < headLines.length; i++) {
      if (headLines[i].contains(_data.toUpperCase())) {
        indexAdress.add(i);
        match = true;
        break;
      }
    }
    match ? print("Matched") : print("Not matched");
    return indexAdress.length;
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

  int generateRandomNumber(int i) {
    // int  c = i + ;

    i++;
    int mul = i * 40;
    if (mul > 100) {
      mul = i * 10;
      return mul;
    } else {
      return mul;
    }
  }

  String getTopicString(List segment) {
    List topic2 = [];
    List topic3 = [];

    String topic2string = "";
    String topic3string = "";

    String topic = "";
    // Get.log('Segments $segment');
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

  String getSharePerson(List r) {
    print("True data Reciver $r");
    List rec = [];
    for (int i = 0; i < r.length; i++) {
      if (id == r[i]['recieverId']) {
        rec.add('${r[i]['senderFirstName']} ${r[i]['senderLastName']}');
      }
    }
    print("The data of reviever api is ${rec.toString()}");
    return rec.join(', ');
  }

  String getReceivedPerson(List r) {
    print("True data  $r");
    List sen = [];
    for (int i = 0; i < r.length; i++) {
      if (id == r[i]['senderId']) {
        sen.add('${r[i]['recieverFirstName']} ${r[i]['recieverLastName']}');
      }
    }
    print("The data of Sender api is ${sen.toString()}");
    return sen.join(', ');
  }

  Future<void> getSingleJob(String jobId) async {
    isLoading.value = true;
    String token = await storage.read("AccessToken");
    print("Bearer $token");
    print("Bearer $jobId");
    if (storage.hasData('Url') == true) {
     
      String url = storage.read("Url");
      var res =
          await http.get(Uri.parse(url + ApiData.singleJob + jobId), headers: {
        'Authorization': "Bearer $token",
      });
      var data = json.decode(res.body);
      // Get.log('Check Data $data');

      data['escalations'].forEach((e) {
        escalation.add(e);
      });
      await checkEscalation(data, jobId);
    } else {
      var res = await http.get(
          Uri.parse(ApiData.baseUrl + ApiData.singleJob + jobId),
          headers: {
            'Authorization': "Bearer $token",
          });
      var data = json.decode(res.body);
      // Get.log('Check Data $data');

      data['escalations'].forEach((e) {
        escalation.add(e);
      });
      await checkEscalation(data, jobId);
    }
  }

  Future<void> checkEscalation(Map jobMap, String id) async {
    String token = await storage.read("AccessToken");
    s.clear();
    update();
    // Get.log('check $c');

    var name = '${storage.read("firstName")} ${storage.read("lastName")}';
    print('CHekc Name $name');
    escalation.forEach((e) {
      print('Escalation job for usser $e');
      if (e['to'].toString().toLowerCase() == name.toLowerCase()) {
        print('Is Available');
        isAvailable.value = true;
      } else {
        s.add(e);
      }
    });
    update();
    s.forEach((element) {
      print('Check Job Escalation $element');
    });

    if (storage.hasData('Url') == true) {
      String url = storage.read("Url");
      var res = await http.patch(
        Uri.parse(url + ApiData.singleJob + id),
        body: {'escalations': json.encode(s), 'device': 'mobile'},
        headers: {
          'Authorization': "Bearer $token",
        },
      );

      print('Job Request is ${res.body}');
      tpageno.value = 1;
      // await receivedJobsList();
      await getJobs(1);
    } else {
      var res = await http.patch(
        Uri.parse(ApiData.baseUrl + ApiData.singleJob + id),
        body: {'escalations': json.encode(s), 'device': 'mobile'},
        headers: {
          'Authorization': "Bearer $token",
        },
      );
      print('Job Request is ${res.body}');
      tpageno.value = 1;
      // await receivedJobsList();
      await getJobs(1);
    }
  }

  String escalationsJob(List escalationsList) {
    String c = '';
    var name = '${storage.read("id")} ${storage.read("lastName")}';
    for (int i = 0; i < escalationsList.length; i++) {
      if (escalationsList[i]['to'].toString().toLowerCase() ==
          name.toLowerCase()) {
        print('Is Available read value check ${escalationsList[i]}');
        c = escalationsList[i]['read'].toString();
      }
    }
    return c;
  }

  Future<void> getDeleteJob(List sharingId, String Jobid) async {
    print("List of Sharing $sharingId");
    print("JobId of Sharing $Jobid");
    isSendLoading.value = true;
    String token = await storage.read("AccessToken");
    try {
      if (storage.hasData('Url') == true) {
        String url = storage.read("Url");
        for (int i = 0; i < sharingId.length; i++) {
          await http.patch(
            Uri.parse(url + ApiData.deleteSharedJob + sharingId[i]['_id']),
            headers: {
              'Authorization': "Bearer $token",
            },
          );
        }
        await getSentJobs();
        isSendLoading.value = false;
      } else {
        for (int i = 0; i < sharingId.length; i++) {
          print("Job Type Id is ${sharingId[i]['_id']}");
          var d = await http.patch(
            Uri.parse(ApiData.baseUrl +
                ApiData.deleteSharedJob +
                sharingId[i]['_id']),
            headers: {
              'Authorization': "Bearer $token",
            },
          );
          print("Check Data is delete${d.body}");
        }
        await getSentJobs();
        isSendLoading.value = false;
      }
    } catch (e) {
      isSendLoading.value = false;
    }
  }

  Future<void> jobStatus(String id) async {
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
      await getJobs(1);
      // await receivedJobsList();
      Get.delete<VideoController>();
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
      await getJobs(1);
      // await receivedJobsList();
      Get.delete<VideoController>();
      Get.to(
        () => PlayerScreen(),
        arguments: {"id": id},
      );
    }
  }
}

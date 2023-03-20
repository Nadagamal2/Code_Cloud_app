import 'dart:convert';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

 import '../components/app_style.dart';
import '../components/component.dart';
import '../models/getAllCategory_model.dart';
 import '../models/search.dart';
import '../translations/locale_keys.g.dart';
import 'noon_ticket.dart';

class search extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';

          },
          icon: Icon(Icons.close))
    ];
  }
  @override
  String get searchFieldLabel =>LocaleKeys.Search_for_specific_store.tr();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          toolbarHeight: 65.h,
          color: Colors.grey,
          elevation: 0

      ),
      textSelectionTheme: TextSelectionThemeData(

          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white),

      inputDecorationTheme: InputDecorationTheme(


        hintStyle: TextStyle(
          color: Colors.white,
        ),
        isDense: true,
        contentPadding:
        EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 7.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  List data = [];
  List<CategoryIdallSearchModel> result = [];
  Future<List<CategoryIdallSearchModel>?> catidSearch({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":query}));
      var dataa = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data=dataa['records'];
         result=data.map((e) => CategoryIdallSearchModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
              query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        print('dataId==${data}');
        print('result==${result}');
      } else {
        print("Faild");
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }
  void getDataId({required dynamic id}) async{

    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/Get_Store_byId/${id}'),
          body: jsonEncode({"id": id}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  bool isTapped2 = true;
  bool isTapped3 = true;
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder <List<CategoryIdallSearchModel>?>(
      future: catidSearch(query: query),
      builder: (context, snapshot){

        if (snapshot.hasData) {
          List<CategoryIdallSearchModel>? item = snapshot.data;
          return SizedBox(
            height: 600.h,
            child: ListView.separated(
              padding: EdgeInsets.all(5.h),
              itemCount: item!.length,
              itemBuilder: (context, index) =>
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: InkWell(
                          onTap: () {
                            // Get.to(NoonTicketScreen(img:    CircleAvatar(
                            //   backgroundImage: NetworkImage(
                            //     'http://eibtek2-001-site5.atempurl.com/${item![index].imgUrl}',
                            //
                            //   ),
                            //   backgroundColor: Colors.transparent,
                            //
                            //   radius: 50.r,
                            // ),storePhone: '${item![index].phoneNumber}',
                            //   storeName: '${item![index].title}',
                            //   storeOffer: ' ${item![index].offer}', storeDetails: ' ${item![index].details}',
                            //   storelink: (){
                            //     _launchUrl('${item![index].link}');
                            //
                            //   }, storeCode: '${item![index].saleCode}', isFavorite: item[index].isFaviourite!, isSpecial: item[index].isSpecial!,
                            // ));
                            userData.write('storeId',item![index].id);
                            print(item![index].id);

                            // Get.to(NoonTicketScreen(img:    CircleAvatar(
                            //   backgroundImage: NetworkImage(
                            //     'http://eibtek2-001-site5.atempurl.com/${e.storImgUrl}',
                            //
                            //   ),
                            //   backgroundColor: Colors.transparent,
                            //
                            //   radius: 40.r,
                            // ),
                            //   storeName: '${e.storTitle}',
                            //   storeOffer: ' ${e.storOffer}', storeDetails: ' ${e.storDeteils}',
                            //   storelink: (){
                            //     _launchUrl('${e.storLink}');
                            //
                            //   }, storePhone: '${e.storPhoneNumber}', storeCode: '${e.storSaleCode}',
                            // ));
                            userData.write('storeId', item![index].id);
                            print(item![index].id);

                            Get.to(NoonTicketScreen(img:    CircleAvatar(
                              backgroundImage: NetworkImage(
                                'http://saudi07-001-site2.itempurl.com/${item[index].imgUrl}',

                              ),
                              backgroundColor: Colors.transparent,

                              radius: 50.r,
                            ),
                              storeName: '${item[index].title}',
                              storeOffer: ' ${item[index].offer}', storeDetails: ' ${item[index].details}',
                              storelink: (){
                                _launchUrl('${item[index].link}');

                              }, storePhone: '${item[index].phoneNumber}', storeCode: '${item[index].saleCode}', storeCountry: '${item[index].country!.name}',
                            ));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 90.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 13,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],

                                ),
                                child: Column(

                                  children: [

                                    CouponCard(
                                      height: 90.h,
                                      backgroundColor: Colors.transparent,
                                      clockwise: true,
                                      curvePosition: 110,
                                      curveRadius: 25,
                                      curveAxis: Axis.vertical,
                                      borderRadius: 10,
                                      firstChild: Container(
                                        alignment: Alignment.center,
                                        decoration:   BoxDecoration(
                                            color: Colors.white,

                                            image: DecorationImage(

                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'http://saudi07-001-site2.itempurl.com/${item[index].imgUrl}'
                                                )
                                            )
                                        ),

                                      ),
                                      secondChild: Container(
                                        alignment: Alignment.centerLeft,
                                        width: double.maxFinite,
                                        padding:   EdgeInsets.all(18.h),
                                        decoration:   BoxDecoration(

                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item[index].title}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(height: 4.h),
                                            Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                width: 100.h,
                                                child: Text(
                                                  '${LocaleKeys.Offer} :${item[index].offer}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    )



                                  ],
                                ),
                              ),
                              Gap(20.h)
                            ],
                          ),
                        ),
                      ),
                      Gap(0.h),


                    ],
                  ),
              separatorBuilder: (BuildContext context, int index) {
                return Gap(0.h);
              },

            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  final userData =GetStorage();
  Future<CategoryIdallModel?> catid({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://saudi07-001-site2.itempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":''}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdallModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }

  void Favorite(

      ) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('http://saudi07-001-site2.itempurl.com/api/CreateUser_Faviourites'));
      request.body = json.encode({
        "userId":'${userData.read('token')}',
        "storeId": '${userData.read('storeId')}',
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e.toString());
    }
  }
  double rating=0;
  Set<String> savedWords = Set<String>();

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder (
      future: catid(),
      builder: (context, snapshot){


        if (snapshot.hasData) {
          return SizedBox(
            height: 600.h,
            child: ListView.separated(
              padding: EdgeInsets.all(5.h),
              itemCount: snapshot.data!.records!.length,
              itemBuilder: (context, index) =>
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: InkWell(
                          onTap: () {

                            //
                            // Get.to(NoonTicketScreen(img:    CircleAvatar(
                            //   backgroundImage: NetworkImage(
                            //     'http://eibtek2-001-site5.atempurl.com/${snapshot.data!.records![index].storImgUrl}',
                            //
                            //   ),
                            //   backgroundColor: Colors.transparent,
                            //
                            //   radius: 50.r,
                            // ),
                            //   storePhone: '${snapshot.data!.records![index].storPhoneNumber}',
                            //   storeName: '${snapshot.data!.records![index].storTitle}',
                            //   storeOffer: ' ${snapshot.data!.records![index].storOffer}', storeDetails: ' ${snapshot.data!.records![index].storDeteils}',
                            //   storelink: (){
                            //     _launchUrl('${snapshot.data!.records![index].storLink}');
                            //
                            //   }, storeCode: '${snapshot.data!.records![index].storSaleCode}', isFavorite: snapshot.data!.records![index].isFaviourite!, isSpecial: snapshot.data!.records![index].isSpecial!,
                            // ));
                            // userData.write('deleteId', snapshot.data!.records![index].userFaviourites![index].id);
                            userData.write('storeId', snapshot.data!.records![index].id);
                            print(snapshot.data!.records![index].id);

                            userData.write('storeId', snapshot.data!.records![index].id);
                            print(snapshot.data!.records![index].id);

                            Get.to(NoonTicketScreen(img:    CircleAvatar(
                              backgroundImage: NetworkImage(
                                'http://saudi07-001-site2.itempurl.com/${snapshot.data!.records![index].storImgUrl}',

                              ),
                              backgroundColor: Colors.transparent,

                              radius: 50.r,
                            ),
                              storeName: '${snapshot.data!.records![index].storTitle}',
                              storeOffer: ' ${snapshot.data!.records![index].storOffer}', storeDetails: ' ${snapshot.data!.records![index].storDeteils}',
                              storelink: (){
                                _launchUrl('${snapshot.data!.records![index].storLink}');

                              }, storePhone: '${snapshot.data!.records![index].storPhoneNumber}', storeCode: '${snapshot.data!.records![index].storSaleCode}', storeCountry: '${snapshot.data!.records![index].countries!.contName}',
                            ));
                          },
                          child:  Column(
                            children: [
                              Container(
                                height: 90.h,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 13,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],

                                ),
                                child: Column(

                                  children: [

                                    CouponCard(
                                      height: 90.h,
                                      backgroundColor: Colors.transparent,
                                      clockwise: true,
                                      curvePosition: 110,
                                      curveRadius: 25,
                                      curveAxis: Axis.vertical,
                                      borderRadius: 10,
                                      firstChild: Container(
                                        alignment: Alignment.center,
                                        decoration:   BoxDecoration(
                                            color: Colors.white,

                                            image: DecorationImage(

                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'http://saudi07-001-site2.itempurl.com/${snapshot.data!.records![index].storImgUrl}'
                                                )
                                            )
                                        ),

                                      ),
                                      secondChild: Container(
                                        alignment: Alignment.centerLeft,
                                        width: double.maxFinite,
                                        padding:   EdgeInsets.all(18.h),
                                        decoration:   BoxDecoration(

                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${ snapshot.data!.records![index].storTitle}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            SizedBox(height: 4.h),
                                            Expanded(
                                              flex: 4,
                                              child: SizedBox(
                                                width: 100.h,
                                                child: Text(
                                                  '${LocaleKeys.Offer} :${snapshot.data!.records![index].storOffer}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                    )



                                  ],
                                ),
                              ),
                              Gap(20.h)
                            ],
                          ),
                        ),
                      ),
                      Gap(0.h),


                    ],
                  ),
              separatorBuilder: (BuildContext context, int index) {
                return Gap(0.h);
              },

            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
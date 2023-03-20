import 'dart:convert';

import 'package:copons/components/app_style.dart';
import 'package:copons/screens/login_screen.dart';
import 'package:copons/screens/subscribe_screeen.dart';
import 'package:copons/translations/locale_keys.g.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/SubscriptionModel.dart';
import 'noon_ticket.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {

  final userData =GetStorage();
  Future<SubscriptionModel> getData() async {
    final response = await http.get(
        Uri.parse('http://saudi07-001-site2.itempurl.com/api/GetAll_Subscriptions'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode==200) {

      print(response.body);
      return SubscriptionModel.fromJson(jsonDecode(response.body));
    } else {

      throw Exception('Failed to load album');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.defualtColor2,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.r),bottomRight:Radius.circular(25.r) )
        ),
        title: Text(
          "Subscription".tr(),
          style: TextStyle(
            fontFamily: 'Tajawal2',
            color: Styles.defualtColor3,
            fontSize: 18.sp,
          ),
        ),
        toolbarHeight: 70.h,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(5.h),
            FutureBuilder(
              future: getData(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 500.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Container(
                                  height: 135.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Styles.defualtColor5,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.h, vertical: 15.h),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapshot.data!.records![index].subscriptionTitle}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Styles.defualtColor3,

                                                fontFamily: 'Tajawal2',

                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data!.records![index].adsNumber}',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Styles.defualtColor,
                                                fontFamily: 'Tajawal7',
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data!.records![index].subscriptionPeriod}',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Styles.defualtColor,
                                                fontFamily: 'Tajawal7',
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                userData.write('Subscribe', snapshot.data!.records![index].id);
                                                print(snapshot.data!.records![index].id);
                                                print(userData.read('Subscribe'));

                                                userData.read('isLogged')==true&&userData.read('IsSubscriped')=="False"?Get.to(SubscribeScreen()):
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => Dialog(
                                                      shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              30)),
                                                      child: Container(
                                                        height: 210,
                                                        width: 250,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              35.h,
                                                              vertical: 15.h),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                LocaleKeys
                                                                    .You_are_not_subscribed
                                                                    .tr(),
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontSize: 17.sp,
                                                                ),
                                                              ),
                                                              Gap(20.h),
                                                              Text(
                                                                LocaleKeys
                                                                    .Move_to_Login_screen
                                                                    .tr(),
                                                                style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color: Styles
                                                                      .defualtColor2,
                                                                  fontSize: 14.sp,
                                                                ),
                                                              ),
                                                              Gap(10.h),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child:
                                                                    Container(
                                                                      height:
                                                                      35.h,
                                                                      width: 50.h,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.h),
                                                                        color: Styles
                                                                            .defualtColor,
                                                                      ),
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Text(
                                                                          LocaleKeys.Cancel
                                                                              .tr(),
                                                                          style:
                                                                          TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w500,
                                                                            color:
                                                                            Styles.defualtColor3,
                                                                            fontSize:
                                                                            14.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Gap(20.h),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      Get.to(
                                                                          LoginScreen());
                                                                    },
                                                                    child:
                                                                    Container(
                                                                      height:
                                                                      35.h,
                                                                      width: 50.h,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.h),
                                                                        color: Styles
                                                                            .defualtColor,
                                                                      ),
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Text(
                                                                          LocaleKeys.Ok
                                                                              .tr(),
                                                                          style:
                                                                          TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w500,
                                                                            color:
                                                                            Styles.defualtColor3,
                                                                            fontSize:
                                                                            14.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                height: 25.h,
                                                width: 100.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20.r),
                                                  gradient: LinearGradient(
                                                    begin: Alignment(.8.h, -.7.h),
                                                    end: Alignment(0.8.h, 1.h),
                                                    colors: [
                                                      Color(0xffC3A358),
                                                      Color(0xffE2CD6D),
                                                      Color(0xffC39528),

                                                      //C3A358
                                                      //E2CD6D
                                                      //C39528
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    LocaleKeys.Subscribe.tr(),
                                                    style: TextStyle(
                                                      fontFamily: 'Tajawal2',
                                                      color: Colors.black,
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'http://saudi07-001-site2.itempurl.com${snapshot.data!.records![index].imgUrl}'
                                          ),
                                          height: 50.h,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            itemCount: snapshot.data!.records!.length,
                            separatorBuilder: (BuildContext context, int index) { return Gap(15.h); },
                          ),
                        )
                      ],
                    ),
                  );
                }else {
                  return Center(
                    child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

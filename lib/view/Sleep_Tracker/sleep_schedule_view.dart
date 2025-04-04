import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fitness_tracker/common_widget/round_gradient_button.dart';
import 'package:fitness_tracker/common_widget/today_sleep_schedule_row.dart';
import 'package:fitness_tracker/view/Sleep_Tracker/sleep_add_alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../../common/color_extension.dart';

class SleepScheduleView extends StatefulWidget {
  const SleepScheduleView({super.key});

  @override
  State<SleepScheduleView> createState() => _SleepScheduleViewState();
}

class _SleepScheduleViewState extends State<SleepScheduleView> {
  final CalendarAgendaController _calendarAgendaController=CalendarAgendaController();
  late DateTime _selectedDateAppBar;

  List todaySleepArr = [
    {
      "name": "Bedtime",
      "image": "assets/img/bed.png",
      "time": "01/06/2023 09:00 PM",
      "duration": "in 6hours 22minutes"
    },
    {
      "name": "Alarm",
      "image": "assets/img/alaarm.png",
      "time": "02/06/2023 05:10 AM",
      "duration": "in 14hours 30minutes"
    },
  ];

  List<int> showingTooltipOnSpots=[4];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDateAppBar =DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColor.white,
        centerTitle: true,

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Image.asset("assets/img/back_btn.png",
              height: 15,
              width: 15,
              fit: BoxFit.contain,),
          ),
        ),
        title: Text("Meal Schedule",
          style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),

        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Image.asset("assets/img/more_btn.png",
                height: 15,
                width: 15,),
            ),
          )
        ],

      ),

      backgroundColor:TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(20),
                height: media.width*0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    TColor.primaryColor2.withOpacity(0.4),
                    TColor.primaryColor1.withOpacity(0.4)
                  ]),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 14,),
                        Text(
                            "Ideal Hours for Sleep",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14
                        ),
                        ),
                        Text(
                            "8hours 30minutes",
                        style: TextStyle(
                          color: TColor.primaryColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),),
                        const Spacer(),
                        SizedBox(
                          width: 110,
                          height: 35,
                          child: RoundGradientButton(
                              title: "Learn More",
                              fontSize: 12,
                              onPressed: (){}),
                        )
                      ],),
                    Image.asset("assets/img/sleep_schedule.png",
                    width: media.width*0.35,)

                  ],
                ),
              ),

            ),
            SizedBox(height: media.width*0.05,),
            Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
                "Your Schedule",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )),
            CalendarAgenda(
              controller:_calendarAgendaController,
              appbar: false,
              selectedDayPosition: SelectedDayPosition.center,
              leading: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img/ArrowLeft.png",
                    width: 15,
                    height: 15,
                  )),
              training: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img/ArrowRight.png",
                    width: 15,
                    height: 15,
                  )),
              weekDay: WeekDay.short,
              dayNameFontSize: 12,
              dayNumberFontSize: 16,
              dayBGColor: Colors.grey.withOpacity(0.15),
              titleSpaceBetween: 15,
              backgroundColor: Colors.transparent,
              // fullCalendar: false,
              fullCalendarScroll: FullCalendarScroll.horizontal,
              fullCalendarDay: WeekDay.short,
              selectedDateColor: Colors.white,
              dateColor: Colors.black,
              locale: 'en',

              initialDate: DateTime.now(),
              calendarEventColor: TColor.primaryColor2,
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now().add(const Duration(days: 60)),

              onDateSelected: (date) {
                _selectedDateAppBar = date;
              },
              selectedDayLogo: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: TColor.primaryG,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              itemCount: todaySleepArr.length,
              itemBuilder: (context,index){
                var sObj=todaySleepArr[index] as Map? ?? {};
                return TodaySleepScheduleRow(sObj: sObj);
              },
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  TColor.secondaryColor2.withOpacity(0.4),
                  TColor.secondaryColor1.withOpacity(0.4)
                ]),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You will get 8hours 10minutes\nfor tonight",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 12
                  ),),
                  SizedBox(height: 15,),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SimpleAnimationProgressBar(
                          ratio: 0.9,//kati percent ko bayexa banera
                          width: media.width-80,
                          height: 15,
                          direction: Axis.horizontal,
                          backgroundColor: Colors.grey.shade100,
                          foregrondColor: Colors.purple,
                          duration: Duration(seconds: 3),
                          curve: Curves.fastLinearToSlowEaseIn,
                          borderRadius: BorderRadius.circular(7.5),
                        gradientColor: LinearGradient(colors: TColor.secondaryG,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                      ),
                      Text("97%",
                      style: TextStyle(color: TColor.black,fontSize: 12),),
                      SizedBox(height:media.width*0.05)
                    ],

                  ),

                ],
              ),


            ),
          ],
        ),
      ),
      floatingActionButton:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SleepAddAlarmView(
            date: _selectedDateAppBar,
          )));
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: TColor.secondaryG),
            borderRadius: BorderRadius.circular(27.5),
            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 5,offset: Offset(0, 2))]
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),

    );
  }
}

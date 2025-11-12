# Flutter UI Code Compilation

This file combines all the Dart source files related to the UI components of your Flutter project.

## `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundryapp/pages/dashboard.dart';
import 'package:laundryapp/pages/home.dart';
import 'package:laundryapp/pages/login.dart';
import 'package:laundryapp/pages/single_order.dart';
import 'package:laundryapp/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Laundry App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          initialRoute: "/",
          onGenerateRoute: _onGenerateRoute,
        );
      },
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
    case "/login":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/dashboard":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Dashboard();
      });
    case "/single-order":
      return MaterialPageRoute(builder: (BuildContext context) {
        return SingleOrder();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
  }
}
```

## `dashboard.dart`

```dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../widgets/latest_orders.dart';
import '../widgets/location_slider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Track active index
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Constants.scaffoldBackgroundColor,
        buttonBackgroundColor: Constants.primaryColor,
        items: [
          Icon(
            Icons.home,
            size: 30.0,
            color: activeIndex == 0 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.pin_drop_rounded,
            size: 30.0,
            color: activeIndex == 1 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.add,
            size: 30.0,
            color: activeIndex == 2 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.favorite,
            size: 30.0,
            color: activeIndex == 3 ? Colors.white : Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.settings,
            size: 30.0,
            color: activeIndex == 4 ? Colors.white : Color(0xFFC8C9CB),
          ),
        ],
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      backgroundColor: Constants.primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0.0,
            top: -20.0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "assets/images/washing_machine_illustration.png",
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Welcome Back,\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  TextSpan(
                                    text: "Hypeteq!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/user.png",
                              height: 80,
                              width: 80,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Constants.scaffoldBackgroundColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child: Text(
                            "New Locations",
                            style: TextStyle(
                              color: Color.fromRGBO(19, 22, 33, 1),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Container(
                          height: ScreenUtil().setHeight(100.0),
                          child: Center(
                            // lets make a widget for the cards
                            child: LocationSlider(),
                          ),
                        ),
                        LatestOrders(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

## `home.dart`

```dart
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/helper.dart';
import '../widgets/app_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 100.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 150.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/cloth_faded.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/images/illustration.png",
                        scale: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                decoration: BoxDecoration(
                  color: Constants.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      "Welcome to Laundree!",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(19, 22, 33, 1),
                          ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "This is the first version of our laundry app. Please sign in or create an account below.",
                      style: TextStyle(
                        color: Color.fromRGBO(74, 77, 84, 1),
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    // Let's create a generic button widget
                    AppButton(
                      text: "Log In",
                      type: ButtonType.PLAIN,
                      onPressed: () {
                        nextScreen(context, "/login");
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    AppButton(
                      text: "Create an Account",
                      type: ButtonType.PRIMARY, onPressed: () {  },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

```

## `login.dart`

```dart
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/helper.dart';
import '../widgets/app_button.dart';
import '../widgets/input_widget.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/images/washing_machine_illustration.png",
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Log in to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 180.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              InputWidget(
                                topLabel: "Email",
                                hintText: "Enter your email address",
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              InputWidget(
                                topLabel: "Password",
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              AppButton(
                                type: ButtonType.PRIMARY,
                                text: "Log In",
                                onPressed: () {
                                  nextScreen(context, "/dashboard");
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

## `single_order.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class SingleOrder extends StatefulWidget {
  @override
  _SingleOrderState createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/images/washing_machine_illustration.png",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Details About\n",
                            style:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          TextSpan(
                            text: "Order #521",
                            style:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Constants.scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Details",
                            style:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "WASHING AND FOLDING",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow("3", "T-shirts (man)", "\$30.00"),
                          getItemRow("2", "T-shirts (man)", "\$40.00"),
                          getItemRow("4", "Pants (man)", "\$80.00"),
                          getItemRow("1", "Jeans (man)", "\$20.00"),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "IRONING",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow("3", "T-shirt (woman)", "\$30.00"),
                          Divider(),
                          getSubtotalRow("Subtotal", "\$200.00"),
                          getSubtotalRow("Delivery", "\$225.00"),
                          SizedBox(
                            height: 10.0,
                          ),
                          getTotalRow("Total", "\$225.00"),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      height: ScreenUtil().setHeight(127.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Your clothes are now washing.",
                            style:
                                Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Estimated Delivery\n",
                                      style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 162, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "24 January 2021",
                                      style: TextStyle(
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/images/washlogo.png",
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTotalRow(String title, String amount) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(19, 22, 33, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
        )
      ],
    ),
  );
}

Widget getSubtotalRow(String title, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getItemRow(String count, String item, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " x $item",
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

```

## `constants.dart`

```dart
import 'package:flutter/material.dart';

class Constants {
  static final Color primaryColor = Colors.blue;
  static final Color scaffoldBackgroundColor = Color.fromRGBO(245, 247, 249, 1);
}

```

## `helper.dart`

```dart
import 'package:flutter/material.dart';

void nextScreen(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

```

## `latest_orders.dart`

```dart
import 'package:flutter/material.dart';

import '../models/order.dart';
import '../utils/constants.dart';
import 'order_card.dart';

class LatestOrders extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: 507,
      deliveryAddress: "New Times Square",
      arrivalDate: DateTime(2020, 1, 23),
      placedDate: DateTime(2020, 1, 17),
      status: OrderStatus.DELIVERING,
    ),
    Order(
      id: 536,
      deliveryAddress: "Victoria Square",
      arrivalDate: DateTime(2020, 1, 21),
      placedDate: DateTime(2020, 1, 19),
      status: OrderStatus.PICKING_UP,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Orders",
                  style: TextStyle(
                    color: Color.fromRGBO(19, 22, 33, 1),
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              // Lets pass the order to a new widget and render it there
              return OrderCard(
                order: orders[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 15.0,
              );
            },
            itemCount: orders.length,
          )
          // Let's create an order model
        ],
      ),
    );
  }
}

```

## `location_slider.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/location.dart';

class LocationSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Model to represent each card

    // Make a list to represent each card
    List<Location> locations = [
      Location(
        address: "Kings Street 20",
        color: Color.fromRGBO(89, 69, 199, 1),
        state: "Bucharest",
        imagePath: "assets/images/house1.png",
      ),
      Location(
        address: "Victory Square 18",
        color: Color.fromRGBO(237, 116, 41, 1),
        state: "Bucharest",
        imagePath: "assets/images/house2.png",
      )
    ];
    return Container(
      height: ScreenUtil().setHeight(90.0),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(200.0),
              decoration: BoxDecoration(
                color: locations[index].color,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(169, 176, 185, 0.42),
                    spreadRadius: 0,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -16.0,
                    top: 0.0,
                    child: Opacity(
                      opacity: 0.69,
                      child: Image.asset(
                        locations[index].imagePath,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${locations[index].address},\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: locations[index].state,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}

```

## `order_card.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';
import '../utils/helper.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  // For formatting date
  final DateFormat formatter = DateFormat("yyyy MM dd");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, "/single-order");
      },
      child: Container(
        height: ScreenUtil().setHeight(121.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color.fromRGBO(220, 233, 245, 1),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getOrderIconWidget(order.status),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getOrderStatusText(order.status),
                    style: TextStyle(
                      color: Color.fromRGBO(19, 22, 33, 1),
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  textRow("Placed On", formatter.format(order.placedDate)),
                  SizedBox(
                    height: 5.0,
                  ),
                  textRow("Delivery On", formatter.format(order.arrivalDate))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textRow(String textOne, String textTwo) {
  return Wrap(
    children: [
      Text(
        "$textOne:",
        style: TextStyle(
          color: Color.fromRGBO(74, 77, 84, 0.7),
          fontSize: 14.0,
        ),
      ),
      SizedBox(
        width: 4.0,
      ),
      Text(
        textTwo,
        style: TextStyle(
          color: Color.fromRGBO(19, 22, 33, 1),
          fontSize: 14.0,
        ),
      ),
    ],
  );
}

Widget getOrderIconWidget(OrderStatus status) {
  switch (status) {
    case OrderStatus.PICKING_UP:
      return Container(
        width: ScreenUtil().setWidth(37.0),
        height: ScreenUtil().setHeight(37.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(221, 40, 81, 0.18),
        ),
        child: Icon(
          Icons.local_activity,
          color: Color.fromRGBO(221, 40, 81, 1),
        ),
      );
    case OrderStatus.DELIVERING:
      return Container(
        width: ScreenUtil().setWidth(37.0),
        height: ScreenUtil().setHeight(37.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 99, 2, 0.15),
        ),
        child: Icon(
          Icons.history,
          color: Color.fromRGBO(255, 99, 2, 1),
        ),
      );
    default:
      return Container(
        width: ScreenUtil().setWidth(37.0),
        height: ScreenUtil().setHeight(37.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(221, 40, 81, 0.18),
        ),
        child: Icon(
          Icons.local_activity,
          color: Color.fromRGBO(221, 40, 81, 1),
        ),
      );
  }
}

String getOrderStatusText(OrderStatus status) {
  switch (status) {
    case OrderStatus.DELIVERING:
      return "Delivering Order";
    case OrderStatus.PICKING_UP:
      return "Picking Up Order";
    default:
      return "";
  }
}

```

## `app_button.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

enum ButtonType { PRIMARY, PLAIN }

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback onPressed;
  final String text;

  AppButton({required this.type, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(48.0),
        decoration: BoxDecoration(
          color: getButtonColor(type),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            this.text,
            style: GoogleFonts.roboto(
              color: getTextColor(type),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

Color getButtonColor(ButtonType type) {
  switch (type) {
    case ButtonType.PRIMARY:
      return Constants.primaryColor;
    case ButtonType.PLAIN:
      return Colors.white;
    default:
      return Constants.primaryColor;
  }
}

Color getTextColor(ButtonType type) {
  switch (type) {
    case ButtonType.PLAIN:
      return Constants.primaryColor;
    case ButtonType.PRIMARY:
      return Colors.white;
    default:
      return Colors.white;
  }
}

```

## `input_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final double height;
  final String topLabel;
  final bool obscureText;

  InputWidget({
    required this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel),
        SizedBox(height: 5.0),
        Container(
          height: ScreenUtil().setHeight(height),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            obscureText: this.obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.primaryColor,
                ),
              ),
              hintText: this.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}

```


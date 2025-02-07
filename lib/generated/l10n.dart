// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `syn faya`
  String get app_name {
    return Intl.message(
      'syn faya',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `log in`
  String get login {
    return Intl.message(
      'log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pass {
    return Intl.message(
      'Password',
      name: 'pass',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Ofline`
  String get ofline {
    return Intl.message(
      'Ofline',
      name: 'ofline',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_Deteils {
    return Intl.message(
      'Order Details',
      name: 'order_Deteils',
      desc: '',
      args: [],
    );
  }

  /// `PickUp`
  String get pickup {
    return Intl.message(
      'PickUp',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `show`
  String get show {
    return Intl.message(
      'show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Delivary`
  String get delivary {
    return Intl.message(
      'Delivary',
      name: 'delivary',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_nav {
    return Intl.message(
      'Profile',
      name: 'profile_nav',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Orders History`
  String get orderhistory {
    return Intl.message(
      'Orders History',
      name: 'orderhistory',
      desc: '',
      args: [],
    );
  }

  /// `Open Orders`
  String get open_order {
    return Intl.message(
      'Open Orders',
      name: 'open_order',
      desc: '',
      args: [],
    );
  }

  /// `Delivered orders`
  String get deleverd_order {
    return Intl.message(
      'Delivered orders',
      name: 'deleverd_order',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled Orders`
  String get cance_lorder {
    return Intl.message(
      'Cancelled Orders',
      name: 'cance_lorder',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Ranking`
  String get ranking {
    return Intl.message(
      'Ranking',
      name: 'ranking',
      desc: '',
      args: [],
    );
  }

  /// `age`
  String get age {
    return Intl.message(
      'age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `about`
  String get about {
    return Intl.message(
      'about',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_d {
    return Intl.message(
      'Order Details',
      name: 'order_d',
      desc: '',
      args: [],
    );
  }

  /// `Delails of the order are below`
  String get de_order_blow {
    return Intl.message(
      'Delails of the order are below',
      name: 'de_order_blow',
      desc: '',
      args: [],
    );
  }

  /// `PickUp location`
  String get pickup_loc {
    return Intl.message(
      'PickUp location',
      name: 'pickup_loc',
      desc: '',
      args: [],
    );
  }

  /// `delevary location`
  String get delevary_loc {
    return Intl.message(
      'delevary location',
      name: 'delevary_loc',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get order_state {
    return Intl.message(
      'Order Status',
      name: 'order_state',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `In Transit`
  String get intransit {
    return Intl.message(
      'In Transit',
      name: 'intransit',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Current Status`
  String get currunt {
    return Intl.message(
      'Current Status',
      name: 'currunt',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancel {
    return Intl.message(
      'Cancel Order',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `View Map`
  String get viewmap {
    return Intl.message(
      'View Map',
      name: 'viewmap',
      desc: '',
      args: [],
    );
  }

  /// `settings page`
  String get setings {
    return Intl.message(
      'settings page',
      name: 'setings',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get orderid {
    return Intl.message(
      'Order Id',
      name: 'orderid',
      desc: '',
      args: [],
    );
  }

  /// `Customer Name`
  String get customername {
    return Intl.message(
      'Customer Name',
      name: 'customername',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get Companyname {
    return Intl.message(
      'Company Name',
      name: 'Companyname',
      desc: '',
      args: [],
    );
  }

  /// `Order Type`
  String get ordertybe {
    return Intl.message(
      'Order Type',
      name: 'ordertybe',
      desc: '',
      args: [],
    );
  }

  /// `Item Count`
  String get item {
    return Intl.message(
      'Item Count',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get orderdata {
    return Intl.message(
      'Order Date',
      name: 'orderdata',
      desc: '',
      args: [],
    );
  }

  /// `additional details`
  String get additionaldetails {
    return Intl.message(
      'additional details',
      name: 'additionaldetails',
      desc: '',
      args: [],
    );
  }

  /// `enter email`
  String get enteremail {
    return Intl.message(
      'enter email',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `enter password`
  String get enterpassword {
    return Intl.message(
      'enter password',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `Not Provided`
  String get NotProvided {
    return Intl.message(
      'Not Provided',
      name: 'NotProvided',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get canceledorder {
    return Intl.message(
      'Cancel Order',
      name: 'canceledorder',
      desc: '',
      args: [],
    );
  }

  /// `BIll_gets@email.com`
  String get BIllgetsemailcom {
    return Intl.message(
      'BIll_gets@email.com',
      name: 'BIllgetsemailcom',
      desc: '',
      args: [],
    );
  }

  /// `Bill gets`
  String get Billgets {
    return Intl.message(
      'Bill gets',
      name: 'Billgets',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get sopen {
    return Intl.message(
      'Open',
      name: 'sopen',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get sCancelled {
    return Intl.message(
      'Cancelled',
      name: 'sCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get sDelivered {
    return Intl.message(
      'Delivered',
      name: 'sDelivered',
      desc: '',
      args: [],
    );
  }

  /// `العربيه`
  String get change_language {
    return Intl.message(
      'العربيه',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid `
  String get pay {
    return Intl.message(
      'Unpaid ',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `status Pay `
  String get statePay {
    return Intl.message(
      'status Pay ',
      name: 'statePay',
      desc: '',
      args: [],
    );
  }

  /// `end point`
  String get api {
    return Intl.message(
      'end point',
      name: 'api',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacy {
    return Intl.message(
      'privacy policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `remember me`
  String get remember_me {
    return Intl.message(
      'remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `New Notification`
  String get orederNOT {
    return Intl.message(
      'New Notification',
      name: 'orederNOT',
      desc: '',
      args: [],
    );
  }

  /// `New order has been added`
  String get orderBody {
    return Intl.message(
      'New order has been added',
      name: 'orderBody',
      desc: '',
      args: [],
    );
  }

  /// `Show Receipt`
  String get showw {
    return Intl.message(
      'Show Receipt',
      name: 'showw',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

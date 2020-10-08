import 'dart:async' show Future;

import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

import 'constant.dart' show LANGUAGES;

class MyLocalizations {
  final Map<String, Map<String, String>> localizedValues;

  MyLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String get areYouSureYouWantToAssignOrderTo {
    return localizedValues[locale.languageCode]
        ['areYouSureYouWantToAssignOrderTo'];
  }

  String get assignedSuccessfully {
    return localizedValues[locale.languageCode]['assignedSuccessfully'];
  }

  String get goBack {
    return localizedValues[locale.languageCode]['goBack'];
  }

  String get myAccount {
    return localizedValues[locale.languageCode]['myAccount'];
  }

  String get viewProducts {
    return localizedValues[locale.languageCode]['viewProducts'];
  }

  String get userName {
    return localizedValues[locale.languageCode]['userName'];
  }

  String get changeProfile {
    return localizedValues[locale.languageCode]['changeProfile'];
  }

  String get updateProfile {
    return localizedValues[locale.languageCode]['updateProfile'];
  }

  String get greenSalad {
    return localizedValues[locale.languageCode]['greenSalad'];
  }

  String get edit {
    return localizedValues[locale.languageCode]['edit'];
  }

  String get pleaseWait {
    return localizedValues[locale.languageCode]['pleaseWait'];
  }

  String get enableDisable {
    return localizedValues[locale.languageCode]['enableDisable'];
  }

  String get searchProduct {
    return localizedValues[locale.languageCode]['searchProduct'];
  }

  String get products {
    return localizedValues[locale.languageCode]['products'];
  }

  String get pleaseEnterAValidEmail {
    return localizedValues[locale.languageCode]['pleaseEnterAValidEmail'];
  }

  String get passwordShouldBeAtleast6CharLong {
    return localizedValues[locale.languageCode]
        ['passwordShouldBeAtleast6CharLong'];
  }

  String get loginSuccessfully {
    return localizedValues[locale.languageCode]['loginSuccessfully'];
  }

  String get selectImage {
    return localizedValues[locale.languageCode]['selectImage'];
  }

  String get locationName {
    return localizedValues[locale.languageCode]['locationName'];
  }

  String get extraVariant {
    return localizedValues[locale.languageCode]['extraVariant'];
  }

  String get serial {
    return localizedValues[locale.languageCode]['serial'];
  }

  String get variant {
    return localizedValues[locale.languageCode]['variant'];
  }

  String get category {
    return localizedValues[locale.languageCode]['category'];
  }

  String get productName {
    return localizedValues[locale.languageCode]['productName'];
  }

  String get enterBrandName {
    return localizedValues[locale.languageCode]['enterBrandName'];
  }

  String get aboutOurProduct {
    return localizedValues[locale.languageCode]['aboutOurProduct'];
  }

  String get variantInfo {
    return localizedValues[locale.languageCode]['variantInfo'];
  }

  String get halfFull {
    return localizedValues[locale.languageCode]['halfFull'];
  }

  String get discount {
    return localizedValues[locale.languageCode]['discount'];
  }

  String get extraVariantInfo {
    return localizedValues[locale.languageCode]['extraVariantInfo'];
  }

  String get create {
    return localizedValues[locale.languageCode]['create'];
  }

  String get youAreNotAuthorizedToLogin {
    return localizedValues[locale.languageCode]['youAreNotAuthorizedToLogin'];
  }

  String get orderAccepted {
    return localizedValues[locale.languageCode]['orderAccepted'];
  }

  String get orderCancelled {
    return localizedValues[locale.languageCode]['orderCancelled'];
  }

  String get orderHistory {
    return localizedValues[locale.languageCode]['orderHistory'];
  }

  String get reports {
    return localizedValues[locale.languageCode]['reports'];
  }

  String get daily {
    return localizedValues[locale.languageCode]['daily'];
  }

  String get monthly {
    return localizedValues[locale.languageCode]['monthly'];
  }

  String get addProducts {
    return localizedValues[locale.languageCode]['addProducts'];
  }

  String get noOrderHistory {
    return localizedValues[locale.languageCode]['noOrderHistory'];
  }

  String get accept {
    return localizedValues[locale.languageCode]['accept'];
  }

  String get customerAndPaymentInfo {
    return localizedValues[locale.languageCode]['customerAndPaymentInfo'];
  }

  String get reject {
    return localizedValues[locale.languageCode]['reject'];
  }

  String get newOrders {
    return localizedValues[locale.languageCode]['newOrders'];
  }

  String get inProgress {
    return localizedValues[locale.languageCode]['inProgress'];
  }

  String get orders {
    return localizedValues[locale.languageCode]['orders'];
  }

  String get home {
    return localizedValues[locale.languageCode]['home'];
  }

  String get login {
    return localizedValues[locale.languageCode]['login'];
  }

  String get logout {
    return localizedValues[locale.languageCode]['logout'];
  }

  String get selectLanguages {
    return localizedValues[locale.languageCode]['selectLanguages'];
  }

  String get emailId {
    return localizedValues[locale.languageCode]['emailId'];
  }

  String get address {
    return localizedValues[locale.languageCode]['address'];
  }

  String get cancel {
    return localizedValues[locale.languageCode]['cancel'];
  }

  String get password {
    return localizedValues[locale.languageCode]['password'];
  }

  String get assignForDeliver {
    return localizedValues[locale.languageCode]['assignForDeliver'];
  }

  String get pleaseTryAgain {
    return localizedValues[locale.languageCode]['pleaseTryAgain'];
  }

  String get assignedTo {
    return localizedValues[locale.languageCode]['assignedTo'];
  }

  String get selectDeliveryAgent {
    return localizedValues[locale.languageCode]['selectDeliveryAgent'];
  }

  String get alreadyAssigned {
    return localizedValues[locale.languageCode]['alreadyAssigned'];
  }

  String get noStaffAvailable {
    return localizedValues[locale.languageCode]['noStaffAvailable'];
  }

  String get status {
    return localizedValues[locale.languageCode]['status'];
  }

  String get view {
    return localizedValues[locale.languageCode]['view'];
  }

  String get paymentMode {
    return localizedValues[locale.languageCode]['paymentMode'];
  }

  String get location {
    return localizedValues[locale.languageCode]['location'];
  }

  String get size {
    return localizedValues[locale.languageCode]['size'];
  }

  String get price {
    return localizedValues[locale.languageCode]['price'];
  }

  String get subTotal {
    return localizedValues[locale.languageCode]['subTotal'];
  }

  String get deliveryCharges {
    return localizedValues[locale.languageCode]['deliveryCharges'];
  }

  String get grandTotal {
    return localizedValues[locale.languageCode]['grandTotal'];
  }

  String get orderDetails {
    return localizedValues[locale.languageCode]['orderDetails'];
  }

  String get paymentMethod {
    return localizedValues[locale.languageCode]['paymentMethod'];
  }

  String get ecoOptions {
    return localizedValues[locale.languageCode]['ecoOptions'];
  }

  String get brand {
    return localizedValues[locale.languageCode]['brand'];
  }

  String get errorMessage {
    return localizedValues[locale.languageCode]['errorMessage'];
  }

  String get pickUpTime {
    return localizedValues[locale.languageCode]['pickUpTime'];
  }

  String get pickUpDate {
    return localizedValues[locale.languageCode]['pickUpDate'];
  }

  String get orderID {
    return localizedValues[locale.languageCode]['orderID'];
  }

  String get name {
    return localizedValues[locale.languageCode]['name'];
  }

  String get confirm {
    return localizedValues[locale.languageCode]['confirm'];
  }

  String get contactNo {
    return localizedValues[locale.languageCode]['contactNo'];
  }

  String get orderType {
    return localizedValues[locale.languageCode]['orderType'];
  }

  String get ok {
    return localizedValues[locale.languageCode]['ok'];
  }

  String get somethingwentwrongpleaserestarttheapp {
    return localizedValues[locale.languageCode]
        ['somethingwentwrongpleaserestarttheapp'];
  }

  String get logoutSuccessfully {
    return localizedValues[locale.languageCode]['logoutSuccessfully'];
  }

  String get description {
    return localizedValues[locale.languageCode]['description'];
  }

  String get mRP {
    return localizedValues[locale.languageCode]['mRP'];
  }

  String get like {
    return localizedValues[locale.languageCode]['like'];
  }
  String get invoiceName {
    return localizedValues[locale.languageCode]['invoiceName'];
  }

  String get nit {
    return localizedValues[locale.languageCode]['nit'];
  }

  String get note {
    return localizedValues[locale.languageCode]['note'];
  }

  String get free {
    return localizedValues[locale.languageCode]['free'];
  }

  String get flavour {
    return localizedValues[locale.languageCode]['flavour'];
  }

  greetTo(name) {
    return localizedValues[locale.languageCode]['greetTo']
        .replaceAll('{{name}}', name);
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  Map<String, Map<String, String>> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) => LANGUAGES.contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(
        MyLocalizations(locale, localizedValues));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}

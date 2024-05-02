class DefaultAppSettingModal {
  int appVersionIos;
  int appVersionAndroid;
  int hardUpdateVersionAndroid;
  int hardUpdateVersionIos;
  bool updatePopup;
  String? googleApiKey;
  String updateUrlAndroid;
  String updateUrlIos;
  String updateMessage;
  int autoCancelPaymentNotDoneInMin;
  int autoCancelProviderNotAcceptInMin;
  int autoCancelOnProviderNotArrivedInMin;
  int autoCancelOnUserNotAccept_ProviderArrivingInMin;

  DefaultAppSettingModal({
    required this.appVersionIos,
    required this.appVersionAndroid,
    required this.hardUpdateVersionAndroid,
    required this.hardUpdateVersionIos,
    required this.updatePopup,
    required this.googleApiKey,
    required this.updateUrlAndroid,
    required this.updateUrlIos,
    required this.updateMessage,
    required this.autoCancelPaymentNotDoneInMin,
    required this.autoCancelProviderNotAcceptInMin,
    required this.autoCancelOnProviderNotArrivedInMin,
    required this.autoCancelOnUserNotAccept_ProviderArrivingInMin,
  });

  factory DefaultAppSettingModal.fromJson(Map json) {
    return DefaultAppSettingModal(
      appVersionIos: json['appVersionIos'],
      appVersionAndroid: json['appVersionAndroid'],
      hardUpdateVersionAndroid: json['hardUpdateVersionAndroid'],
      hardUpdateVersionIos: json['hardUpdateVersionIos'],
      updatePopup: json['updatePopup'],
      googleApiKey: json['googleApiKey'],
      updateUrlAndroid: json['updateUrlAndroid'],
      updateUrlIos: json['updateUrlIos'],
      updateMessage: json['updateMessage'],
        autoCancelPaymentNotDoneInMin:  json['autoCancelPaymentNotDoneInMin'],
    autoCancelProviderNotAcceptInMin:  json['autoCancelProviderNotAcceptInMin'],
    autoCancelOnProviderNotArrivedInMin:  json['autoCancelOnProviderNotArrivedInMin'],
    autoCancelOnUserNotAccept_ProviderArrivingInMin:  json['autoCancelOnUserNotAccept_ProviderArrivingInMin'],
    );
  }
}

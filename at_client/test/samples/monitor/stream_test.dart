import 'package:at_client/at_client.dart';
import 'package:at_client/src/client/at_client_impl.dart';
import 'package:at_client/src/service/notification_service.dart';
import 'package:at_client/src/service/notification_service_impl.dart';
import 'package:at_commons/at_commons.dart';

import '../test_util.dart';

void main() async {
  try {
    var aliceAtSign = '@alice🛠', bobAtSign = '@bob🛠';
    // create alice client
    await AtClientImpl.createClient(
        aliceAtSign, 'wavi', TestUtil.getAlicePreference());
    var aliceClient = await (AtClientImpl.getClient(aliceAtSign));
    aliceClient!.getSyncManager()!.init(aliceAtSign, TestUtil.getAlicePreference(),
        aliceClient.getRemoteSecondary(), aliceClient.getLocalSecondary());

    // create bob client
    await AtClientImpl.createClient(
        bobAtSign, 'wavi', TestUtil.getBobPreference());
    var bobClient = await (AtClientImpl.getClient(bobAtSign));
    bobClient!.getSyncManager()!.init(bobAtSign, TestUtil.getBobPreference(),
        bobClient.getRemoteSecondary(), bobClient.getLocalSecondary());
    // alice - listen for notification
    final aliceNotificationService = NotificationServiceImpl(aliceClient);
    aliceNotificationService.subscribe(regex: '.wavi').listen((notification) {
      print('notification event received: ${notification.toString()}');
    });
  } on Exception catch (e, trace) {
    print(e.toString());
    print(trace);
  }
}

void _notificationCallback(AtNotification notification) {
  print('alice notification received: ${notification.toString()}');
}

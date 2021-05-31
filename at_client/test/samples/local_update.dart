import 'package:at_client/src/client/at_client_impl.dart';
import 'package:at_commons/at_commons.dart';

import 'test_util.dart';

void main() async {
  var atsign = '@alice🛠';
  await AtClientImpl.createClient(atsign, 'me', TestUtil.getAlicePreference());
  var atClient = await AtClientImpl.getClient(atsign);
  // phone.me@alice🛠
  var phoneKey = AtKey()..key = 'phone';
  var value = '+1 100 200 301';
  var result = await atClient.put(phoneKey, value);
  print(result);

  // public:phone.me@alice🛠
//  var metadata = Metadata()..isPublic = true;
//  var publicPhoneKey = AtKey()
//    ..key = 'phone'
//    ..metadata = metadata;
//  var publicPhoneValue = '+1 100 200 302';
//  var updatePublicPhoneResult =
//      await atClient.put(publicPhoneKey, publicPhoneValue);
//  print(updatePublicPhoneResult);
}

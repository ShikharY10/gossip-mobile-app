import 'dart:async';
import 'dart:io';

class CheckInternetConnection {
  late StreamController<int> _statusController;

  /// Stream for checking the internet connection:
  /// The stream omit int type event.
  /// It gives only two integer value: 
  /// 0 -> No Internet Connection
  /// 1 -> Internet Connection is awailable
  late Stream<int> statusStream;

  CheckInternetConnection() {
    _statusController = StreamController<int>();
    statusStream = _statusController.stream.asBroadcastStream();
    _checkStatus();
  }

  void _checkStatus() async {
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        try {
          List<InternetAddress> result = await InternetAddress
            .lookup('google.com')
            .timeout(
              const Duration(seconds: 2),
              onTimeout: () {
                List<InternetAddress> lst = [];
                return lst;
              }
            );
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              _statusController.sink.add(1);
            } else {
              _statusController.sink.add(0);
            }
        } on SocketException catch (_) {
          _statusController.sink.add(0);
        } catch (e) {
          _statusController.sink.add(0);
        }
      }
    );
  }
}

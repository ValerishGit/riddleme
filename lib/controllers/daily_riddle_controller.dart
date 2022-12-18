import 'package:get/get.dart';
import 'package:riddle_me/modals/riddle_modal.dart';
import 'package:riddle_me/services/firebase_service.dart';

class DailyRiddleController extends GetxController {
  RxString nextRiddleTimer = getNextDeadline(DateTime.now().toUtc()).obs;
  Rx<DailyQuestion> dailyQuestion = DailyQuestion(null, null, null).obs;
  DailyRiddleController() {
    getTodayRiddle();
  }
  Future<void> getTodayRiddle() async {
    dailyQuestion(await FirebaseService.getDailyQuestion());
  }

  static String getNextDeadline(DateTime now) {
    final todaysDeadline =
        DateTime(now.year, now.month, now.day, 23, 59).toUtc();

    Duration diff = todaysDeadline.difference(now);
    return durationToString(diff.inMinutes);
  }

  static String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}

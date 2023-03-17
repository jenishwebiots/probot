import '../../../config.dart';
import '../../../controllers/app_pages_controllers/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final notificationCtrl = Get.put(NotificationController());
   NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (_) {
        return Scaffold(
          appBar: AppAppBarCommon(title: appFonts.notification,leadingOnTap: ()=> Get.back(),isAction: false),
          body:  Column(
            children: [

            ],
          ),
        );
      }
    );
  }
}

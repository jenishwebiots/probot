import 'package:get/get.dart';

import 'common/app_array.dart';
import 'common/app_fonts.dart';
import 'controllers/common_controllers/app_controller.dart';
export '../controllers/index.dart';

export 'package:flutter/material.dart';
// All extensions library
export '../common/extension/text_style_extensions.dart';
export '../common/extension/widget_extension.dart';
export '../common/theme/app_css.dart';
export '../common/assets/index.dart';
export '../common/extension/spacing.dart';
// All models library


export '../models/home_option_model.dart';
export '../models/select_language_model.dart';
export 'package:probot/models/notification_model.dart';
export 'package:probot/models/image_list_model.dart';
export '../../models/page_list_model.dart';
export '../package_list.dart';
export '../routes/index.dart';
export '../routes/route_name.dart';
export '../routes/screen_list.dart';

//utils
export '../utils/extensions.dart';

// All widgets library
export '../widgets/button_common.dart';
export '../widgets/dotted_line.dart';
export '../widgets/or_layout.dart';
export '../widgets/text_field_common.dart';
export '../widgets/validation.dart';
export '../widgets/app_bar_common.dart';
export '../widgets/directionality_rtl.dart';
export '../widgets/common_menu_icon.dart';
export '../widgets/auth_app_bar_common.dart';
export '../models/message_model.dart';
export '../models/chat_model.dart';

final appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());

AppFonts appFonts = AppFonts();
AppArray appArray = AppArray();

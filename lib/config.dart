import 'package:get/get.dart';
import 'common/app_array.dart';
import 'common/app_fonts.dart';
import 'controllers/common_controllers/app_controller.dart';
export 'package:flutter/material.dart';
export 'package:probot/package_list.dart';
export 'package:probot/routes/route_name.dart';
export 'package:probot/routes/index.dart';
export 'package:probot/routes/screen_list.dart';
export 'package:probot/controllers/index.dart';
export 'package:probot/common/theme/app_css.dart';
export 'package:probot/common/assets/index.dart';

// All extensions library
export 'package:probot/common/extension/text_style_extensions.dart';
export 'package:probot/common/extension/spacing.dart';
export 'package:probot/common/extension/widget_extension.dart';
export 'package:probot/utils/extensions.dart';

// All layout library
export 'package:probot/screens/auth_screens/on_boarding_screen/layouts/page_view_common.dart';

// All widgets library
export 'package:probot/widgets/button_common.dart';
export 'package:probot/widgets/dotted_line.dart';
export 'package:probot/widgets/text_field_common.dart';
export 'package:probot/widgets/or_layout.dart';

final appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());

AppFonts appFonts = AppFonts();
AppArray appArray = AppArray();
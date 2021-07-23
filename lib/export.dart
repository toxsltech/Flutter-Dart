//Dart
export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'package:flutter/foundation.dart';

//3rd Party
export 'package:badges/badges.dart';
export 'package:device_info/device_info.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:form_field_validator/form_field_validator.dart';
export 'package:image_picker/image_picker.dart';
export 'package:multi_image_picker/multi_image_picker.dart';
export 'package:randomizer/randomizer.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_cache_manager/flutter_cache_manager.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
export 'package:rflutter_alert/rflutter_alert.dart';
export 'package:lottie/lottie.dart';
export 'package:file_picker/file_picker.dart';
export 'package:mime/mime.dart';
export 'package:shimmer/shimmer.dart';
export 'package:alanis/widgets/reusable_video_list_controller.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:flutter_local_notifications/flutter_local_notifications.dart';
export 'package:flutter_html/flutter_html.dart';
export 'package:better_player/better_player.dart';
export 'package:visibility_detector/visibility_detector.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:alanis/main.dart';
export 'package:connectivity_plus/connectivity_plus.dart';

//Constant
export 'package:alanis/constants/app_theme.dart';
export 'package:alanis/constants/assets.dart';
export 'package:alanis/constants/colors.dart';
export 'package:alanis/constants/dimens.dart';
export 'package:alanis/constants/font_family.dart';
export 'package:alanis/constants/strings.dart';
export 'package:alanis/constants/app_constant.dart';
export 'package:alanis/constants/tab_constant.dart';
export 'package:alanis/constants/usertype.dart';
export 'package:alanis/constants/badges.dart';
export 'package:alanis/constants/role.dart';
export 'package:alanis/constants/blurhash.dart';

//Data  ----> Network
export 'package:alanis/data/network/api_error_handle.dart';
export 'package:alanis/data/network/api_provider.dart';
export 'package:alanis/data/network/dio_client.dart';
export 'package:alanis/data/network/endpoint.dart';
export 'package:alanis/data/network/network_exceptions.dart';

//Data  ----> Shared Pref
export 'package:alanis/data/sharedpref/constants/local_storage.dart';
export 'package:alanis/data/sharedpref/shared_prefrence_helper.dart';

//Model
export 'package:alanis/model/timeago.dart';

/*Error Model*/
export 'package:alanis/model/error_model/error_response_model.dart';

/*Request Model*/
export 'package:alanis/model/request_model/auth_reuest_model.dart';

/*Response Model  -> Auth Response Model*/
export 'package:alanis/model/response_model/auth_models/change_password_response.dart';
export 'package:alanis/model/response_model/auth_models/forgot_password_response.dart';
export 'package:alanis/model/response_model/auth_models/login_response_model.dart';
export 'package:alanis/model/response_model/auth_models/logout_response_model.dart';

/*Response Model -> * */
export 'package:alanis/model/response_model/accept_reject_model.dart';
export 'package:alanis/model/response_model/add_post_model.dart';
export 'package:alanis/model/response_model/answer_model.dart';
export 'package:alanis/model/response_model/check_user_model.dart';
export 'package:alanis/model/response_model/createdby_model.dart';
export 'package:alanis/model/response_model/detail_model.dart';
export 'package:alanis/model/response_model/follow_request_model.dart';
export 'package:alanis/model/response_model/friend_request_model.dart';
export 'package:alanis/model/response_model/home_model.dart';
export 'package:alanis/model/response_model/link_model.dart';
export 'package:alanis/model/response_model/login_data_model.dart';
export 'package:alanis/model/response_model/meta_model.dart';
export 'package:alanis/model/response_model/my_follower_model.dart';
export 'package:alanis/model/response_model/my_post_model.dart';
export 'package:alanis/model/response_model/mypost_model.dart';
export 'package:alanis/model/response_model/proffesional_question_model.dart';
export 'package:alanis/model/response_model/search_model.dart';
export 'package:alanis/model/response_model/self_model.dart';
export 'package:alanis/model/response_model/short_detail_model.dart';
export 'package:alanis/model/response_model/submit_professional_model.dart';
export 'package:alanis/model/response_model/submit_rising_model.dart';
export 'package:alanis/model/response_model/toUser_model.dart';
export 'package:alanis/model/response_model/update_data_model.dart';
export 'package:alanis/model/response_model/update_response_model.dart';
export 'package:alanis/model/response_model/comment_list_data_model.dart';
export 'package:alanis/model/response_model/comment_model.dart';
export 'package:alanis/model/response_model/like_model.dart';
export 'package:alanis/model/response_model/comment_list_model.dart';
export 'package:alanis/model/response_model/chat_user_model.dart';
export 'package:alanis/model/request_model/chat_request_model.dart';
export 'package:alanis/model/data_model/chat_module_data_models/send_message_data_model.dart';
export 'package:alanis/model/response_model/chat_module_response_model/message_send_response_model.dart';
export 'package:alanis/model/response_model/chat_like_model.dart';
export 'package:alanis/model/response_model/chat_module_response_model/one_to_one_chat_response_model.dart';
export 'package:alanis/model/response_model/static_page_response_model.dart';
export 'package:alanis/model/response_model/userdetail_model.dart';
export 'package:alanis/model/data_model/chat_module_data_models/one_to_one_chat_data_model.dart';
export 'package:alanis/model/response_model/chat_module_response_model/one_to_one_chat_response_model.dart';
export 'package:alanis/model/response_model/postlist_model.dart';
export 'package:alanis/model/response_model/notification_list_model.dart';
export 'package:alanis/model/response_model/notification_data_model.dart';
export 'package:alanis/model/response_model/contactus_model.dart';
export 'package:alanis/model/response_model/notificationSetting_model.dart';
export 'package:alanis/model/response_model/rising_detail_model.dart';

//Settings
export 'package:alanis/settings/notification_setting.dart';
export 'package:alanis/settings/settings.dart';

//UI -> Authentication
export 'package:alanis/ui/authentication/forgot_password.dart';
export 'package:alanis/ui/authentication/registration_screen.dart';
export 'package:alanis/ui/authentication/sign_in.dart';

//UI -> Home
export 'package:alanis/ui/home/bottom_nav_screen.dart';
export 'package:alanis/ui/home/home.dart';
export 'package:alanis/ui/home/notifications.dart';
export 'package:alanis/ui/home/network.dart';
export 'package:alanis/ui/home/request_page.dart';

//UI -> Profile
export 'package:alanis/ui/profile/change_password.dart';
export 'package:alanis/ui/profile/profile_setup.dart';

//UI -> Splash
export 'package:alanis/ui/splash/splash_screen.dart';

//UI -> Text Screen
export 'package:alanis/ui/text_screens/contact_us.dart';
export 'package:alanis/ui/text_screens/terms_and_condistion.dart';
export 'package:alanis/ui/text_screens/point_system.dart';
export 'package:alanis/ui/static_pages.dart';

//UI -> Question
export 'package:alanis/ui/questions/profesional_question.dart';
export 'package:alanis/ui/questions/rising_star_question.dart';

//UI -> Post
export 'package:alanis/ui/post/comments_screen.dart';
export 'package:alanis/ui/post/post_details.dart';
export 'ui/post/add_post.dart';

//UI -> Chat
export 'package:alanis/ui/chat/chat_screen.dart';
export 'package:alanis/ui/chat/messages_page.dart';

//UI -> profile_detail
export 'package:alanis/ui/profile_detail/professional_detail.dart';
export 'package:alanis/ui/profile_detail/profile_about_us.dart';
export 'package:alanis/ui/profile_detail/profile_doc.dart';

//UI -> * Screen

//Utility
export 'package:alanis/utility/custom_loader.dart';
export 'package:alanis/utility/dialogs.dart';
export 'package:alanis/utility/helper_utility.dart';
export 'package:alanis/utility/helper_widget.dart';
export 'package:alanis/utility/image_picker.dart';
export 'package:alanis/utility/validator.dart';

//Widgets
export 'package:alanis/widgets/custom_button.dart';
export 'package:alanis/widgets/textfield_dropdown.dart';
export 'package:alanis/widgets/textfield_rectangular.dart';
export 'package:alanis/widgets/textfield_widget.dart';
export 'package:alanis/widgets/heart_animator.dart';
export 'package:alanis/widgets/shimmers/network_shimmer.dart';
export 'package:alanis/widgets/shimmers/post_shimmer.dart';
export 'package:alanis/widgets/shimmers/message_shimmer.dart';
export 'package:alanis/widgets/shimmers/followers_shimmer.dart';
export 'package:alanis/widgets/shimmers/prof_profile_shimmer.dart';
export 'package:alanis/widgets/reusable_video_list_widget.dart';
export 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

//Routes
export 'package:alanis/routes.dart';

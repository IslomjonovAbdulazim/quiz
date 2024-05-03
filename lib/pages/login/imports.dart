import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_quiz/models/user_model.dart';
import 'package:the_quiz/pages/home/imports.dart';
import 'package:the_quiz/services/auth_service.dart';
import 'package:the_quiz/services/db_service.dart';
import 'package:the_quiz/services/storage_service.dart';
import 'package:the_quiz/widgets/no_connection.dart';

part 'controller.dart';
part 'page.dart';
part 'widgets.dart';
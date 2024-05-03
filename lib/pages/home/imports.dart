import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_quiz/models/user_model.dart';
import 'package:the_quiz/pages/create_test/imports.dart';
import 'package:the_quiz/pages/detail_test/imports.dart';
import 'package:the_quiz/pages/join_test/imports.dart';
import 'package:the_quiz/services/db_service.dart';
import 'package:the_quiz/widgets/no_connection.dart';
import 'package:the_quiz/widgets/notch.dart';
import 'package:lottie/lottie.dart';

import '../../models/test_model.dart';
import '../my_recents/imports.dart';

part 'page.dart';
part 'widgets.dart';
part 'controller.dart';
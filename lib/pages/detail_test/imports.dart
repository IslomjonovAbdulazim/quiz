import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_quiz/models/applicant_model.dart';
import 'package:the_quiz/models/test_model.dart';
import 'package:the_quiz/pages/create_question/imports.dart';
import 'package:the_quiz/pages/detail_question/imports.dart';
import 'package:the_quiz/pages/recent/imports.dart';
import 'package:the_quiz/pages/recent_detail/imports.dart';
import 'package:the_quiz/services/db_service.dart';
import 'package:the_quiz/widgets/no_connection.dart';

import '../../models/live_model.dart';
import '../../models/question_model.dart';
import '../../widgets/notch.dart';
import '../create_test/imports.dart';

part 'controller.dart';
part 'page.dart';
part 'widgets.dart';
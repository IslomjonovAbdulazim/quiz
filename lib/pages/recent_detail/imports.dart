import 'dart:async';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_quiz/models/live_model.dart';
import 'package:the_quiz/widgets/no_connection.dart';

import '../../models/applicant_model.dart';
import '../../models/user_model.dart';
import '../../services/db_service.dart';
import '../../widgets/notch.dart';

part 'controller.dart';
part 'page.dart';
part 'widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/utils/http.interceptor.dart';

double sHeight(BuildContext context) => MediaQuery.of(context).size.height;
double sWidth(BuildContext context) => MediaQuery.of(context).size.width;

HttpInterceptor interceptor = HttpInterceptor();

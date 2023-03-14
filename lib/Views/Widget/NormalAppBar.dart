
import 'package:new_fixera/Views/Utilities/AppColors.dart';
import 'package:flutter/material.dart';


  Widget  nomralAppBar(String textShow) { 
    return AppBar(
    backgroundColor: AppColors.primaryColor,
    title: Text(textShow),
    centerTitle: true,
    ); 
  }

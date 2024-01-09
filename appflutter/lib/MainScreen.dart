import 'dart:convert';
import 'dart:math';

import 'package:appflutter/popup/HeartShape.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Screens/DetailScreen.dart';
import 'Screens/SpinWheelScreen.dart';

class RandomItemApp extends StatefulWidget {
  @override
  _RandomItemAppState createState() => _RandomItemAppState();
}

class _RandomItemAppState extends State<RandomItemApp>
    with SingleTickerProviderStateMixin {

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  List<Map<String, dynamic>> itemList = [
    {
      "STT": 1,
      "Loại": "Nướng",
      "Tên quán": "Nướng sạch Ke Pha",
      "Địa chỉ": "340 P. Thái Hà, Chợ Dừa, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 2,
      "Loại": "Bún",
      "Tên quán": "Bún riêu tóp mỡ",
      "Địa chỉ": "82 hàng mã",
      "Giá": ""
    },
    {
      "STT": 3,
      "Loại": "Bánh",
      "Tên quán": "Bánh bao phomai",
      "Địa chỉ": "26 ngõ 639 Hoàng Hoa Thám, Ba Đình",
      "Giá": "(12k-20k)"
    },
    {
      "STT": 4,
      "Loại": "Nem",
      "Tên quán": "Bánh xèo nem lụi",
      "Địa chỉ": "ngã tư bế văn đàn - nguyễn viết xuân",
      "Giá": ""
    },
    {
      "STT": 5,
      "Loại": "Nem",
      "Tên quán": "Nem nướng Hoa béo",
      "Địa chỉ": "117 P. Vũ Tông Phan, Khương Trung, Thanh Xuân",
      "Giá": "35k"
    },
    {
      "STT": 6,
      "Loại": "Coffe",
      "Tên quán": "Aha coffee",
      "Địa chỉ": "Văn Quán",
      "Giá": ""
    },
    {
      "STT": 7,
      "Loại": "Nem",
      "Tên quán": "Bánh xèo",
      "Địa chỉ": "Bánh Xèo 161 ở ngõ 67 Phùng Khoang",
      "Giá": ""
    },
    {
      "STT": 8,
      "Loại": "Coffe",
      "Tên quán": "nhà trong ngõ",
      "Địa chỉ": "76 Ngõ 23 Nguyễn Khuyến, P. Văn Quán, Hà Đông",
      "Giá": ""
    },
    {
      "STT": 9,
      "Loại": "Coffe",
      "Tên quán": "Trà sữa nướng phong vị",
      "Địa chỉ": "42 Thượng Đình, Thanh Xuân, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 10,
      "Loại": "Coffe",
      "Tên quán": "Hầm Trú Ẩn Hoàng Ngọc Phách",
      "Địa chỉ": "38 P. Hoàng Ngọc Phách, Láng Hạ, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 11,
      "Loại": "Coffe",
      "Tên quán": "Another Coffee",
      "Địa chỉ": "Số 1 ngách 49 ngõ 64 Nguyễn Lương Bằng, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 12,
      "Loại": "Coffe",
      "Tên quán": "Bgarden Cafe & Camping",
      "Địa chỉ": "142 An Dương Vương, Phú Xá, Tây Hồ",
      "Giá": ""
    },
    {
      "STT": 13,
      "Loại": "Bún",
      "Tên quán": "Bún chả Việt",
      "Địa chỉ": "Số 2 Cầu Giấy, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 14,
      "Loại": "Coffe",
      "Tên quán": "Tut Lang Thang Tea & Coffee",
      "Địa chỉ": " 132 Ng. 245 P. Định Công, Định Công",
      "Giá": ""
    },
    {
      "STT": 15,
      "Loại": "Nem",
      "Tên quán": "Bánh xèo cô yến",
      "Địa chỉ": "38 hàng chuối",
      "Giá": ""
    },
    {
      "STT": 16,
      "Loại": "Bún",
      "Tên quán": "Bún Bò Huế Thu Thùy",
      "Địa chỉ": "18 Đại Cồ Việt, Lê Đại Hành, Hai Bà Trưng,",
      "Giá": ""
    },
    {
      "STT": 17,
      "Loại": "Bún",
      "Tên quán": "Bún bò huế An cự",
      "Địa chỉ": "153 P. Hoàng Ngân, Trung Hoà",
      "Giá": ""
    },
    {
      "STT": 18,
      "Loại": "Coffe",
      "Tên quán": "MIRA Florist & Garden",
      "Địa chỉ": "18 Đại Cồ Việt, Lê Đại Hành, Hai Bà Trưng",
      "Giá": ""
    },
    {
      "STT": 19,
      "Loại": "Bún",
      "Tên quán": "Bún cá cay",
      "Địa chỉ": "178 Xã Đàn ,Đống đa",
      "Giá": ""
    },
    {
      "STT": 20,
      "Loại": "Nướng",
      "Tên quán": "Chân, cánh gà nướng – Zụt Quán",
      "Địa chỉ": "468 Xã Đàn, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 21,
      "Loại": "Coffe",
      "Tên quán": "Quán cafe Mèo và Sách",
      "Địa chỉ": "Số 63 Trúc Bạch, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 22,
      "Loại": "Coffe",
      "Tên quán": "Coffe Nhà Kho",
      "Địa chỉ": "599 Đê La Thành",
      "Giá": ""
    },
    {
      "STT": 23,
      "Loại": "Coffe",
      "Tên quán": "Coffe Zoom Bao cấp",
      "Địa chỉ": "P110 nhà C6 Vũ Ngọc Phan",
      "Giá": ""
    },
    {
      "STT": 24,
      "Loại": "Coffe",
      "Tên quán": "ATC coffe",
      "Địa chỉ": "B06 - L01 Khu An Vượng, Hà Đông",
      "Giá": ""
    },
    {
      "STT": 25,
      "Loại": "Nướng",
      "Tên quán": "Lòng nướng ",
      "Địa chỉ": "389 Khương Trung",
      "Giá": ""
    },
    {
      "STT": 26,
      "Loại": "Nướng",
      "Tên quán": "lẩu nướng, TUGI house",
      "Địa chỉ": "Võ thị Sáu",
      "Giá": ""
    },
    {
      "STT": 27,
      "Loại": "Nướng",
      "Tên quán": "Lẩu Nướng Bình Boong Quán",
      "Địa chỉ": "209 Đ. Nguyễn Ngọc Vũ, Trung Hoà, Cầu Giấy,",
      "Giá": ""
    },
    {
      "STT": 28,
      "Loại": "Coffe",
      "Tên quán": "Acof Atelier",
      "Địa chỉ": "Ngõ 1 Khuất Duy Tiến, vào ngõ rẽ trái(112 C4, khu tập thể thanh xuân bắc)",
      "Giá": ""
    },
    {
      "STT": 29,
      "Loại": "Nướng",
      "Tên quán": "Buffet Lẩu- Nướng Thìn Béo",
      "Địa chỉ":"",
      "Giá": ""
    },
    {
      "STT": 30,
      "Loại": "Bún",
      "Tên quán": "Bún Riêu Huyền Anh",
      "Địa chỉ": " 89 Bế Văn Đàn, Hà Đông",
      "Giá": ""
    },
    {
      "STT": 31,
      "Loại": "Gà",
      "Tên quán": "hoolala chicken Block B",
      "Địa chỉ": ", Mễ Trì, Từ Liêm, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 32,
      "Loại": "Chè",
      "Tên quán": "quàn chè , bánh đúc lá nếp",
      "Địa chỉ": "115 Nguyễn Lương Bằng, Quang Trung, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 33,
      "Loại": "Bún",
      "Tên quán": "sóc bún riêu",
      "Địa chỉ": "117 Nguyễn Lương Bằng, Quang Trung, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 34,
      "Loại": "Đồ hàn, gà rán",
      "Tên quán": "mukkbang đồ ăn hàn",
      "Địa chỉ": "số 1 ngõ 69 chùa láng đống đa",
      "Giá": ""
    },
    {
      "STT": 35,
      "Loại": "Bún",
      "Tên quán": "Bún bò",
      "Địa chỉ": " 68 ngõ 69 triều khúc",
      "Giá": ""
    },
    {
      "STT": 36,
      "Loại": "Nướng",
      "Tên quán": "Maya Beer Restaurant",
      "Địa chỉ": "41 P. Lưu Quang Vũ, Trung Hoà, Cầu Giấy",
      "Giá": ""
    },
    {
      "STT": 37,
      "Loại": "Coffe",
      "Tên quán": "Seul.coffe",
      "Địa chỉ": "9 lô 2 KĐT Yên Hòa, Trung Kính, Cầu giấy",
      "Giá": ""
    },
    {
      "STT": 38,
      "Loại": "Coffe",
      "Tên quán": "La Grupa",
      "Địa chỉ": "148 Trung Liệt",
      "Giá": ""
    },
    {
      "STT": 39,
      "Loại": "Gà",
      "Tên quán": "Ririmimi",
      "Địa chỉ": "16 Cầu giấy",
      "Giá": ""
    },
    {
      "STT": 40,
      "Loại": "Gà",
      "Tên quán": "Backdon",
      "Địa chỉ": " 19 ngõ 180 đình thôn",
      "Giá": ""
    },
    {
      "STT": 41,
      "Loại": "Bún",
      "Tên quán": "Bún chả cá lăng",
      "Địa chỉ": " 80 láng hạ",
      "Giá": ""
    },
    {
      "STT": 42,
      "Loại": "Coffe",
      "Tên quán": "Grootto Cafe",
      "Địa chỉ": " số 20 ngõ 91 Nguyễn Chí Thanh",
      "Giá": ""
    },
    {
      "STT": 43,
      "Loại": "Coffe",
      "Tên quán": "𝐍𝐨𝐧𝐚 𝐂𝐚𝐟𝐞́ 𝐁𝐨𝐚𝐫𝐝𝐠𝐚𝐦𝐞",
      "Địa chỉ": "Số 9 nhà 10 ngõ 95 Chùa Bộc",
      "Giá": ""
    },
    {
      "STT": 44,
      "Loại": "Bún",
      "Tên quán": "Bún cá Chú Lùn",
      "Địa chỉ": "38 đường 2.5 kđt định công.",
      "Giá": ""
    },
    {
      "STT": 45,
      "Loại": "Bún",
      "Tên quán": "Bún chả Việt",
      "Địa chỉ": " 2 Cầu giấy.",
      "Giá": ""
    },
    {
      "STT": 46,
      "Loại": "Bún",
      "Tên quán": "Bún Chả -",
      "Địa chỉ": "110 E3 Thái Thịnh, Đống Đa ",
      "Giá": "(8h - 15h) (35k - 50k)"
    },
    {
      "STT": 47,
      "Loại": "Đồ hàn, gà rán",
      "Tên quán": "B - Box",
      "Địa chỉ": " Liền kề 81 Bắc Hà, An Hoà – Mộ Lao – Hà Đông",
      "Giá": ""
    },
    {
      "STT": 48,
      "Loại": "Bánh",
      "Tên quán": "Bánh Gối, Bánh Tôm -",
      "Địa chỉ": " 9B Hoè Nhai, Ba Đình",
      "Giá": "(8h - 19h) (13k - 20k)"
    },
    {
      "STT": 49,
      "Loại": "Bún",
      "Tên quán": "Quán bún bò gốc Huế",
      "Địa chỉ": ": 149 Nguyễn Ngọc Vũ, Trung Hoà, Cầu Giấy, HN.",
      "Giá": "💸 35k-55k(⏰ 7h-15h & 17h-21h30)"
    },
    {
      "STT": 50,
      "Loại": "Lẩu",
      "Tên quán": "Lẩu ếch châu long",
      "Địa chỉ": " - 33 P. Châu Long, Trúc Bạch, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 51,
      "Loại": "Lẩu",
      "Tên quán": "Lẩu Ếch Hương Mực -",
      "Địa chỉ": " 44 Châu Long, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 52,
      "Loại": "Coffe",
      "Tên quán": "Sam Rooftop Coffee",
      "Địa chỉ": "58 Ng. 298 Tây Sơn, Ngã Tư Sở, Đống Đa, Hà Nội, Việt Nam",
      "Giá": ""
    },
    {
      "STT": 53,
      "Loại": "Gà",
      "Tên quán": "chân gà nướng",
      "Địa chỉ": " số 5 lý văn phúc",
      "Giá": ""
    },
    {
      "STT": 54,
      "Loại": "Nướng",
      "Tên quán": "Bò nướng",
      "Địa chỉ": "bò nướng 13 hàng lược gầm cầu",
      "Giá": ""
    },
    {
      "STT": 55,
      "Loại": "Nướng",
      "Tên quán": "Nướng",
      "Địa chỉ": " 217b khâm thiên",
      "Giá": ""
    },
    {
      "STT": 56,
      "Loại": "Nướng",
      "Tên quán": "Nướng",
      "Địa chỉ": "90 trần hưng đạo",
      "Giá": ""
    },
    {
      "STT": 57,
      "Loại": "Nướng",
      "Tên quán": "Nướng",
      "Địa chỉ": "200 Phó Đức Chính, Nguyễn Trung Trực, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 58,
      "Loại": "Nướng",
      "Tên quán": "Bò nướng",
      "Địa chỉ": "3 P. Gầm Cầu, Hàng Mã, Hoàn Kiếm",
      "Giá": ""
    },
    {
      "STT": 59,
      "Loại": "Đồ hàn, gà rán",
      "Tên quán": "Oanh Quán",
      "Địa chỉ": "157 Nguyễn Đình Thi, Tây Hồ, HN",
      "Giá": ""
    },
    {
      "STT": 60,
      "Loại": "Coffe",
      "Tên quán": "Xin chào Cafe",
      "Địa chỉ": "Vinhome Smart city",
      "Giá": ""
    },
    {
      "STT": 61,
      "Loại": "Đồ hàn, gà rán",
      "Tên quán": "Quán Ngon 28",
      "Địa chỉ": "Kiot 28 B14 Ng. 65 P. Phạm Ngọc Thạch, Kim Liên, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 62,
      "Loại": "Bún",
      "Tên quán": "bún cá cay",
      "Địa chỉ": "178 P. Xã Đàn, Phương Liên, Đống Đa, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 63,
      "Loại": "Bún",
      "Tên quán": "Bún cá chấm giòn tan",
      "Địa chỉ": "90 Nguyễn Văn Tuyết, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 64,
      "Loại": "Coffe",
      "Tên quán": "𝐙𝐄𝐑𝐎 𝐏𝐎𝐈𝐍𝐓",
      "Địa chỉ": "33 Ngõ 165 Cầu Giấy, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 65,
      "Loại": "Đồ hàn, gà rán",
      "Tên quán": "Yolo quán",
      "Địa chỉ": "Yolo Quán 361 Vũ Tông Phan",
      "Giá": ""
    },
    {
      "STT": 66,
      "Loại": "Bún",
      "Tên quán": "bún chả",
      "Địa chỉ": "42 Bùi Ngọc Dương, Q. Hai Bà Trưng, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 67,
      "Loại": "Búnn",
      "Tên quán": "bún chả",
      "Địa chỉ": "Ngõ 74 Hàng Quạt, Hoàn Kiếm",
      "Giá": ""
    },
    {
      "STT": 68,
      "Loại": "Bún",
      "Tên quán": "Bún riêu tóp mỡ mọc giòn cô Hương Béo",
      "Địa chỉ": "ki ốt 41 đường Cốm Vòng - Dịch Vọng Hậu - Cầu Giấy",
      "Giá": ""
    },
    {
      "STT": 69,
      "Loại": "Bún",
      "Tên quán": "bún riêu",
      "Địa chỉ": "149 Phố Triệu Việt Vương",
      "Giá": ""
    },
    {
      "STT": 70,
      "Loại": "Coffe",
      "Tên quán": "caffe 30",
      "Địa chỉ": "Số 30, Ngõ 179 Quan Nhân",
      "Giá": ""
    },
    {
      "STT": 71,
      "Loại": "Nem",
      "Tên quán": "Annamoi",
      "Địa chỉ": "21-23 Hàng Bún",
      "Giá": "💸40-50k"
    },
    {
      "STT": 72,
      "Loại": "Coffe",
      "Tên quán": "TeTe Café",
      "Địa chỉ": "Số 4\/1 ngõ 3 Vạn Phúc, Ba Đình, HN ( Ngay đầu ngõ, rất dễ tìm )",
      "Giá": "⌚️ 7h30 – 17h30(💵 45-60k)"
    },
    {
      "STT": 73,
      "Loại": "Gà",
      "Tên quán": "Gà Rán Bốp Bi",
      "Địa chỉ": "234 Thuỵ Khê, Tây Hồ",
      "Giá": "(76 -200k)"
    },
    {
      "STT": 74,
      "Loại": "Coffe",
      "Tên quán": "Geisha Cat Cafe",
      "Địa chỉ": "23 Nguyễn Hoàng Tôn Hà Nội",
      "Giá": ""
    },
    {
      "STT": 75,
      "Loại": "Coffe",
      "Tên quán": "Paradise Rooftop Bar",
      "Địa chỉ": "Tầng 9 toà nhà số 93 Thuỵ Khuê, Tây Hồ",
      "Giá": "16:30-23:30"
    },
    {
      "STT": 76,
      "Loại": "Coffe",
      "Tên quán": "Lofi House",
      "Địa chỉ": "259 Trích Sài Tây Hồ",
      "Giá": ""
    },
    {
      "STT": 77,
      "Loại": "Coffe",
      "Tên quán": "Bread Factory - Xưởng bánh mì tươi",
      "Địa chỉ": "104 TT3, P. Hoàng Trọng Mậu, Mỹ Đình, Từ Liêm",
      "Giá": ""
    },
    {
      "STT": 78,
      "Loại": "Coffe",
      "Tên quán": "Aventus Coffee",
      "Địa chỉ": "7 P. Huỳnh Thúc Kháng, Láng Thượng",
      "Giá": ""
    },
    {
      "STT": 79,
      "Loại": "Coffe",
      "Tên quán": "Góc Bình Yên Cafe",
      "Địa chỉ": "9-D6B Khu biệt thự vườn đào Tây Hồ, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 80,
      "Loại": "Coffe",
      "Tên quán": "One Day at a time",
      "Địa chỉ": "Số 36A, ngõ 67 phố Đ. Tô Ngọc Vân, Tây Hồ",
      "Giá": ""
    },
    {
      "STT": 81,
      "Loại": "Coffe",
      "Tên quán": "Tree Bee Coffee",
      "Địa chỉ": "Đối diện toà nhà Vinaphone chân, 40 Cầu vượt Nguyễn Văn Huyên, Xuân La",
      "Giá": ""
    },
    {
      "STT": 82,
      "Loại": "Bún",
      "Tên quán": "Bún ốc",
      "Địa chỉ": "bún ốc 52 nguyễn siêu",
      "Giá": ""
    },
    {
      "STT": 83,
      "Loại": "Coffe",
      "Tên quán": "Cà Phê Thư Báo",
      "Địa chỉ": "27 Ngõ 198 Thái Thịnh, Láng Hạ, Đống Đa, Hà Nội, Việt Nam",
      "Giá": ""
    },
    {
      "STT": 84,
      "Loại": "Gà",
      "Tên quán": "chân gà nướng việt hà",
      "Địa chỉ": "18 lý văn phúc",
      "Giá": ""
    },
    {
      "STT": 85,
      "Loại": "Nướng",
      "Tên quán": "Đốm Cafe&Kitchen",
      "Địa chỉ": "109D7, Ngõ 61 P. Thái Thịnh, Thịnh Quang, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 86,
      "Loại": "Gà",
      "Tên quán": "Nhà Hàng Gà Nollowa",
      "Địa chỉ": "Số 3 lô 12A đường, P. Thâm Tâm, Trung Hoà, Cầu Giấy",
      "Giá": ""
    },
    {
      "STT": 87,
      "Loại": "Bún",
      "Tên quán": "Bún riêu cua thóc",
      "Địa chỉ": "ngõ 3 nguyễn văn huyên cầu giấy",
      "Giá": ""
    },
    {
      "STT": 88,
      "Loại": "Gà",
      "Tên quán": "King Dakgalbi",
      "Địa chỉ": "Số 22 Nguyễn Chí Thanh, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 89,
      "Loại": "Bún",
      "Tên quán": "Bún cá bà tâm",
      "Địa chỉ": "80 láng hạ, đống đa.",
      "Giá": ""
    },
    {
      "STT": 90,
      "Loại": "Gà",
      "Tên quán": "Kyodong chicken",
      "Địa chỉ": "Ngõ 179 Đ. Đình Thôn, Mỹ Đình",
      "Giá": ""
    },
    {
      "STT": 91,
      "Loại": "Bún",
      "Tên quán": "Bún Cá Chấm - Bún Đậu Bà Tâm",
      "Địa chỉ": "80 P. Láng Hạ, Láng Hạ, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 92,
      "Loại": "Chè",
      "Tên quán": "chè cô huê",
      "Địa chỉ": "chợ thành công B",
      "Giá": ""
    },
    {
      "STT": 93,
      "Loại": "Nướng",
      "Tên quán": "Trứng chén nướng",
      "Địa chỉ": "7A đào duy từ -hàng buồm",
      "Giá": ""
    },
    {
      "STT": 94,
      "Loại": "Nem",
      "Tên quán": "Bánh xèo Tôm nhảy Quy Nhơn",
      "Địa chỉ": "55 Hai Bà Trưng,Hoàn Kiếm",
      "Giá": ""
    },
    {
      "STT": 95,
      "Loại": "Bún",
      "Tên quán": "Bún riêu",
      "Địa chỉ": "110E3 Lê Thanh Nghị ( đối diện 40 Lê Thanh Nghị)",
      "Giá": ""
    },
    {
      "STT": 96,
      "Loại": "Bún",
      "Tên quán": "Bún Riêu Hương Vị Xưa Huy Béo",
      "Địa chỉ": "92 Tân Triều, Triều Khúc",
      "Giá": ""
    },
    {
      "STT": 97,
      "Loại": "Coffe",
      "Tên quán": "Xu Cafe 1978",
      "Địa chỉ": "Ngõ 165 Phố Thái Hà, Láng Hạ, Đống Đa, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 98,
      "Loại": "Coffe",
      "Tên quán": "Little Pie",
      "Địa chỉ": "267 P. Bồ Đề, Bồ Đề, Long Biên",
      "Giá": ""
    },
    {
      "STT": 99,
      "Loại": "Coffe",
      "Tên quán": "Góc vuông",
      "Địa chỉ": "ngõ 6 P. Tôn Thất Tùng, Kim Liên, Đống Đa,",
      "Giá": ""
    },
    {
      "STT": 100,
      "Loại": "Coffe",
      "Tên quán": "Dark Light Coffee",
      "Địa chỉ": "31 Phố Trương Hán Siêu, Trần Hưng Đạo, Hoàn Kiếm, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 101,
      "Loại": "Coffe",
      "Tên quán": "Hầm Trú Ẩn Cafe",
      "Địa chỉ": "78 Ngõ Trung Tiền, Khâm Thiên, Đống Đa, Hà Nội",
      "Giá": ""
    },
    {
      "STT": 102,
      "Loại": "Coffe",
      "Tên quán": "Telescope",
      "Địa chỉ": "17A, 67 Tô Ngọc Vân (99k-129k\/ đồ uống)",
      "Giá": ""
    },
    {
      "STT": 103,
      "Loại": "Bún",
      "Tên quán": "Bún",
      "Địa chỉ": "Số 1 Trưng Nhị - hà đông",
      "Giá": ""
    },
    {
      "STT": 104,
      "Loại": "Coffe",
      "Tên quán": "CAFE CAMY - GOOD OLD DAYS",
      "Địa chỉ": "126 Trần Nhật Duật , Hoàn Kiếm - Hà Nội",
      "Giá": "8:00-22:30(Pass wifi : 126trannhatduat)"
    },
    {
      "STT": 105,
      "Loại": "Bún",
      "Tên quán": "Bánh đa cua tóp mỡ",
      "Địa chỉ": "460 Trần Khát Chân",
      "Giá": "Giờ bán 10h sáng- 3h chiều",
      "Giá": ""
    },
    {
      "STT": 106,
      "Loại": "Lẩu",
      "Tên quán": "Lẩu Gà Lá É É É Thắng Béo",
      "Địa chỉ": "6 Ng. 84 P.Trần Thái Tông, Dịch Vọng Hậu, Cầu Giấy",
      "Giá": ""
    },
    {
      "STT": 107,
      "Loại": "Coffe",
      "Tên quán": "𝑴𝒊 𝑨𝒎𝒊 𝒄𝒂𝒇𝒇𝒆 - 𝑨 𝒕𝙖𝒔𝙩𝒆 𝒐𝙛 𝙃𝒂𝙣𝒐𝙞",
      "Địa chỉ": "BT4.17 Ngoại Giao Đoàn - Xuân Tảo - Bắc Từ Liêm - Hà Nội",
      "Giá": ""
    },
    {
      "STT": 108,
      "Loại": "Coffe",
      "Tên quán": "OURLOG",
      "Địa chỉ": "ngõ 4D Đặng Văn Ngữ, Đống Đa, Hà Nội",
      "Giá": "💰35k -59k (hỏi nv gửi xe)- 9h 21h"
    },
    {
      "STT": 109,
      "Loại": "Lẩu",
      "Tên quán": "lẩu ốc",
      "Địa chỉ": "36 Sơn Tây",
      "Giá": ""
    },
    {
      "STT": 110,
      "Loại": "Bún",
      "Tên quán": "Quán mẹ Lê - Bún riêu Bề Bề",
      "Địa chỉ": "Số 2 - Ngõ 162\/17 Nguyễn Tuân - Thanh Xuân",
      "Giá": ""
    },
    {
      "STT": 111,
      "Loại": "Vịt",
      "Tên quán": "Ngan Mười Tám",
      "Địa chỉ": "Số 1C Ngõ 87 Láng Hạ, Đống Đa",
      "Giá": "rưa 10h-14h tối 18h-4h sáng",
    },
    {
      "STT": 112,
      "Loại": "Bún",
      "Tên quán": "Bún Riêu Tuấn Anh",
      "Địa chỉ": "35-37 Hồng Mai, Hai Bà Trưng",
      "Giá": ""
    },
    {
      "STT": 113,
      "Loại": "Bún",
      "Tên quán": "Bún riêu tóp mỡ mọc giòn cô hương béo",
      "Địa chỉ": "41 đường cốm vòng, dịch vọng hậu.",
      "Giá": ""
    },
    {
      "STT": 114,
      "Loại": "Bún",
      "Tên quán": "Quán Lê Gia",
      "Địa chỉ": "Số 16 Ngõ 298 Tây Sơn, Đống Đa (phố Nguyễn Văn Tuyết mới) ",
      "Giá": "(8h-14h&17h-23h)"
    },
    {
      "STT": 115,
      "Loại": "Bún",
      "Tên quán": "Bún bò huế - O Hiền",
      "Địa chỉ": "Số 106 C6 Tô Hiệu, Cầu Giấy",
      "Giá": ""
    },
    {
      "STT": 116,
      "Loại": "Lẩu",
      "Tên quán": "Lẩu Nướng Tít Mít - Lẩu nướng chảo gang",
      "Địa chỉ": "176 Hoàng Quốc Việt",
      "Giá": "129k"
    },
    {
      "STT": 117,
      "Loại": "Gà",
      "Tên quán": "Nhà hàng Kiên Gà",
      "Địa chỉ": "47 Cửa Bắc, Trúc Bạch, Ba Đình",
      "Giá": ""
    },
    {
      "STT": 118,
      "Loại": "Gà",
      "Tên quán": "Bếp mẹ Đăng Chân Gà",
      "Địa chỉ": "38 P. Nhân Hòa, Nhân Chính, Thanh Xuân",
      "Giá": ""
    },
    {
      "STT": 119,
      "Loại": "Nướng",
      "Tên quán": "Bếp Mẹ Gạo",
      "Địa chỉ": "38B P. Trần Hữu Tước, Nam Đồng, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 120,
      "Loại": "Gà",
      "Tên quán": "Chân Gà Tú Béo",
      "Địa chỉ": "116 Hàng Bạc, Hoàn Kiếm (gần Tạ Hiện)",
      "Giá": ""
    },
    {
      "STT": 121,
      "Loại": "Bún",
      "Tên quán": "Bún cá cay",
      "Địa chỉ": "128 Đ. Nguyễn Chí Thanh, Láng Hạ, Đống Đa",
      "Giá": ""
    },
    {
      "STT": 122,
      "Loại": "Bánh",
      "Tên quán": "Kem trứng Bà Khanh",
      "Địa chỉ": "Số 55B Hai Bà Trưng,",
      "Giá": ""
    },
    {
      "STT": 123,
      "Loại": "Lẩu",
      "Tên quán": "Umai29",
      "Địa chỉ":"",
      "Giá": ""
    },
    {
      "STT": 124,
      "Loại": "Bún",
      "Tên quán": "Bún Ốc",
      "Địa chỉ": "Ngõ1A Tôn Thất Tùng",
      "Giá": ""
    },
    {
      "STT": 125,
      "Loại": "Vịt",
      "Tên quán": "Kaoya Hotpot ",
      "Địa chỉ": "C11 Lương định của",
      "Giá": "bánh cuốn vịt ngon",
      "Giá": "65k (ăn bánh cuốn vịt ngon)"
    }
  ];

  List<String> loaiList = ["Chọn loại quán", "Nướng", "Bún","Gà","Vịt","Lẩu","Coffe","Bánh","Đồ hàn, gà rán","Chè","Nem"]; // Thêm các loại khác nếu cần
  String selectedLoai = "Chọn loại quán";

  Map<String, dynamic> selectedItem = {
    "STT": 0,
    "Loại": "Chọn loại quán",
    "Tên quán": "Tên cửa hàng",
    "Địa chỉ": "Địa chỉ",
    "Giá":"",
  };

  void showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          HeartShapeDialog(
            title: 'CHọn loại quán đi',
            content: 'Không biết đi đâu thì đi hotel nhá !',
          );
      },
    );
  }
  int calculateDaysFromDate(DateTime targetDate) {
    final currentDate = DateTime.now().add(Duration(days: 1));
    final difference = currentDate.difference(targetDate).inDays;
    return difference.abs();
  }

  void getRandomItem() {
    if (selectedLoai == "Chọn loại quán") {
      // Hiển thị hộp thoại thông báo nếu chưa chọn loại quán
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HeartShapeDialog(
            title: 'Thông báo',
            content: 'Không chọn quán là đánh đòn nhá !',
          );
        },
      );
      return;
    }

    List<Map<String, dynamic>> filteredList = itemList
        .where((item) => item["Loại"] == selectedLoai)
        .toList();

    if (filteredList.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(filteredList.length);
      setState(() {
        selectedItem = filteredList[randomIndex];
      });
    } else {
      setState(() {
        selectedItem = {
          "STT": 0,
          "Loại": "No item of selected type",
          "Tên quán": "",
          "Địa chỉ": "",
          "Giá":""
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Chọn địa điểm đi ăn đi chơi'),
      //  backgroundColor: Colors.greenAccent[200],
      //),
      body:
          Stack(
            children: [
          // Background Lottie Animation
          Positioned.fill(
          child: Lottie.asset(
            'asset/nhieutim.json', // Replace with your Lottie animation file
            fit: BoxFit.cover,
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ),
        SingleChildScrollView(
          child:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 300,
                  color: Colors.redAccent[100],
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Animation
                      Container(
                        height: 300,
                        color: Colors.redAccent[100],
                        child: Lottie.asset(
                          'asset/heart2.json',
                          width: 150,
                          height: 200,
                          repeat: true,
                          reverse: true,
                          animate: true,
                        ),
                      ),
                      // Left Image
                      Positioned(
                        left: 0,
                        child: Image.asset(
                          'asset/avtllac.gif',
                          width: 170, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                        ),
                      ),
                      // Right Image
                      Positioned(
                        right: 0,
                        child: Image.asset(
                          'asset/avthla.gif',
                          width: 170, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                        ),
                      ),
                      // Center Text
                      Text(
                        '${calculateDaysFromDate(DateTime(2023, 6, 4))}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12), // Đặt góc tròn
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: selectedLoai,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLoai = newValue!;
                            });
                          },
                          items: loaiList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpinWheelScreen(),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              selectedLoai = result;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange, // Choose a color for the button
                          minimumSize: Size(10, 40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'asset/spinwheel.png', // Replace 'your_icon.png' with your image asset path
                              width: 20, // Set the width of the image
                              height: 20, // Set the height of the image
                            ),
                            SizedBox(width: 5), // Add some space between the icon and text
                            Text(
                              'Quay loại quán',
                              style: TextStyle(fontSize: 14), // Set the font size of the text
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    ElevatedButton(
                      onPressed: getRandomItem,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Choose a color for the button
                        minimumSize: Size(10, 40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/dice.png',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Quán ngẫu nhiên',
                            style: TextStyle(fontSize: 16,color: Colors.white), // Set the font size of the text
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showPopup(); // Gọi hàm showPopup khi nút được nhấn
                      },
                      icon: Icon(Icons.heart_broken, color: Colors.white,), // Thêm biểu tượng tìm kiếm
                      label: Text(
                        'Em không biết',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[400],
                        minimumSize: Size(150, 40), // Đặt kích thước tối thiểu của nút
                        padding: EdgeInsets.symmetric(vertical: 10), // Đặt padding
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child:
                  Column(
                    children: [
                      Card(
                        elevation: 5, // Độ nổi của card
                        margin: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(selectedItem: selectedItem),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('STT:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text('${selectedItem["STT"]}'),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Loại:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text('${selectedItem["Loại"]}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tên quán: ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${selectedItem["Tên quán"]}',
                                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Địa chỉ: ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${selectedItem["Địa chỉ"]}',
                                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Giá:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text('${selectedItem["Giá"]}',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Lottie.asset(
                        'asset/lineheart.json', // Thay bằng đường dẫn đến tệp animation của bạn
                        width: 150,
                        height: 130,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
            ],
          ),
    );
  }
}
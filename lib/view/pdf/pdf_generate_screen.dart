import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:resumemaker/view/pdf/pdf_generate_controller.dart';

import '../../res/app_loader.dart';
import '../../res/icon_button.dart';
import '../../utils/utils.dart';

class PdfGenerateScreen extends StatelessWidget {
  PdfGenerateScreen({super.key});

  final PdfGenerateController con = Get.put(PdfGenerateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resume Detail",
        ),
        leading: AppIconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: PdfPreview(
        previewPageMargin: const EdgeInsets.only(bottom: 15),
        allowPrinting: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        pdfPreviewPageDecoration: const BoxDecoration(color: Colors.white),
        loadingWidget: const CircularLoader(),
        build: (PdfPageFormat format) async {
          final pw.Document doc = pw.Document(pageMode: PdfPageMode.fullscreen);

          doc.addPage(
            index: 0,
            pw.MultiPage(
              pageTheme: pw.PageTheme(
                margin: const pw.EdgeInsets.symmetric(
                        horizontal: 1 * PdfPageFormat.cm,
                        vertical: 0.5 * PdfPageFormat.cm)
                    .copyWith(top: defaultPadding),
                textDirection: pw.TextDirection.ltr,
                orientation: pw.PageOrientation.portrait,
                pageFormat: format.copyWith(
                  marginBottom: 0,
                  marginLeft: 40,
                  marginRight: 40,
                  marginTop: 0,
                ),
              ),
              build: (context) {
                return [
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          height: Get.height,
                          width: Get.height / 3,
                          decoration: const pw.BoxDecoration(
                            color: PdfColor.fromInt(000000),
                          ),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultPadding),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "PROFILE",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                pw.Divider(
                                  height: 2,
                                  color: const PdfColor.fromInt(0xffFFFFFF),
                                  thickness: 3,
                                ),
                                pw.SizedBox(
                                  height: defaultPadding * 2,
                                ),
                                pw.Text(
                                  "Name",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.Text(
                                  con.resumeModel.value.name ?? "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Text(
                                  "Phone Number",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.Text(
                                  con.resumeModel.value.mobileNumber ?? "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Text(
                                  "Email",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.Text(
                                  con.resumeModel.value.email ?? "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Text(
                                  "Designation",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.Text(
                                  con.resumeModel.value.designation ?? "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Text(
                                  "DOB",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                pw.Text(
                                  con.resumeModel.value.dateOfBirth
                                          ?.split(" ")
                                          .first ??
                                      "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xffFFFFFF),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          height: Get.height,
                          width: Get.height / 3,
                          decoration: const pw.BoxDecoration(
                            color: PdfColor.fromInt(0xffFFFFFF),
                          ),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultPadding),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "JOB EXPERIENCE",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xff000000),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                pw.Divider(
                                  height: 2,
                                  color: const PdfColor.fromInt(0xff000000),
                                  thickness: 3,
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                if (con.resumeModel.value.fresherOrExperience ==
                                    "Fresher")
                                  pw.Text(
                                    con.resumeModel.value.fresherOrExperience ??
                                        "",
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff000000),
                                      fontWeight: pw.FontWeight.normal,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                if (con.resumeModel.value.fresherOrExperience ==
                                    "Experience")
                                  pw.Text(
                                    "${con.resumeModel.value.fresherOrExperience ?? ""} - ${con.resumeModel.value.experienceOfYear ?? ""}",
                                    style: pw.TextStyle(
                                      color: const PdfColor.fromInt(0xff000000),
                                      fontWeight: pw.FontWeight.normal,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                pw.SizedBox(
                                  height: defaultPadding * 2,
                                ),
                                pw.Text(
                                  "EDUCATION",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xff000000),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                pw.Divider(
                                  height: 2,
                                  color: const PdfColor.fromInt(0xff000000),
                                  thickness: 3,
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Expanded(
                                      flex: 1,
                                      child: pw.Text(
                                        "${con.resumeModel.value.startYear ?? ""} - ${con.resumeModel.value.endYear ?? ""}",
                                        style: pw.TextStyle(
                                          color: const PdfColor.fromInt(
                                              0xff000000),
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Padding(
                                        padding: const pw.EdgeInsets.symmetric(
                                            horizontal: defaultPadding),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              con.resumeModel.value
                                                      .collegeName ??
                                                  "",
                                              style: pw.TextStyle(
                                                color: const PdfColor.fromInt(
                                                    0xff000000),
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                            pw.Text(
                                              con.resumeModel.value.degree ??
                                                  "",
                                              style: pw.TextStyle(
                                                color: const PdfColor.fromInt(
                                                    0xff000000),
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: defaultPadding * 2,
                                ),
                                pw.Text(
                                  "SKILL",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xff000000),
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                pw.Divider(
                                  height: 2,
                                  color: const PdfColor.fromInt(0xff000000),
                                  thickness: 3,
                                ),
                                pw.SizedBox(
                                  height: defaultPadding,
                                ),
                                pw.Text(
                                  con.resumeModel.value.skill ?? "",
                                  style: pw.TextStyle(
                                    color: const PdfColor.fromInt(0xff000000),
                                    fontWeight: pw.FontWeight.normal,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ];
              },
            ),
          );
          return await doc.save();
        },
      ),
    );
  }
}

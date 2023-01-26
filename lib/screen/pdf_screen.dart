import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_app/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class PDFScreen extends StatefulWidget {
  static const String id = 'pdf_screen';
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  pw.Document pdf;
  PdfImage imagen;
  Uint8List archivoPdf;

  double sizeIcon1 = 45;
  double sizeIcon2 = 30;
  double sizeIcon3 = 30;

  @override
  void initState() {
    initPDF();
  }

  Future<void> initPDF() async {
    archivoPdf = await generarPdf1();
  }

  void iconoSeleccionado(int numero) {
    if (numero == 1) {
      sizeIcon1 = 45;
      sizeIcon2 = 30;
      sizeIcon3 = 30;
    } else if (numero == 2) {
      sizeIcon1 = 30;
      sizeIcon2 = 45;
      sizeIcon3 = 30;
    } else {
      sizeIcon1 = 30;
      sizeIcon2 = 30;
      sizeIcon3 = 45;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('TRABAJO DE APLICACIONES MOVILES'),
        backgroundColor: Color.fromARGB(206, 60, 24, 190),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  child: PdfPreview(
                    build: (format) => archivoPdf,
                    useActions: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf1();
                        setState(
                          () {
                            iconoSeleccionado(1);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Row(children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: sizeIcon1,
                          color: Colors.red,
                        ),
                        Text("Hoja de Mayerli")
                      ]),
                    ),
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf2();
                        setState(
                          () {
                            iconoSeleccionado(2);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Row(children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: sizeIcon2,
                          color: Colors.black,
                        ),
                        Text("Hoja de Jorge")
                      ]),
                    ),
                    GestureDetector(
                      onTap: () async {
                        archivoPdf = await generarPdf3();

                        setState(
                          () {
                            iconoSeleccionado(3);
                            archivoPdf = archivoPdf;
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.picture_as_pdf,
                            size: sizeIcon3,
                            color: Colors.blue,
                          ),
                          Text("Hoja de Leoni"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await Printing.sharePdf(
                      bytes: archivoPdf, filename: 'Documento.pdf');
                },
                child: Column(
                  children:[Icon(
                  Icons.download,
                  color: Colors.black,
                  size: 40,
                ),
                Text("Presione Aqui "),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> generarPdf1() async {
    pdf = pw.Document();

    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 198,
                  child: pw.Container(
                    color: PdfColors.blue900,
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Column(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Image(
                              imagen,
                              height: 70,
                              width: 70,
                            ),
                          ),
                          pw.Column(children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tContactos\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text("\tGithub:\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\thttps://github.com/mayerli-mendez\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tCorreo Electronico:\n"),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child:
                                    pw.Text("\tmayerli14.paredes@gmail.com\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDirreccion:\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text(
                                  "\tQuito/ Calle Luis Salgado y Pedro Echeverria Oe8-188.\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tObjetivo Personal\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\tSuperarme en todos los aspectos de mi vida, brindando lo mejor de mí cada día, tanto en el aspecto laboral como en el aspecto personal\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tObjetivo Especifico\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\tEncontrar una empresa que me permita aplicar los conocimientos adquiridos en los años de estudio, así como mi capacidad de planificación y  organización.\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tMas Informacion\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDisponibilidad\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                          ]),
                        ],
                      )
                    ])),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.grey100,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tMayerli Mendez\n",
                                  style: pw.TextStyle(
                                      fontSize: 22, color: PdfColors.blue900)),
                            ),
                            pw.Text("Estudiante"),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDatos Academicos\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Text("Bachillerato General Unificado (BGU)" +
                                "Unidad Educativa Consejo Provincial de Pichincha" +
                                "Tecnología en Desarrollo de Software" +
                                "Escuela Politécnica Nacional" +
                                "Quito-Ecuador"),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tHabilidades\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t *Responsable\n"),
                                pw.Text("\t *Honesta\n"),
                                pw.Text("\t *Trabajo en Equipo\n"),
                                pw.Text("\t *Puntualidad\n"),
                                pw.Text("\t *Liderazgo\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tCompetencias\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text(
                                    "\t Conocimientos generales en herramientas de Microsoft Office\n"),
                                pw.Text("\t Figma\n"),
                                pw.Text("\t Joomla\n"),
                                pw.Text("\t Mantenimiento de Computadores\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tIdiomas\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t \n"),
                                pw.Text("\t Español:Nativo\n"),
                                pw.Text("\t Ingles:Avanzado 1\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tCursos\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t \n"),
                                pw.Text("\t Seguridad Informatica\n"),
                                pw.Text("\t Programacion en Python\n"),
                                pw.Text("\t Algoritmo y Estructura de Datos\n"),
                                pw.Text("\t Economia Circular\n"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> generarPdf2() async {
    pdf = pw.Document();
    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 198,
                  child: pw.Container(
                    color: PdfColors.cyan,
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Column(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(14),
                            child: pw.Image(
                              imagen,
                              height: 70,
                              width: 70,
                            ),
                          ),
                          pw.Column(children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(5),
                              child: pw.Text("\tContactos\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text("\tGithub:\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\thttps://github.com/JorgeOrtiz121\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tCorreo Electronico:\n"),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text("\tortizjorge319@gmail.com\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDirreccion:\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\tQuito/ Fernando Ortega y Manuel de Lara(Comite del Pueblo).\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tObjetivo Personal\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\tAdquirir conocimientos en diferentes lenguajes de Programacion y poder aplicarlos en el entorno laboral y me gusta estar en un trabajo con ambiente de compañerismo y amistad\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tObjetivo Especifico\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\tEjercer mis conocimientos en un puesto de trabajo profesional como ministerios o empresas de software donde mi primer objetivo es demostrar mis habilidades y enorgullecer a la empresa que me dio la oportunidad de superar.\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tMas Informacion\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDisponibilidad\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue100)),
                            ),
                          ]),
                        ],
                      )
                    ])),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.green100,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tJorge Ortiz\n",
                                  style: pw.TextStyle(
                                      fontSize: 22, color: PdfColors.blue900)),
                            ),
                            pw.Text("Estudiante"),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tDatos Academicos\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Text("Bachillerato General Unificado (BGU)\n" +
                                "Unidad Educativa Particular Nuestra Señora del Rosario\n" +
                                "Tecnología Superior en Desarrollo de Software\n" +
                                "Escuela Politécnica Nacional\n" +
                                "Quito-Ecuador\n"),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tHabilidades\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t *Puntualidad\n"),
                                pw.Text("\t *Responsabilidad\n"),
                                pw.Text("\t *Compañerismo\n"),
                                pw.Text("\t *Caracter Autonomo\n"),
                                pw.Text("\t *Honestidad\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tCompetencias\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text(
                                    "\t Conocimientos en frameworks de Servidores Larave-PHP\n"),
                                pw.Text("\t MySQL\n"),
                                pw.Text("\t SQL Server\n"),
                                pw.Text("\t Python\n"),
                                pw.Text("\t Java\n"),
                                pw.Text("\t JavaScript\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tIdiomas\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t \n"),
                                pw.Text("\t Español:Nativo\n"),
                                pw.Text("\t Ingles:Avanzado 1\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tCursos\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t \n"),
                                pw.Text(
                                    "\t Fundamentos de Cyberseguridad-Cisco Networking\n"),
                                pw.Text(
                                    "\t Curso de programacion Javascript Begginer-Cisco Networking\n"),
                                pw.Text(
                                    "\t Curso de programacion Python Intermediate-Cisco Networking\n"),
                                pw.Text(
                                    "\t Fundamentos de Linux-Cisco Networking\n"),
                                pw.Text(
                                    "\t Fundamentos de Desarrollo BackEnd-Carlos Slim\n"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> generarPdf3() async {
    pdf = pw.Document();
    imagen = PdfImage.file(
      pdf.document,
      bytes: (await rootBundle.load(kGoogleImagePath)).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            height: double.infinity,
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 198,
                  child: pw.Container(
                    color: PdfColors.amber,
                    child: pw.Container(
                        child: pw.Column(children: [
                      pw.Column(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(14),
                            child: pw.Image(
                              imagen,
                              height: 70,
                              width: 70,
                            ),
                          ),
                          pw.Column(children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(5),
                              child: pw.Text("\tPERFIL\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text("\tEmail:\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\tleoniguambo@gmail.com\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tTeléfono:\n"),
                            ),
                            pw.Padding(
                                padding: pw.EdgeInsets.all(10),
                                child: pw.Text("\t0983753059\n")),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text("\tLinkedIn:\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                  "\twww.linkedin.com/in/leoni- guambo.\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\tGitHub.\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\thttps://github.com/Leoni23.\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tHABILIDADES\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Autoconocimiento\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Trabajo en equipo\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Pensamiento creativo\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Relaciones interpersonale\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Pensamiento crítico\n"),
                            ),
                            pw.Divider(
                              color: PdfColors.black,
                              thickness: 2,
                            ),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tIDIOMAS\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Español (nativo).\n"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text("\t Ingles (Intermedio).\n"),
                            ),
                          ]),
                        ],
                      )
                    ])),
                  ),
                ),
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColors.grey100,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.Column(
                          children: [
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text("\tLeoni Guambo\n",
                                  style: pw.TextStyle(
                                      fontSize: 22, color: PdfColors.blue900)),
                            ),
                            pw.Text("Estudiante"),
                            pw.Container(
                              margin: pw.EdgeInsets.all(10),
                              child: pw.Text(
                                  "\tExpectativa de Carrera Profesional\n",
                                  style: pw.TextStyle(
                                      fontSize: 15, color: PdfColors.blue900)),
                            ),
                            pw.Text(
                                "Soy una persona que busca desarrollarse profesionalmente y evolucionar personalmente, de tal manera que aprovecho las oportunidades que me permitan hacerlo, trato de ser colaborativa, positiva y adaptable a grupos de trabajo, fomentando valores importantes como el compañerismo laboral con el propósito de lograr alcanzar los objetivos planteados\n"),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tFormación Académica\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text(
                                    "\t * Informática: Tecnología en Desarrollo de Software\n"),
                                pw.Text(
                                    "\t *Escuela Politécnica Nacional, Quito\n"),
                                pw.Text(
                                    "\t *Formación Básica: Bachillerato en Industrias Técnico Salesiano Don Bosco, Quito\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tExperiencia Laboral\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text("\t Pasante\n"),
                                pw.Text("\t DEBCO, Quito\n"),
                                pw.Text("\t Asistente Personal\n"),
                                pw.Text("\t PRODUHORMI, Quito\n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tReferencia Laboral\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text(
                                    "\tJonathan Cholca Campués Gerente General, PRODUHORMI 0999753639 \n"),
                              ],
                            ),
                            pw.Column(
                              children: [
                                pw.Divider(
                                  color: PdfColors.black,
                                  thickness: 2,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.all(10),
                                  child: pw.Text("\tCertificados\n",
                                      style: pw.TextStyle(
                                          fontSize: 15,
                                          color: PdfColors.blue900)),
                                ),
                                pw.Text(
                                    "\tIntroducción de Programación Python-Escuela de Formación de Tecnólogos\n"),
                                pw.Text(
                                    "\t Algoritmos y Estructuras de Datos-Escuela de Formación de Tecnólogos\n"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}

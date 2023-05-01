import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:flutter/material.dart';

class Affichage extends StatefulWidget {
  const Affichage({super.key});

  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  List<Map<String, dynamic>>? data;
  void initState() {
    // TODO: implement initState

    data = [
      {
        'module': 'math',
        'note': EtudiantCubit.get(context).etudiantModel!.math.toString()
      },
      {
        'module': 'Algo',
        'note': EtudiantCubit.get(context).etudiantModel!.algo.toString()
      },
      {
        'module': 'physique',
        'note': EtudiantCubit.get(context).etudiantModel!.physique.toString()
      },
      {
        'module': 'moy',
        'note': EtudiantCubit.get(context).etudiantModel!.moy.toString()
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      height: size.height - 100,
      width: size.width,
      // height: size.height - defaultAppBar().preferredSize.height * 2.5,
      child: DataTable(
        border: TableBorder.all(),
        columns: const [
          DataColumn(label: Text('Module')),
          DataColumn(label: Text('note')),
        ],
        rows: data!
            .map((item) => DataRow(cells: [
                  DataCell(Text(item['module'])),
                  DataCell(Text(item['note'].toString())),
                ]))
            .toList(),
      ),
    ));
  }
}

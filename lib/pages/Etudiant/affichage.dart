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
        'controle':
            EtudiantCubit.get(context).etudiantModel!.math!.controle.toString(),
        'intero':
            EtudiantCubit.get(context).etudiantModel!.math!.intero.toString(),
        'moy': EtudiantCubit.get(context).etudiantModel!.math!.moy.toString(),
      },
      {
        'module': 'Algo',
        'moy': EtudiantCubit.get(context).etudiantModel!.algo!.moy.toString(),
        'intero':
            EtudiantCubit.get(context).etudiantModel!.algo!.intero.toString(),
        'controle':
            EtudiantCubit.get(context).etudiantModel!.algo!.controle.toString(),
      },
      {
        'module': 'physique',
        'moy':
            EtudiantCubit.get(context).etudiantModel!.physique!.moy.toString(),
        'intero': EtudiantCubit.get(context)
            .etudiantModel!
            .physique!
            .intero
            .toString(),
        'controle': EtudiantCubit.get(context)
            .etudiantModel!
            .physique!
            .controle
            .toString(),
      },
      {
        'module': 'moy General',
        'moy': EtudiantCubit.get(context).etudiantModel!.moy.toString(),
        'intero': '',
        'controle': '',
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
          DataColumn(label: Text('intero')),
          DataColumn(label: Text('controle')),
          DataColumn(label: Text('moy')),
        ],
        rows: data!
            .map((item) => DataRow(cells: [
                  DataCell(Text(item['module'])),
                  DataCell(Text(item['intero'].toString())),
                  DataCell(Text(item['controle'].toString())),
                  DataCell(Text(item['moy'].toString())),
                ]))
            .toList(),
      ),
    ));
  }
}

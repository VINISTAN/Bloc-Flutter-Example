import 'package:bloc_emp/BLoc/Employee_BLoc.dart';
import 'package:bloc_emp/Model/Employee.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
            return ListView.builder(
              itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                return  Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data?[index].id}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data?[index].name}",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              "₹ ${snapshot.data?[index].salary}",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: (){
                            _employeeBloc.EmployeeSalaryIncrementSink.add(snapshot.data![index]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_down),
                          color: Colors.red,
                          onPressed: (){
                            _employeeBloc.EmployeeSalaryDecrementSink.add(snapshot.data![index]);
                          },
                        ),
                      )
                    ],
                  ),
                );
                }
            );
          },
        ),
      ),
    );
  }
}

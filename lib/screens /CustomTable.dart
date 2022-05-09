import 'package:crud_table/crud_table.dart';
import 'package:crud_table/table/crud_table.dart';
import 'package:crud_table/table/crud_table_row_holder.dart';
import 'package:crud_table/table/form_item.dart';
import 'package:crud_table/table/form_row.dart';
import 'package:crud_table/table/form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voucher/screens%20/user_task.dart';
import 'package:voucher/screens%20/user_tasks_service.dart';


class CustomTable extends StatelessWidget {
  const CustomTable({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CrudTable<UserTask>(
              crudViewSource: createCrudSource(),
              onTap: (t) {
                t as UserTask;
              },
            ),
          ),
        ],
      ),
    );
  }

  CrudViewSource createCrudSource() {
    return CrudViewSource(
      columns: ["id", "code", "description", "active"],
      pageLimit: 20,
      rowHeight: 30,
      emptyEntityFactory: () =>
          UserTask(), // here we provide the empty object, which we get back when click on the submit button of the form
      createRows: (data, index) {
        data as UserTask;
        List<Widget> rows = [];
        rows.add(
            Text(data.id.toString(), style: const TextStyle(fontSize: 16)));
        rows.add(Text(data.taskCode.toString(),
            style: const TextStyle(fontSize: 16)));
        rows.add(Text(data.description.toString(),
            style: const TextStyle(fontSize: 16)));
        rows.add(
            Text(data.active.toString(), style: const TextStyle(fontSize: 16)));
        return rows;
      },
      createForm: (data) {
        data as UserTask;

        List<FormSection> fields = [];

        FormSection section1 = FormSection(
            sectionTitle: "System Tasks",
            formRows: () {
              List<FormRow> r = [];
              FormRow r1 = FormRow(formItems: () {
                List<FormItem> items = [];
                items.add(FormItem(
                  ratio: 1,
                  item: TextFormField(
                    key: CrudTableUtil.formFieldKey(data.id),
                    initialValue: CrudTableUtil.formFieldInitValue(data.id),
                    decoration: const InputDecoration(
                      labelText: 'Id',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false,
                  ),
                ));
                items.add(FormItem(
                  ratio: 1,
                  item: TextFormField(
                    key: CrudTableUtil.formFieldKey(data.taskCode),
                    initialValue:
                    CrudTableUtil.formFieldInitValue(data.taskCode),
                    onSaved: (v) {
                      data.taskCode = v;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter The Task Code!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ));
                return items;
              });
              r.add(r1);
              return r;
            });

        FormSection section2 = FormSection(
            sectionTitle: "System Tasks Section 02",
            formRows: () {
              List<FormRow> r = [];
              FormRow r1 = FormRow(formItems: () {
                List<FormItem> items = [];

                items.add(FormItem(
                  ratio: 1,
                  item: TextFormField(
                    key: CrudTableUtil.formFieldKey(data.description),
                    initialValue:
                    CrudTableUtil.formFieldInitValue(data.description),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a Description!';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      data.description = v;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ));

                return items;
              });
              FormRow r2 = FormRow(formItems: () {
                return [
                  (FormItem(
                    ratio: 1,
                    item: CheckboxListTile(
                      title: const Text("Active"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: data.active ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          data.active = value!;
                        });
                      },
                    ),
                  ))
                ];
              });

              r.add(r1);
              r.add(r2);
              return r;
            });

        fields.add(section1);
        fields.add(section2);
        return fields;
      },
      crudActionListener: CrudActionListener<UserTask>(
        add: (data) async {
          UserTasksService userS = UserTasksService.instance!;
          return userS.addTask(data);
        },
        edit: (data) async {
          data as UserTask;
          UserTasksService userS = UserTasksService.instance!;
          return userS.updateTask(data, data.id!.toInt());
        },
        delete: (data) async {
          data as UserTask;
          UserTasksService userS = UserTasksService.instance!;
          return userS.deleteTask(data.id!.toInt());
        },
      ),
      onPageChange: (pagination) async {
        UserTasksService userS = UserTasksService.instance!;
        return userS.getTasks(pagination.pageNumber, pagination.limit);
      },
    );
  }
}
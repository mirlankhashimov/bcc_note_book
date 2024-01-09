import 'package:bcc_note_book/features/tasks/presentation/blocs/settings/locale_bloc.dart';
import 'package:bcc_note_book/features/tasks/presentation/dvo/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/note_bloc.dart';
import '../widgets/note_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NoteBloc _noteBloc;

  @override
  void initState() {
    super.initState();
    _noteBloc = BlocProvider.of<NoteBloc>(context);
    _noteBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bcc"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                addNoteDialog();
              },
            ),
            TextButton.icon(
                onPressed: () {
                  final LocaleBloc localeBloc =
                      BlocProvider.of<LocaleBloc>(context);
                  localeBloc.add(ChangeLangEvent(lang: 'ru'));
                },
                label: Text(AppLocalizations.of(context)?.localeName ?? "ru"),
                icon: const Icon(Icons.language_outlined))
          ],
        ),
        body: BlocListener(
          bloc: BlocProvider.of<LocaleBloc>(context),
          listener: (BuildContext context, LocaleState state) {
            if (state is ChangedLangState) {
              final snackBar = SnackBar(
                content: const Text(""),
                action: SnackBarAction(
                  label: AppLocalizations.of(context)!.lang_changed(state.lang),
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: const Notes(),
        ));
  }

  void addNoteDialog() {
    final NoteBloc addNoteBlock = BlocProvider.of<NoteBloc>(context);
    showDialog(
        context: context,
        builder: (context) {
          var titleController = TextEditingController();
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            content: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: AppLocalizations.of(context)!.type_title,
                            labelText:
                                AppLocalizations.of(context)!.note_title),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text;
                          final note = Note("", title);
                          if (title.isNotEmpty) {
                            addNoteBlock.add(AddNoteEvent(note: note));
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text(AppLocalizations.of(context)!.add_note),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

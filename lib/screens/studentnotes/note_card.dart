import 'package:brototype_app/screens/studentnotes/description_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class NoteCard extends StatefulWidget {
  NoteCard({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.description,
    required this.title,
    required this.date,
    required this.color,
    this.onRightslide,
    this.onLeftslide,
  });

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function(BuildContext)? onRightslide;
  final void Function(BuildContext)? onLeftslide;

  final String description;
  final String title;
  final String date;
  final int color;
  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  Future<void> _showDeleteConfirmationDialogue(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Note"),
            content: const Text("Are you sure want to delete this note?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  widget.onDeletePressed?.call();
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DescriptionScreen(
              color: Color(widget.color),
              date: widget.date,
              description: widget.description,
              title: widget.title,
            );
          }));
        },
        child: Slidable(
          startActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: widget.onLeftslide,
              icon: Icons.edit,
              backgroundColor: Colors.grey.shade300,
            )
          ]),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.onRightslide,
                icon: Icons.delete,
                backgroundColor: Colors.grey.shade300,
              )
            ],
          ),
          child: Card(
            elevation: 20,
            color: Color(widget.color),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: widget.onEditPressed,
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _showDeleteConfirmationDialogue(context);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(widget.description,
                          textAlign: TextAlign.justify,
                          maxLines: 4,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade800, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.date,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                  onPressed: () {
                                    String message = widget.description;
                                    String subject = widget.title;
                                    Share.share(message, subject: subject);
                                  },
                                  icon: Icon(Icons.share))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

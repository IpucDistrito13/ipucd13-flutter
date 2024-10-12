import 'package:flutter/material.dart';

class CustomTituloSubtitulo extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const CustomTituloSubtitulo({super.key, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    //final titleStyle = Theme.of(context).textTheme.titleSmall;

    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 23,
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                //Estilo para el subtitulo
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}

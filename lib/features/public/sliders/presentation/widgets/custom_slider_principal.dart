import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../domain/domains.dart';

class CustomSliderPrincipal extends StatelessWidget {
  final List<SliderPrincipal> sliders;
  const CustomSliderPrincipal({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        itemCount: sliders.length,
        itemBuilder: (context, index) => _Slide(slider: sliders[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final SliderPrincipal slider;

  const _Slide({required this.slider});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                slider.imagen,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black12));
                  }
                  return FadeIn(child: child);
                },
              ))),
    );
  }
}

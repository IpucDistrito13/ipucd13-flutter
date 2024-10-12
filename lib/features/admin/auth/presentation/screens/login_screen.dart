import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/shared.dart';
import '../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            // Icon Banner
            // Imagen desde assets
            SizedBox(
              width: 260, // Ajusta el ancho según lo necesites
              height: 100, // Ajusta la altura según lo necesites
              child: Image.asset(
                'assets/images/ipuc_logosimbolo_copia.png',
                fit: BoxFit
                    .fill, // Esto asegura que la imagen se ajuste correctamente
              ),
            ),

            const SizedBox(height: 10),

            Container(
              height: size.height - 180, // 280 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            )
          ],
        ),
      ))),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    //final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text('Iniciar sesión',
              style: TextStyle(
                  fontFamily: 'MyriamPro',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) // Asegura que el texto sea negro),
              ),
          const SizedBox(height: 80),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            onFieldSubmitted: (_) =>
                ref.read(loginFormProvider.notifier).onFormSubmit(),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: const Color(0xFFF0AB00),
              textColor:
                  Colors.white, // Añadido para especificar el color del texto
              onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onFormSubmit,
            ),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text(
                  'Olvidé mi contraseña',
                  style: TextStyle(
                      color: Colors
                          .black), // Asegura que el texto del botón sea visible
                ),
              )
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

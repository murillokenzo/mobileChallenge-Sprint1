import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../theme.dart';
import '../widgets/cartao.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key, required this.perfil, required this.onSalvar, required this.onIrConquistas});
  final Perfil? perfil;
  final void Function(Perfil) onSalvar;
  final VoidCallback onIrConquistas;
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _idade = TextEditingController();
  String? _area;
  String _nivel = 'Iniciante';

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _idade.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Corrija os campos destacados.')));
      return;
    }
    final p = Perfil(
      nome: _nome.text.trim(), email: _email.text.trim(),
      idade: int.parse(_idade.text), area: _area!, nivel: _nivel,
    );
    widget.onSalvar(p);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Perfil salvo, ${p.primeiroNome}!'),
        content: Text('Medalha Cadastrado desbloqueada. Área favorita: ${p.area}.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onIrConquistas();
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(18), children: [
        Text('Perfil do explorador', style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Crie seu perfil para guardar suas conquistas.', style: TextStyle(color: AppColors.mutado)),
        const SizedBox(height: 14),
        if (widget.perfil != null)
          Cartao(child: Text('Perfil atual: ${widget.perfil!.nome} (${widget.perfil!.area})')),
        Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nome,
              decoration: decoracao('Nome'),
              validator: (v) => (v == null || v.trim().length < 3) ? 'Digite seu nome com pelo menos 3 letras.' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: decoracao('E-mail'),
              validator: (v) => RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v?.trim() ?? '')
                  ? null
                  : 'Digite um e-mail válido, como nome@email.com.',
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _idade,
              keyboardType: TextInputType.number,
              decoration: decoracao('Idade'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                return (n != null && n >= 10 && n <= 120) ? null : 'Informe uma idade entre 10 e 120.';
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _area,
              decoration: decoracao('Área que mais te interessa'),
              items: const ['Saúde', 'Energia', 'Agricultura', 'Indústria', 'Pesquisa científica']
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
              onChanged: (v) => setState(() => _area = v),
              validator: (v) => v == null ? 'Escolha uma área de interesse.' : null,
            ),
            const SizedBox(height: 14),
            Align(alignment: Alignment.centerLeft, child: Text('Seu nível sobre o tema', style: tt.titleSmall)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Iniciante', label: Text('Iniciante')),
                ButtonSegment(value: 'Intermediário', label: Text('Médio')),
                ButtonSegment(value: 'Avançado', label: Text('Avançado')),
              ],
              selected: {_nivel},
              onSelectionChanged: (s) => setState(() => _nivel = s.first),
            ),
            FormField<bool>(
              initialValue: false,
              validator: (v) => v == true ? null : 'Marque a opção para continuar.',
              builder: (state) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CheckboxListTile(
                  value: state.value,
                  onChanged: state.didChange,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text('Quero receber uma curiosidade por dia'),
                ),
                if (state.hasError)
                  Text(state.errorText!, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: _enviar, child: const Text('Salvar perfil'))),
          ]),
        ),
      ]),
    );
  }
}

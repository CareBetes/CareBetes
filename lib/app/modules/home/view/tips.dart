import 'package:care_betes/app/common/common_outlined_button.dart';
import 'package:care_betes/app/common/common_scaffold.dart';
import 'package:care_betes/app/common/common_text_box.dart';
import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isFloatingActionButton: false,
      scroll: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      appbar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF7EA1C1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const Text(
              'Dicas',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Image.asset(
              'assets/images/logo_bete.png',
              width: 130,
            ),
            const Text(
              'A diabetes é uma doença crônica na qual o corpo não produz insulina ou não consegue empregar adequadamente a insulina que produz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonOutlinedButton(
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    text: 'Tipo 1',
                    onPressed: () {
                      showDialog(
                        context,
                        title: 'Tipo 1',
                        textAlignTitle: TextAlign.center,
                        content:
                            'Em alguns casos, o sistema imunológico ataca equivocadamente as células beta do pâncreas, impedindo a liberação adequada de insulina para o corpo. Isso resulta na permanência da glicose no sangue, em vez de ser utilizada como energia, caracterizando a Diabetes Tipo 1.',
                      );
                    },
                  ),
                  CommonOutlinedButton(
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    text: 'Tipo 2',
                    onPressed: () {
                      showDialog(
                        context,
                        title: 'Tipo 2',
                        textAlignTitle: TextAlign.center,
                        content:
                            'Quando o organismo não consegue usar adequadamente a insulina que produz ou não produz insulina suficiente para controlar os níveis de glicemia, temos o quadro de Diabetes Tipo 2. Geralmente, os sintomas dessa forma de diabetes surgem na idade adulta, por volta dos 40 anos, especialmente em pessoas com excesso de peso, estilo de vida sedentário, histórico familiar da doença e hábitos alimentares pouco saudáveis.',
                      );
                    },
                  ),
                  CommonOutlinedButton(
                    elevation: 4,
                    text: 'Gestacional',
                    onPressed: () {
                      showDialog(
                        context,
                        title: 'Gestacional',
                        textAlignTitle: TextAlign.center,
                        content:
                            'A Diabetes Gestacional ocorre durante a gravidez, onde as mudanças hormonais podem reduzir a eficácia da insulina, responsável por regular os níveis de glicose no corpo. A placenta produz hormônios que aumentam a demanda, levando o pâncreas a aumentar a produção de insulina. Algumas mulheres enfrentam dificuldades em equilibrar essa interação, resultando em diabetes gestacional, caracterizada pela elevação da glicose durante a gravidez. Níveis elevados de glicose podem causar crescimento excessivo do feto, aumentando os riscos de complicações no parto, hipoglicemia neonatal e predisposição à obesidade e diabetes na vida adulta.',
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Ainda não há uma cura para essa doença, mas atualmente é possível ter o controle total, em alguns casos até mesmo não é necessário o uso de medicamentos. Mas para isso é preciso ter o acompanhamento médico de forma adequada e regular. Segue algumas dicas para começar o seu cuidado com a doença.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Lembramos que as dicas não substituem as palavras de um profissional, em caso de dúvidas, um médico deverá ser consultado.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Cuidado com suas refeições!',
                onPressed: () {
                  showDialog(
                    context,
                    title: 'Cuidado com suas refeições!',
                    textAlignTitle: TextAlign.center,
                    fontSizeTitle: 18,
                    content:
                        'Manter uma dieta saudável é fundamental para o cuidado com a diabetes, para que se possa gerenciar os níveis de glicose, contribuindo para reduzir a ocorrência tanto de hiperglicemia (aumento da glicose no sangue) quanto de hipoglicemia (baixa de açúcar no sangue). Mas manter uma dieta saudável não significa um banimento de alguns tipos de alimento, uma pessoa com diabetes não irá ser proibida de comer doces, por exemplo. O importante é ter controle, o conhecimento e principalmente o equilíbrio daquilo que se come.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Fique esperto com sua janta!',
                onPressed: () {
                  showDialog(
                    context,
                    title: 'Fique esperto com sua janta!',
                    fontSizeTitle: 18,
                    content:
                        'É melhor tomar cuidado com sua última refeição do dia, pois quando você se alimenta durante a noite, só é necessário se abastecer com poucos nutrientes ou o suficiente para que seu corpo trabalhe de forma adequada naquele período de repouso, porém muitas vezes durante a janta nós pedimos alimentos mais pesados, como pizzas e lanches. Portanto, durante a noite nosso índice glicêmico sobe muito, sendo prejudicial a longo prazo podendo se desenvolver a resistência à insulina.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'O que seria uma dieta saudável ?',
                onPressed: () {
                  showDialog(
                    context,
                    fontSizeTitle: 18,
                    fontSizeContent: 12,
                    textAlign: TextAlign.start,
                    title: 'O que seria uma dieta saudável ?',
                    textAlignTitle: TextAlign.center,
                    content: '''
  • Fracionamento das refeições ao longo do dia
	•	Incluir diversos grupos alimentares
	•	Preferir alimentos integrais
	•	Evitar alimentos gordurosos e/ou industrializados
	•	Evite principalmente substituir a água pura por bebidas industrializadas cheias de açúcar!
	•	Consulte um bom nutricionista! Cada caso difere um do outro, apenas um profissional poderá oferecer uma dieta específica que poderá englobar saúde e prazer de forma adequada.''',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Exercícios são mesmo importantes?',
                onPressed: () {
                  showDialog(
                    context,
                    fontSizeTitle: 18,
                    title: 'Exercícios são mesmo importantes?',
                    textAlignTitle: TextAlign.center,
                    content:
                        'SIM! A atividade física é essencial para pacientes com diabetes, pois auxilia na prevenção da obesidade, reduz os níveis de colesterol, melhora a circulação sanguínea e, consequentemente, reduz o risco de hipertensão arterial. Todos esses benefícios ajudam os pacientes com diabetes a controlar seus níveis glicêmicos.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Obesidade é um problema!',
                onPressed: () {
                  showDialog(
                    context,
                    fontSizeTitle: 18,
                    title: 'Obesidade é um problema!',
                    textAlignTitle: TextAlign.center,
                    content:
                        'Não importa o seu caso, o exercício físico é a principal forma de se evitar ou de ajudar a combater a diabetes. A obesidade é um fator que impulsiona a diabetes, a gordura, principalmente aquela que fica ao redor do abdômen é extremamente prejudicial.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Cuide de sua insulina!',
                onPressed: () {
                  showDialog(
                    context,
                    fontSizeTitle: 18,
                    fontSizeContent: 12,
                    title: 'Cuide de sua insulina!',
                    textAlignTitle: TextAlign.center,
                    content: '''Os principais cuidados são:
  •	Armazenamento adequado da insulina;
	•	Não se deve reutilizar seringas e agulhas;
	•	Deve-se realizar a limpeza da tampa de borracha do frasco de insulina com álcool 70% antes de aspirar a insulina do frasco;
	•	Deve-se fazer a prega cutânea para a aplicação da insulina;
	•	Aplicação adequada (sempre alternando os locais de aplicação);
	•	O paciente precisa ter o hábito de verificar sua glicemia capilar, pois em casos de hipoglicemia não se deve aplicar insulina.''',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'De que forma a idade influencia o manejo da diabetes ?',
                onPressed: () {
                  showDialog(
                    context,
                    fontSizeTitle: 18,
                    textAlignTitle: TextAlign.center,
                    title:
                        'De que forma a idade influencia o manejo da diabetes ?',
                    content:
                        'A idade influencia no manejo da diabetes, pois no processo de envelhecimento do nosso corpo, somos mais propensos a fatores de risco devido à própria fisiologia do nosso organismo. Um exemplo disso é que o avanço da idade provoca alterações na morfologia (forma) das nossas artérias, o que resulta em maior rigidez das mesmas e nos torna mais propensos ao diagnóstico de hipertensão arterial.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text:
                    'Quais são as recomendações específicas para pacientes jovens, adultos e idosos ?',
                onPressed: () {
                  showDialog(
                    context,
                    title:
                        'Quais são as recomendações específicas para pacientes jovens, adultos e idosos ?',
                    fontSizeTitle: 18,
                    textAlignTitle: TextAlign.center,
                    content: '''
Portanto, pacientes idosos com diagnóstico de diabetes enfrentam maiores riscos, pois costumam ter outras doenças relacionadas, o que aumenta sua vulnerabilidade a complicações do diabetes, como, por exemplo, o AVE (Acidente Vascular Encefálico) e Neuropatia. Já os pacientes jovens geralmente são diagnosticados com diabetes tipo 1, que é uma doença autoimune. 
Independentemente da idade, é crucial orientar os pacientes sobre como controlar os níveis glicêmicos por meio de mudanças no estilo de vida. No entanto, nos pacientes idosos, devemos ter uma atenção especial devido à propensão a outras doenças pré-existentes ou adquiridas, uma vez que o descontrole dessas condições tem um impacto negativo sobre o diabetes.
''',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                text: 'Mantenha-se a par da sua situação!',
                elevation: 4,
                onPressed: () {
                  showDialog(
                    context,
                    title: 'Mantenha-se a par da sua situação!',
                    textAlign: TextAlign.center,
                    fontSizeTitle: 18,
                    textAlignTitle: TextAlign.center,
                    content:
                        '	O acompanhamento e monitoramento feitos regularmente são de extrema importância, pois ajudam a indicar o estado atual do seu corpo e da doença, possibilitando um melhor controle da saúde. Além disso, proporciona oportunidades para desfrutar de refeições de forma mais prazerosa.',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CommonOutlinedButton(
                elevation: 4,
                text: 'Tome cuidado com a saúde dos olhos!',
                onPressed: () {
                  showDialog(
                    context,
                    title: 'Tome cuidado com a saúde dos olhos!',
                    fontSizeTitle: 18,
                    textAlignTitle: TextAlign.center,
                    textAlign: TextAlign.center,
                    content:
                        'Pessoas com diabetes têm mais fragilidade nos tecidos dos olhos, como a córnea e a retina. Visitas regulares a um oftalmologista são essenciais para ter mais segurança ao longo do tempo.',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDialog(
    BuildContext context, {
    required String title,
    required String content,
    double? fontSizeTitle,
    double? fontSizeContent,
    TextAlign? textAlign,
    TextAlign? textAlignTitle,
  }) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: CommonTextBox(
            title: title,
            fontSize: fontSizeTitle,
            textAlign: textAlignTitle,
          ),
          content: Text(
            content,
            textAlign: textAlign ?? TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSizeContent,
            ),
          ),
        );
      },
    );
  }
}

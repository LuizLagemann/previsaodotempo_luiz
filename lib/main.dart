import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SF Pro',  // Definir fonte semelhante ao iPhone
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute}';

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2D6A4F),
              Color(0xFF1B4332),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Fundo do container com efeito de gradiente suave
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF135CBB),
                      Color(0xFF121D39),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6), // Fundo branco mais suave
                        borderRadius: BorderRadius.circular(20.0), // Borda arredondada
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Pesquisar Cidade',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                      ),
                    ),
                  ),

                  // Exibição estática das informações de previsão
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ibirubá',  // Nome da cidade
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,  // Ajustando a espessura da fonte
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 8),
                            Column(
                              children: [
                                Text(
                                  '20°',  // Temperatura
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,  // Aumentar tamanho da temperatura
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Ensolarado',  // Descrição do clima
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          children: [
                            _buildDayForecast("Segunda", "", Icons.wb_sunny, 22, 30),
                            _buildDayForecast("Terça", "", Icons.grain_outlined, 18, 25),
                            _buildDayForecast("Quarta", "", Icons.cloud, 20, 28),
                            _buildDayForecast("Quinta", "", Icons.wb_cloudy, 21, 29),
                            _buildDayForecast("Sexta", "", Icons.wb_sunny, 24, 32),
                            _buildDayForecast("Sábado", "", Icons.grain, 19, 27),
                            _buildDayForecast("Domingo", "", Icons.cloud, 22, 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: _buildTimeWidget(formattedTime),
              ),


              Positioned(
                top: 16.0,
                right: 16.0,
                child: IconButton(
                  icon: Icon(Icons.map, color: Colors.white),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeWidget(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDayForecast(String day, String condition, IconData iconData, int minTemp, int maxTemp) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                SizedBox(width: 0),
                Text(
                  condition,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '$minTemp° / $maxTemp°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Nova Tela de Configurações
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suas Lavouras"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título do tópico LAVOURA 1
            Text(
              'LAVOURA 1',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Imagem da lavoura
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
               "https://cdn6.campograndenews.com.br/uploads/noticias/2020/03/10/1ouyl5ybpvh7h.jpg"
              ),
            ),
          ],
        ),
      ),
    );
  }
}

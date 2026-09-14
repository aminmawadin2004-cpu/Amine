import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const AutoDiagProApp());
}

// ============================================================
// LANGUAGE ENUM
// ============================================================
enum AppLanguage { en, fr, ar }

// ============================================================
// TRANSLATIONS
// ============================================================
class AppTranslations {
  static final Map<String, Map<AppLanguage, String>> _map = {
    'app_title': {
      AppLanguage.en: 'AUTO-DIAG PRO AI',
      AppLanguage.fr: 'AUTO-DIAG PRO AI',
      AppLanguage.ar: 'AUTO-DIAG PRO AI',
    },
    'dashboard': {
      AppLanguage.en: 'Dashboard',
      AppLanguage.fr: 'Tableau de bord',
      AppLanguage.ar: 'لوحة القيادة',
    },
    'dtc_scanner': {
      AppLanguage.en: 'DTC Scanner',
      AppLanguage.fr: 'Scanner DTC',
      AppLanguage.ar: 'ماسح الأعطال',
    },
    'ai_tools': {
      AppLanguage.en: 'AI Tools',
      AppLanguage.fr: 'Outils IA',
      AppLanguage.ar: 'أدوات الذكاء الاصطناعي',
    },
    'history': {
      AppLanguage.en: 'History',
      AppLanguage.fr: 'Historique',
      AppLanguage.ar: 'السجل',
    },
    'connection_status': {
      AppLanguage.en: 'Connection Status',
      AppLanguage.fr: 'État de la connexion',
      AppLanguage.ar: 'حالة الاتصال',
    },
    'connected': {
      AppLanguage.en: 'Connected',
      AppLanguage.fr: 'Connecté',
      AppLanguage.ar: 'متصل',
    },
    'disconnected': {
      AppLanguage.en: 'Disconnected',
      AppLanguage.fr: 'Déconnecté',
      AppLanguage.ar: 'غير متصل',
    },
    'connect_elm327': {
      AppLanguage.en: 'Connect to ELM 327',
      AppLanguage.fr: 'Se connecter à ELM 327',
      AppLanguage.ar: 'الاتصال بـ ELM 327',
    },
    'elm327_adapter': {
      AppLanguage.en: 'ELM327 Bluetooth/Wi-Fi Adapter',
      AppLanguage.fr: 'Adaptateur ELM327 Bluetooth/Wi-Fi',
      AppLanguage.ar: 'محول ELM327 بلوتوث/واي فاي',
    },
    'rpm': {
      AppLanguage.en: 'RPM',
      AppLanguage.fr: 'RPM',
      AppLanguage.ar: 'دورة في الدقيقة',
    },
    'engine_temp': {
      AppLanguage.en: 'Engine Temp',
      AppLanguage.fr: 'Température moteur',
      AppLanguage.ar: 'حرارة المحرك',
    },
    'speed': {
      AppLanguage.en: 'Speed',
      AppLanguage.fr: 'Vitesse',
      AppLanguage.ar: 'السرعة',
    },
    'fuel_trim': {
      AppLanguage.en: 'Fuel Trim',
      AppLanguage.fr: 'Correction de carburant',
      AppLanguage.ar: 'ضبط الوقود',
    },
    'live_telemetry': {
      AppLanguage.en: 'Live Vehicle Telemetry',
      AppLanguage.fr: 'Télémétrie en direct',
      AppLanguage.ar: 'بيانات المركبة المباشرة',
    },
    'start_ecu_scan': {
      AppLanguage.en: 'START ECU SCAN',
      AppLanguage.fr: 'DÉMARRER LE SCAN ECU',
      AppLanguage.ar: 'بدء فحص الحاسوب',
    },
    'scanning_ecu': {
      AppLanguage.en: 'Scanning ECU modules...',
      AppLanguage.fr: 'Analyse des modules ECU...',
      AppLanguage.ar: 'جاري فحص وحدات التحكم...',
    },
    'scan_complete': {
      AppLanguage.en: 'Scan Complete',
      AppLanguage.fr: 'Analyse terminée',
      AppLanguage.ar: 'اكتمل الفحص',
    },
    'no_faults_found': {
      AppLanguage.en: 'No faults found. Your vehicle is healthy.',
      AppLanguage.fr: 'Aucun défaut trouvé. Votre véhicule est en bon état.',
      AppLanguage.ar: 'لم يتم العثور على أعطال. سيارتك بحالة جيدة.',
    },
    'faults_detected': {
      AppLanguage.en: 'Faults Detected',
      AppLanguage.fr: 'Défauts détectés',
      AppLanguage.ar: 'تم اكتشاف أعطال',
    },
    'ai_analysis': {
      AppLanguage.en: 'AI Analysis',
      AppLanguage.fr: 'Analyse IA',
      AppLanguage.ar: 'تحليل الذكاء الاصطناعي',
    },
    'gemini_api_key_label': {
      AppLanguage.en: 'Gemini API Key',
      AppLanguage.fr: 'Clé API Gemini',
      AppLanguage.ar: 'مفتاح Gemini API',
    },
    'gemini_api_key_hint': {
      AppLanguage.en: 'Paste your free GEMINI_API_KEY from Google AI Studio',
      AppLanguage.fr: 'Collez votre GEMINI_API_KEY gratuite depuis Google AI Studio',
      AppLanguage.ar: 'الصق مفتاح GEMINI_API_KEY المجاني من Google AI Studio',
    },
    'feature_dtc_analysis': {
      AppLanguage.en: 'DTC AI Analysis & Cost Estimator',
      AppLanguage.fr: 'Analyse IA des DTC et Estimation des Coûts',
      AppLanguage.ar: 'تحليل الأعطال بالذكاء الاصطناعي وتقدير التكلفة',
    },
    'feature_vision': {
      AppLanguage.en: 'Photo/Vision Diagnosis',
      AppLanguage.fr: 'Diagnostic Photo/Vision',
      AppLanguage.ar: 'تشخيص بالصورة',
    },
    'feature_audio': {
      AppLanguage.en: 'Voice/Sound Diagnosis',
      AppLanguage.fr: 'Diagnostic Vocal/Sonore',
      AppLanguage.ar: 'تشخيص بالصوت',
    },
    'analyze_button': {
      AppLanguage.en: 'Run AI Analysis',
      AppLanguage.fr: 'Lancer l\'analyse IA',
      AppLanguage.ar: 'تشغيل التحليل',
    },
    'plain_explanation': {
      AppLanguage.en: 'Plain Language Explanation',
      AppLanguage.fr: 'Explication simple',
      AppLanguage.ar: 'شرح مبسط',
    },
    'root_causes': {
      AppLanguage.en: 'Root Causes',
      AppLanguage.fr: 'Causes principales',
      AppLanguage.ar: 'الأسباب الجذرية',
    },
    'estimated_cost': {
      AppLanguage.en: 'Estimated Cost',
      AppLanguage.fr: 'Coût estimé',
      AppLanguage.ar: 'التكلفة التقديرية',
    },
    'select_warning_light': {
      AppLanguage.en: 'Select a Warning Light / Component to Simulate a Photo',
      AppLanguage.fr: 'Sélectionnez un voyant / composant pour simuler une photo',
      AppLanguage.ar: 'اختر ضوء تحذير / مكون لمحاكاة صورة',
    },
    'analyze_photo': {
      AppLanguage.en: 'Analyze Photo with AI',
      AppLanguage.fr: 'Analyser la photo avec IA',
      AppLanguage.ar: 'تحليل الصورة بالذكاء الاصطناعي',
    },
    'check_engine': {
      AppLanguage.en: 'Check Engine Light',
      AppLanguage.fr: 'Voyant moteur',
      AppLanguage.ar: 'ضوء فحص المحرك',
    },
    'abs_light': {
      AppLanguage.en: 'ABS Warning Light',
      AppLanguage.fr: 'Voyant ABS',
      AppLanguage.ar: 'ضوء نظام ABS',
    },
    'airbag_light': {
      AppLanguage.en: 'Airbag Warning Light',
      AppLanguage.fr: 'Voyant Airbag',
      AppLanguage.ar: 'ضوء الوسادة الهوائية',
    },
    'engine_damage': {
      AppLanguage.en: 'Visible Engine Damage',
      AppLanguage.fr: 'Dommage moteur visible',
      AppLanguage.ar: 'ضرر ظاهر في المحرك',
    },
    'record_engine_sound': {
      AppLanguage.en: 'Record Engine Sound',
      AppLanguage.fr: 'Enregistrer le son du moteur',
      AppLanguage.ar: 'تسجيل صوت المحرك',
    },
    'recording': {
      AppLanguage.en: 'Recording...',
      AppLanguage.fr: 'Enregistrement...',
      AppLanguage.ar: 'جاري التسجيل...',
    },
    'select_sound_type': {
      AppLanguage.en: 'Select Simulated Sound Type',
      AppLanguage.fr: 'Sélectionnez le type de son simulé',
      AppLanguage.ar: 'اختر نوع الصوت المحاكى',
    },
    'metallic_ticking': {
      AppLanguage.en: 'Metallic Ticking',
      AppLanguage.fr: 'Tic-tac métallique',
      AppLanguage.ar: 'صوت طرق معدني',
    },
    'belt_squeal': {
      AppLanguage.en: 'Belt Squealing',
      AppLanguage.fr: 'Grincement de courroie',
      AppLanguage.ar: 'صرير الحزام',
    },
    'turbo_whistle': {
      AppLanguage.en: 'Turbo Whistling',
      AppLanguage.fr: 'Sifflement du turbo',
      AppLanguage.ar: 'صفير التوربو',
    },
    'grinding_noise': {
      AppLanguage.en: 'Grinding Noise (Braking)',
      AppLanguage.fr: 'Bruit de grincement (freinage)',
      AppLanguage.ar: 'صوت احتكاك (الفرامل)',
    },
    'analyze_sound': {
      AppLanguage.en: 'Analyze Sound with AI',
      AppLanguage.fr: 'Analyser le son avec IA',
      AppLanguage.ar: 'تحليل الصوت بالذكاء الاصطناعي',
    },
    'history_title': {
      AppLanguage.en: 'Scan History',
      AppLanguage.fr: 'Historique des analyses',
      AppLanguage.ar: 'سجل الفحوصات',
    },
    'health_score': {
      AppLanguage.en: 'Health Score',
      AppLanguage.fr: 'Indice de santé',
      AppLanguage.ar: 'مؤشر الحالة',
    },
    'faults_logged': {
      AppLanguage.en: 'Faults Logged',
      AppLanguage.fr: 'Défauts enregistrés',
      AppLanguage.ar: 'الأعطال المسجلة',
    },
    'no_history': {
      AppLanguage.en: 'No scans have been performed yet.',
      AppLanguage.fr: 'Aucune analyse n\'a encore été effectuée.',
      AppLanguage.ar: 'لم يتم إجراء أي فحص بعد.',
    },
    'enter_api_key_first': {
      AppLanguage.en: 'Please enter your Gemini API key first.',
      AppLanguage.fr: 'Veuillez d\'abord saisir votre clé API Gemini.',
      AppLanguage.ar: 'يرجى إدخال مفتاح Gemini API أولاً.',
    },
    'scan_first': {
      AppLanguage.en: 'Please scan your vehicle first in the DTC Scanner tab.',
      AppLanguage.fr: 'Veuillez d\'abord scanner votre véhicule dans l\'onglet Scanner DTC.',
      AppLanguage.ar: 'يرجى فحص سيارتك أولاً في تبويب الماسح.',
    },
    'analyzing': {
      AppLanguage.en: 'Analyzing with Gemini AI...',
      AppLanguage.fr: 'Analyse avec Gemini AI...',
      AppLanguage.ar: 'جاري التحليل بواسطة Gemini AI...',
    },
    'error_occurred': {
      AppLanguage.en: 'An error occurred. Check your API key and connection.',
      AppLanguage.fr: 'Une erreur est survenue. Vérifiez votre clé API et votre connexion.',
      AppLanguage.ar: 'حدث خطأ. تحقق من مفتاح API والاتصال.',
    },
    'scanned_codes': {
      AppLanguage.en: 'Scanned Codes',
      AppLanguage.fr: 'Codes détectés',
      AppLanguage.ar: 'الرموز المكتشفة',
    },
    'settings': {
      AppLanguage.en: 'Language',
      AppLanguage.fr: 'Langue',
      AppLanguage.ar: 'اللغة',
    },
    'vehicle_healthy': {
      AppLanguage.en: 'Vehicle Healthy',
      AppLanguage.fr: 'Véhicule en bon état',
      AppLanguage.ar: 'السيارة بحالة جيدة',
    },
    'severity': {
      AppLanguage.en: 'Severity',
      AppLanguage.fr: 'Gravité',
      AppLanguage.ar: 'الخطورة',
    },
    'clear_history': {
      AppLanguage.en: 'Clear History',
      AppLanguage.fr: 'Effacer l\'historique',
      AppLanguage.ar: 'مسح السجل',
    },
    'ai_result': {
      AppLanguage.en: 'AI Result',
      AppLanguage.fr: 'Résultat IA',
      AppLanguage.ar: 'نتيجة الذكاء الاصطناعي',
    },
  };

  static String t(String key, AppLanguage lang) {
    final entry = _map[key];
    if (entry == null) return key;
    return entry[lang] ?? entry[AppLanguage.en] ?? key;
  }
}

// ============================================================
// DTC CODE DATA MODEL
// ============================================================
class DtcCode {
  final String code;
  final Map<AppLanguage, String> description;
  final String severity; // low, medium, high

  DtcCode({required this.code, required this.description, required this.severity});

  String desc(AppLanguage lang) => description[lang] ?? description[AppLanguage.en]!;
}

final List<DtcCode> kAllDtcCodes = [
  DtcCode(
    code: 'P0300',
    description: {
      AppLanguage.en: 'Random/Multiple Cylinder Misfire Detected',
      AppLanguage.fr: 'Raté d\'allumage aléatoire/multiple détecté',
      AppLanguage.ar: 'تم اكتشاف تعثر إشعال عشوائي/متعدد الأسطوانات',
    },
    severity: 'high',
  ),
  DtcCode(
    code: 'P0171',
    description: {
      AppLanguage.en: 'System Too Lean (Bank 1)',
      AppLanguage.fr: 'Mélange trop pauvre (Banc 1)',
      AppLanguage.ar: 'النظام هزيل جداً (البنك 1)',
    },
    severity: 'medium',
  ),
  DtcCode(
    code: 'P0420',
    description: {
      AppLanguage.en: 'Catalyst System Efficiency Below Threshold (Bank 1)',
      AppLanguage.fr: 'Efficacité du catalyseur inférieure au seuil (Banc 1)',
      AppLanguage.ar: 'كفاءة نظام المحفز أقل من الحد الأدنى (البنك 1)',
    },
    severity: 'medium',
  ),
  DtcCode(
    code: 'P0442',
    description: {
      AppLanguage.en: 'Evaporative Emission System Leak Detected (Small Leak)',
      AppLanguage.fr: 'Fuite détectée dans le système d\'émission par évaporation (petite fuite)',
      AppLanguage.ar: 'تم اكتشاف تسرب صغير في نظام التبخر',
    },
    severity: 'low',
  ),
  DtcCode(
    code: 'P0128',
    description: {
      AppLanguage.en: 'Coolant Thermostat (Below Regulating Temperature)',
      AppLanguage.fr: 'Thermostat de liquide de refroidissement (sous la température de régulation)',
      AppLanguage.ar: 'منظم حرارة سائل التبريد (تحت درجة الحرارة التنظيمية)',
    },
    severity: 'low',
  ),
  DtcCode(
    code: 'P0455',
    description: {
      AppLanguage.en: 'Evaporative Emission System Leak Detected (Large Leak)',
      AppLanguage.fr: 'Fuite détectée dans le système d\'émission par évaporation (grande fuite)',
      AppLanguage.ar: 'تم اكتشاف تسرب كبير في نظام التبخر',
    },
    severity: 'medium',
  ),
  DtcCode(
    code: 'P0301',
    description: {
      AppLanguage.en: 'Cylinder 1 Misfire Detected',
      AppLanguage.fr: 'Raté d\'allumage du cylindre 1 détecté',
      AppLanguage.ar: 'تم اكتشاف تعثر إشعال في الأسطوانة 1',
    },
    severity: 'high',
  ),
  DtcCode(
    code: 'P0505',
    description: {
      AppLanguage.en: 'Idle Air Control System Malfunction',
      AppLanguage.fr: 'Dysfonctionnement du système de régulation du ralenti',
      AppLanguage.ar: 'خلل في نظام التحكم بالهواء عند التباطؤ',
    },
    severity: 'low',
  ),
];

// ============================================================
// HISTORY ENTRY MODEL
// ============================================================
class ScanHistoryEntry {
  final DateTime date;
  final List<DtcCode> faults;
  final int healthScore;

  ScanHistoryEntry({required this.date, required this.faults, required this.healthScore});
}

// ============================================================
// ROOT APP
// ============================================================
class AutoDiagProApp extends StatefulWidget {
  const AutoDiagProApp({super.key});

  @override
  State<AutoDiagProApp> createState() => _AutoDiagProAppState();
}

class _AutoDiagProAppState extends State<AutoDiagProApp> {
  AppLanguage _language = AppLanguage.en;

  void _setLanguage(AppLanguage lang) {
    setState(() {
      _language = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF121212);
    const neonBlue = Color(0xFF00E5FF);
    const amber = Color(0xFFFFB300);

    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return MaterialApp(
      title: 'AUTO-DIAG PRO AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        primaryColor: neonBlue,
        colorScheme: const ColorScheme.dark(
          primary: neonBlue,
          secondary: amber,
          surface: Color(0xFF1C1C1E),
        ),
        textTheme: baseTextTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: bgColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        cardColor: const Color(0xFF1C1C1E),
        dividerColor: Colors.white12,
        useMaterial3: true,
      ),
      locale: _language == AppLanguage.en
          ? const Locale('en')
          : _language == AppLanguage.fr
              ? const Locale('fr')
              : const Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection: _language == AppLanguage.ar ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: HomeScreen(language: _language, onLanguageChanged: _setLanguage),
    );
  }
}

// ============================================================
// HOME SCREEN (Bottom Nav Shell)
// ============================================================
class HomeScreen extends StatefulWidget {
  final AppLanguage language;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const HomeScreen({super.key, required this.language, required this.onLanguageChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  String _apiKey = '';
  List<DtcCode> _lastScanResults = [];
  final List<ScanHistoryEntry> _history = [];

  void _onScanCompleted(List<DtcCode> results) {
    setState(() {
      _lastScanResults = results;
      final score = results.isEmpty
          ? 100
          : max(35, 100 - results.fold<int>(0, (sum, f) => sum + (f.severity == 'high' ? 25 : f.severity == 'medium' ? 15 : 8)));
      _history.insert(0, ScanHistoryEntry(date: DateTime.now(), faults: results, healthScore: score));
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.language;
    final tabs = <Widget>[
      DashboardTab(language: lang),
      DTCScannerTab(language: lang, onScanCompleted: _onScanCompleted, lastResults: _lastScanResults),
      AIToolsTab(
        language: lang,
        apiKey: _apiKey,
        onApiKeyChanged: (v) => setState(() => _apiKey = v),
        scannedCodes: _lastScanResults,
      ),
      HistoryTab(language: lang, history: _history, onClear: _clearHistory),
    ];

    final titles = [
      AppTranslations.t('dashboard', lang),
      AppTranslations.t('dtc_scanner', lang),
      AppTranslations.t('ai_tools', lang),
      AppTranslations.t('history', lang),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(FontAwesomeIcons.carBurst, color: Color(0xFF00E5FF), size: 20),
            const SizedBox(width: 10),
            Text(AppTranslations.t('app_title', lang)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: LanguageToggle(current: lang, onChanged: widget.onLanguageChanged),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
              child: Text(
                titles[_tabIndex],
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(child: tabs[_tabIndex]),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF161616),
          border: Border(top: BorderSide(color: Colors.white12, width: 0.6)),
        ),
        child: BottomNavigationBar(
          currentIndex: _tabIndex,
          onTap: (i) => setState(() => _tabIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF00E5FF),
          unselectedItemColor: Colors.white38,
          showUnselectedLabels: true,
          selectedLabelStyle: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.gaugeHigh, size: 20),
              label: AppTranslations.t('dashboard', lang),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.magnifyingGlassChart, size: 20),
              label: AppTranslations.t('dtc_scanner', lang),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.robot, size: 20),
              label: AppTranslations.t('ai_tools', lang),
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.clockRotateLeft, size: 20),
              label: AppTranslations.t('history', lang),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// LANGUAGE TOGGLE WIDGET
// ============================================================
class LanguageToggle extends StatelessWidget {
  final AppLanguage current;
  final ValueChanged<AppLanguage> onChanged;

  const LanguageToggle({super.key, required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AppLanguage>(
          value: current,
          dropdownColor: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(12),
          icon: const Icon(Icons.language, color: Color(0xFF00E5FF), size: 16),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
          items: const [
            DropdownMenuItem(value: AppLanguage.en, child: Text('EN')),
            DropdownMenuItem(value: AppLanguage.fr, child: Text('FR')),
            DropdownMenuItem(value: AppLanguage.ar, child: Text('AR')),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

// ============================================================
// SHARED: PREMIUM CARD WRAPPER
// ============================================================
class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PremiumCard({super.key, required this.child, this.padding = const EdgeInsets.all(18)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ============================================================
// GAUGE PAINTER (CustomPainter Arc Gauge)
// ============================================================
class GaugePainter extends CustomPainter {
  final double value; // 0..1
  final Color color;
  final double strokeWidth;

  GaugePainter({required this.value, required this.color, this.strokeWidth = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    const startAngle = pi * 0.75;
    const sweepTotal = pi * 1.5;

    final trackPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepTotal, false, trackPaint);

    final valuePaint = Paint()
      ..shader = SweepGradient(
        colors: [color.withOpacity(0.4), color],
        startAngle: startAngle,
        endAngle: startAngle + sweepTotal,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepTotal * value.clamp(0.0, 1.0),
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}

class ArcGauge extends StatelessWidget {
  final double value;
  final Color color;
  final String label;
  final String display;
  final IconData icon;

  const ArcGauge({
    super.key,
    required this.value,
    required this.color,
    required this.label,
    required this.display,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Column(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(110, 110),
                  painter: GaugePainter(value: value, color: color),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 18),
                    const SizedBox(height: 4),
                    Text(
                      display,
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD TAB
// ============================================================
class DashboardTab extends StatefulWidget {
  final AppLanguage language;
  const DashboardTab({super.key, required this.language});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  Timer? _timer;
  final Random _rnd = Random();
  bool _connected = true;

  double _rpm = 850;
  double _temp = 88;
  double _speed = 0;
  double _fuelTrim = 2.0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _tick());
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      _rpm = (800 + _rnd.nextInt(3200)).toDouble();
      _temp = (75 + _rnd.nextInt(35)).toDouble();
      _speed = (0 + _rnd.nextInt(140)).toDouble();
      _fuelTrim = (-8 + _rnd.nextInt(16)).toDouble();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.language;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumCard(
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: (_connected ? const Color(0xFF00E5FF) : Colors.redAccent).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FontAwesomeIcons.bluetooth,
                    color: _connected ? const Color(0xFF00E5FF) : Colors.redAccent,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTranslations.t('connection_status', lang),
                        style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppTranslations.t('elm327_adapter', lang),
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _connected,
                  activeColor: const Color(0xFF00E5FF),
                  onChanged: (v) => setState(() => _connected = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: (_connected ? const Color(0xFF00E5FF) : Colors.redAccent).withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _connected ? const Color(0xFF00E5FF) : Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _connected ? AppTranslations.t('connected', lang) : AppTranslations.t('disconnected', lang),
                  style: GoogleFonts.inter(
                    color: _connected ? const Color(0xFF00E5FF) : Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppTranslations.t('live_telemetry', lang),
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.95,
            children: [
              ArcGauge(
                value: (_rpm / 6000).clamp(0.0, 1.0),
                color: const Color(0xFF00E5FF),
                label: AppTranslations.t('rpm', lang),
                display: _rpm.toInt().toString(),
                icon: FontAwesomeIcons.gaugeHigh,
              ),
              ArcGauge(
                value: (_temp / 130).clamp(0.0, 1.0),
                color: _temp > 105 ? const Color(0xFFFFB300) : const Color(0xFF00E5FF),
                label: AppTranslations.t('engine_temp', lang),
                display: '${_temp.toInt()}°C',
                icon: FontAwesomeIcons.temperatureThreeQuarters,
              ),
              ArcGauge(
                value: (_speed / 220).clamp(0.0, 1.0),
                color: const Color(0xFF00E5FF),
                label: AppTranslations.t('speed', lang),
                display: '${_speed.toInt()}',
                icon: FontAwesomeIcons.tachometerAlt,
              ),
              ArcGauge(
                value: ((_fuelTrim + 10) / 20).clamp(0.0, 1.0),
                color: _fuelTrim.abs() > 5 ? const Color(0xFFFFB300) : const Color(0xFF00E5FF),
                label: AppTranslations.t('fuel_trim', lang),
                display: '${_fuelTrim.toStringAsFixed(1)}%',
                icon: FontAwesomeIcons.gasPump,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DTC SCANNER TAB
// ============================================================
class DTCScannerTab extends StatefulWidget {
  final AppLanguage language;
  final ValueChanged<List<DtcCode>> onScanCompleted;
  final List<DtcCode> lastResults;

  const DTCScannerTab({
    super.key,
    required this.language,
    required this.onScanCompleted,
    required this.lastResults,
  });

  @override
  State<DTCScannerTab> createState() => _DTCScannerTabState();
}

class _DTCScannerTabState extends State<DTCScannerTab> {
  bool _scanning = false;
  double _progress = 0;
  Timer? _timer;
  List<DtcCode>? _results;

  @override
  void initState() {
    super.initState();
    _results = widget.lastResults.isEmpty ? null : widget.lastResults;
  }

  void _startScan() {
    setState(() {
      _scanning = true;
      _progress = 0;
      _results = null;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 180), (t) {
      setState(() {
        _progress += 0.05 + Random().nextDouble() * 0.05;
        if (_progress >= 1.0) {
          _progress = 1.0;
          t.cancel();
          _finishScan();
        }
      });
    });
  }

  void _finishScan() {
    final rnd = Random();
    final count = rnd.nextInt(3); // 0, 1, or 2 -> but requirement wants 2-3 realistic codes when faults exist
    List<DtcCode> found = [];
    final shouldHaveFaults = rnd.nextDouble() > 0.15;
    if (shouldHaveFaults) {
      final numFaults = 2 + rnd.nextInt(2); // 2 or 3
      final shuffled = List<DtcCode>.from(kAllDtcCodes)..shuffle(rnd);
      found = shuffled.take(numFaults).toList();
    }
    setState(() {
      _scanning = false;
      _results = found;
    });
    widget.onScanCompleted(found);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color _severityColor(String severity) {
    switch (severity) {
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return const Color(0xFFFFB300);
      default:
        return const Color(0xFF00E5FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.language;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumCard(
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.carSide,
                  color: const Color(0xFF00E5FF).withOpacity(0.85),
                  size: 46,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _scanning ? null : _startScan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E5FF),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      textStyle: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: 0.5),
                    ),
                    child: Text(AppTranslations.t('start_ecu_scan', lang)),
                  ),
                ),
                if (_scanning) ...[
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF00E5FF)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppTranslations.t('scanning_ecu', lang),
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (_results != null) ...[
            Row(
              children: [
                Icon(
                  _results!.isEmpty ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.triangleExclamation,
                  color: _results!.isEmpty ? const Color(0xFF00E5FF) : const Color(0xFFFFB300),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  AppTranslations.t('scan_complete', lang),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_results!.isEmpty)
              PremiumCard(
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.shieldHeart, color: Color(0xFF00E5FF)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppTranslations.t('no_faults_found', lang),
                        style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )
            else
              ..._results!.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PremiumCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: _severityColor(f.severity).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              f.code,
                              style: GoogleFonts.inter(
                                color: _severityColor(f.severity),
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  f.desc(lang),
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${AppTranslations.t('severity', lang)}: ${f.severity.toUpperCase()}',
                                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// AI TOOLS TAB
// ============================================================
class AIToolsTab extends StatefulWidget {
  final AppLanguage language;
  final String apiKey;
  final ValueChanged<String> onApiKeyChanged;
  final List<DtcCode> scannedCodes;

  const AIToolsTab({
    super.key,
    required this.language,
    required this.apiKey,
    required this.onApiKeyChanged,
    required this.scannedCodes,
  });

  @override
  State<AIToolsTab> createState() => _AIToolsTabState();
}

class _AIToolsTabState extends State<AIToolsTab> {
  late TextEditingController _apiKeyController;
  bool _obscureKey = true;

  bool _dtcLoading = false;
  String? _dtcResult;

  bool _visionLoading = false;
  String? _visionResult;
  String _selectedVisualIssue = 'check_engine';

  bool _audioLoading = false;
  String? _audioResult;
  String _selectedSound = 'metallic_ticking';
  bool _recordingSimulated = false;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController(text: widget.apiKey);
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  String _langName() {
    switch (widget.language) {
      case AppLanguage.fr:
        return 'French';
      case AppLanguage.ar:
        return 'Moroccan Arabic (Darija)';
      case AppLanguage.en:
        return 'English';
    }
  }

  Future<String> _callGemini(String prompt) async {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: widget.apiKey);
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '';
  }

  Future<void> _runDtcAnalysis() async {
    final lang = widget.language;
    if (widget.apiKey.trim().isEmpty) {
      _showSnack(AppTranslations.t('enter_api_key_first', lang));
      return;
    }
    if (widget.scannedCodes.isEmpty) {
      _showSnack(AppTranslations.t('scan_first', lang));
      return;
    }
    setState(() {
      _dtcLoading = true;
      _dtcResult = null;
    });
    try {
      final codesList = widget.scannedCodes.map((c) => '${c.code} (${c.desc(lang)})').join(', ');
      final prompt =
          'You are a certified senior automotive diagnostic technician. A vehicle scan returned these OBD2 trouble codes: $codesList. '
          'Respond in $_langName() only. Structure your answer with three clear sections using these exact headers: '
          '"EXPLANATION:", "ROOT CAUSES:", and "ESTIMATED COST:". '
          'In EXPLANATION give a short plain-language explanation of what these faults mean for a non-technical driver. '
          'In ROOT CAUSES list the most likely mechanical causes as bullet points. '
          'In ESTIMATED COST give an approximate spare parts price range and labor cost range in USD, formatted as bullet points per code. '
          'Keep the whole answer concise, under 300 words.';
      final result = await _callGemini(prompt);
      setState(() {
        _dtcResult = result;
      });
    } catch (e) {
      setState(() {
        _dtcResult = AppTranslations.t('error_occurred', lang);
      });
    } finally {
      setState(() {
        _dtcLoading = false;
      });
    }
  }

  Future<void> _runVisionAnalysis() async {
    final lang = widget.language;
    if (widget.apiKey.trim().isEmpty) {
      _showSnack(AppTranslations.t('enter_api_key_first', lang));
      return;
    }
    setState(() {
      _visionLoading = true;
      _visionResult = null;
    });
    try {
      final issueLabel = AppTranslations.t(_selectedVisualIssue, AppLanguage.en);
      final prompt =
          'You are an automotive vision-diagnostic AI simulating analysis of a dashboard photo. '
          'The driver has simulated taking a photo showing: "$issueLabel". '
          'Respond in $_langName() only. Provide: a short visual analysis of what this indicator typically looks like and means, '
          'a risk level (Low, Medium, High, or Critical), and the most likely fault identification with recommended next steps. '
          'Keep it concise, under 200 words, and format with clear line breaks.';
      final result = await _callGemini(prompt);
      setState(() {
        _visionResult = result;
      });
    } catch (e) {
      setState(() {
        _visionResult = AppTranslations.t('error_occurred', lang);
      });
    } finally {
      setState(() {
        _visionLoading = false;
      });
    }
  }

  Future<void> _simulateRecording() async {
    setState(() => _recordingSimulated = true);
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    setState(() => _recordingSimulated = false);
    await _runAudioAnalysis();
  }

  Future<void> _runAudioAnalysis() async {
    final lang = widget.language;
    if (widget.apiKey.trim().isEmpty) {
      _showSnack(AppTranslations.t('enter_api_key_first', lang));
      return;
    }
    setState(() {
      _audioLoading = true;
      _audioResult = null;
    });
    try {
      final soundLabel = AppTranslations.t(_selectedSound, AppLanguage.en);
      final prompt =
          'You are an automotive acoustic-diagnostic AI simulating analysis of a 5-second engine sound recording. '
          'The recorded sound has been classified as: "$soundLabel". '
          'Respond in $_langName() only. Identify the most likely mechanical fault causing this sound, explain the acoustic reasoning briefly, '
          'rate the urgency (Low, Medium, High, Critical), and suggest a next troubleshooting step. '
          'Keep it concise, under 200 words.';
      final result = await _callGemini(prompt);
      setState(() {
        _audioResult = result;
      });
    } catch (e) {
      setState(() {
        _audioResult = AppTranslations.t('error_occurred', lang);
      });
    } finally {
      setState(() {
        _audioLoading = false;
      });
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF1C1C1E),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00E5FF), size: 18),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _resultBox(String? text, bool loading, String lang) {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF00E5FF)),
            ),
            const SizedBox(width: 12),
            Text(AppTranslations.t('analyzing', widget.language), style: GoogleFonts.inter(color: Colors.white60, fontSize: 13)),
          ],
        ),
      );
    }
    if (text == null || text.isEmpty) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2)),
      ),
      width: double.infinity,
      child: Text(
        text,
        style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = widget.language;
    final visualOptions = ['check_engine', 'abs_light', 'airbag_light', 'engine_damage'];
    final soundOptions = ['metallic_ticking', 'belt_squeal', 'turbo_whistle', 'grinding_noise'];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(FontAwesomeIcons.key, AppTranslations.t('gemini_api_key_label', lang)),
                const SizedBox(height: 10),
                TextField(
                  controller: _apiKeyController,
                  obscureText: _obscureKey,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
                  onChanged: widget.onApiKeyChanged,
                  decoration: InputDecoration(
                    hintText: AppTranslations.t('gemini_api_key_hint', lang),
                    hintStyle: GoogleFonts.inter(color: Colors.white30, fontSize: 12),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureKey ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white38,
                        size: 18,
                      ),
                      onPressed: () => setState(() => _obscureKey = !_obscureKey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // FEATURE A: DTC AI ANALYSIS
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(FontAwesomeIcons.brain, AppTranslations.t('feature_dtc_analysis', lang)),
                const SizedBox(height: 10),
                if (widget.scannedCodes.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.scannedCodes
                        .map((c) => Chip(
                              label: Text(c.code, style: GoogleFonts.inter(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w700)),
                              backgroundColor: const Color(0xFF00E5FF),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ))
                        .toList(),
                  )
                else
                  Text(
                    AppTranslations.t('scan_first', lang),
                    style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                  ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _dtcLoading ? null : _runDtcAnalysis,
                    icon: const Icon(FontAwesomeIcons.wandMagicSparkles, size: 14, color: Color(0xFF00E5FF)),
                    label: Text(AppTranslations.t('analyze_button', lang), style: GoogleFonts.inter(color: const Color(0xFF00E5FF), fontWeight: FontWeight.w700, fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF00E5FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                _resultBox(_dtcResult, _dtcLoading, lang.toString()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // FEATURE B: VISION AI
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(FontAwesomeIcons.camera, AppTranslations.t('feature_vision', lang)),
                const SizedBox(height: 10),
                Text(
                  AppTranslations.t('select_warning_light', lang),
                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: visualOptions.map((opt) {
                    final selected = _selectedVisualIssue == opt;
                    return ChoiceChip(
                      label: Text(AppTranslations.t(opt, lang), style: GoogleFonts.inter(fontSize: 12, color: selected ? Colors.black : Colors.white70, fontWeight: FontWeight.w600)),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedVisualIssue = opt),
                      selectedColor: const Color(0xFFFFB300),
                      backgroundColor: Colors.black.withOpacity(0.3),
                      side: BorderSide(color: selected ? const Color(0xFFFFB300) : Colors.white12),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12, style: BorderStyle.solid),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.image, color: Colors.white24, size: 30),
                      const SizedBox(height: 8),
                      Text(
                        AppTranslations.t(_selectedVisualIssue, lang),
                        style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _visionLoading ? null : _runVisionAnalysis,
                    icon: const Icon(FontAwesomeIcons.eye, size: 14, color: Color(0xFFFFB300)),
                    label: Text(AppTranslations.t('analyze_photo', lang), style: GoogleFonts.inter(color: const Color(0xFFFFB300), fontWeight: FontWeight.w700, fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFFFB300)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                _resultBox(_visionResult, _visionLoading, lang.toString()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // FEATURE C: AUDIO AI
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(FontAwesomeIcons.microphone, AppTranslations.t('feature_audio', lang)),
                const SizedBox(height: 10),
                Text(
                  AppTranslations.t('select_sound_type', lang),
                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: soundOptions.map((opt) {
                    final selected = _selectedSound == opt;
                    return ChoiceChip(
                      label: Text(AppTranslations.t(opt, lang), style: GoogleFonts.inter(fontSize: 12, color: selected ? Colors.black : Colors.white70, fontWeight: FontWeight.w600)),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedSound = opt),
                      selectedColor: const Color(0xFF00E5FF),
                      backgroundColor: Colors.black.withOpacity(0.3),
                      side: BorderSide(color: selected ? const Color(0xFF00E5FF) : Colors.white12),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: _recordingSimulated ? null : _simulateRecording,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _recordingSimulated ? Colors.redAccent.withOpacity(0.2) : const Color(0xFF00E5FF).withOpacity(0.15),
                        border: Border.all(
                          color: _recordingSimulated ? Colors.redAccent : const Color(0xFF00E5FF),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        _recordingSimulated ? FontAwesomeIcons.stop : FontAwesomeIcons.microphone,
                        color: _recordingSimulated ? Colors.redAccent : const Color(0xFF00E5FF),
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    _recordingSimulated ? AppTranslations.t('recording', lang) : AppTranslations.t('record_engine_sound', lang),
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _audioLoading || _recordingSimulated ? null : _runAudioAnalysis,
                    icon: const Icon(FontAwesomeIcons.waveSquare, size: 14, color: Color(0xFF00E5FF)),
                    label: Text(AppTranslations.t('analyze_sound', lang), style: GoogleFonts.inter(color: const Color(0xFF00E5FF), fontWeight: FontWeight.w700, fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF00E5FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                _resultBox(_audioResult, _audioLoading, lang.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HISTORY TAB
// ============================================================
class HistoryTab extends StatelessWidget {
  final AppLanguage language;
  final List<ScanHistoryEntry> history;
  final VoidCallback onClear;

  const HistoryTab({super.key, required this.language, required this.history, required this.onClear});

  Color _scoreColor(int score) {
    if (score >= 85) return const Color(0xFF00E5FF);
    if (score >= 60) return const Color(0xFFFFB300);
    return Colors.redAccent;
  }

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final lang = language;
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.folderOpen, color: Colors.white24, size: 40),
              const SizedBox(height: 16),
              Text(
                AppTranslations.t('no_history', lang),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
      itemCount: history.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onClear,
                icon: const Icon(FontAwesomeIcons.trash, size: 12, color: Colors.redAccent),
                label: Text(
                  AppTranslations.t('clear_history', lang),
                  style: GoogleFonts.inter(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        }
        final entry = history[index - 1];
        final color = _scoreColor(entry.healthScore);
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 3),
                      ),
                      child: Text(
                        '${entry.healthScore}',
                        style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w800, fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(entry.date),
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${AppTranslations.t('health_score', lang)}: ${entry.healthScore}/100',
                            style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (entry.faults.isEmpty)
                  Text(
                    AppTranslations.t('vehicle_healthy', lang),
                    style: GoogleFonts.inter(color: const Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.w600),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: entry.faults
                        .map((f) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                f.code,
                                style: GoogleFonts.inter(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700),
                              ),
                            ))
                        .toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

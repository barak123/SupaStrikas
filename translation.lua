-- translations.lua
local commonData = require( "commonData" ) 
local dictionary =
{	 
["DailyRewardTitle"] =
		{
			["en"] = "DAILY REWARD!",
			["he"] = "הפרס היומי!",			
			["it"] = "Ricompense giornaliere!",			
			["es"] = "Recompensas Diarias",
			["de"] = "Tägliche Belohnungen",
			["fr"] = "Récompenses quotidiennes",
			["ar"] = "مكآفأت يومية",	
			["ru"] = "Ежедневные награды",			
			["pl"] = "Codzienne Nagrody",
			["pt"] = "Recompensas Diárias",
		},	
["DailyRewardText"] =
		{
			["en"] = "play every day and get better rewards",
			["he"] = "שחק בכל יום וקבל פרסים שווים יותר",			
			["it"] = "Gioca ogni giorno e ottieni premi migliori",			
			["es"] = "Juega todos los días y obtén recompensas",
			["de"] = "Spielen Sie jeden Tag und erhalten Sie bessere Belohnungen",
			["fr"] = "Jouez tous les jours et obtenez de meilleures récompenses",
			["ar"] = "العب كل يوم و أحصل على مكآفأت يومية",	
			["ru"] = "Играйте каждый день и получайте лучшие награды",			
			["pl"] = "Graj każdego dnia i zdobywaj lepsze nagrody",
			["pt"] = "Jogue todos os dias e consiga melhores recompensas",
		},	
["DailyRewardDay"] =
		{
			["en"] = "DAY",
			["he"] = "יום",			
			["es"] = "Dia",
			["it"] = "Giorno",			
			["de"] = "Tag",
			["fr"] = "Jour",
			["ar"] = "يوم",	
			["ru"] = "День",			
			["pl"] = "Dzień",
			["pt"] = "Dia",
		},			

		-- es , de , fr , ar  , ru 
["Play"] =
		{
			["en"] = "PLAY",
			["he"] = "שחק",			
			["es"] = "JUGAR",			
			["de"] = "Spielen",			
			["fr"] = "Jouer",			
			["ar"] = "اللعب",		
			["ru"] = "Играть",
			["it"] = "Gioca",
			["pl"] = "Graj",
			["pt"] = "Jogar",
			
		},	
["Shop"] =
		{
			["en"] = "CUSTOMIZE",
			["he"] = "חנות",			
			["es"] = "Personalizar",			
			["de"] = "Anpassen",			
			["fr"] = "Boutique",			
			["ar"] = "متجر",		
			["ru"] = "Магазин",
			["it"] = "Personalizza",
			["pl"] = "Sklep",
			["pt"] = "Loja",
			
		},	
["Packs"] =
		{
			["en"] = "PACKS",
			["he"] = "חבילות",			
			["es"] = "Paquetes",			
			["de"] = "PACKETE",			
			["fr"] = "Packs",			
			["ar"] = "حزم",		
			["ru"] = "Пакеты",
			["it"] = "Pacchetti",
			["pl"] = "Paczki",
			["pt"] = "Pacotes",
			
		},	
["Back"] =
		{
			["en"] = "Back",
			["he"] = "חזור",			
			["es"] = "Regresar",			
			["de"] = "Zurück",			
			["fr"] = "Précédent",			
			["ar"] = "رجوع",		
			["ru"] = "Назад",
			["it"] = "Indietro",
			["pl"] = "Wstecz",
			["pt"] = "Atrás",
		},	
["Buy"] =
		{
			["en"] = "Buy",
			["he"] = "קנה",			
			["es"] = "Comprar",			
			["de"] = "Kaufen",			
			["fr"] = "Acheter",			
			["ar"] = "اشتري",		
			["ru"] = "Купить",
			["it"] = "Acquista",
			["pl"] = "Kup",
			["pt"] = "Comprar",
		},	
["Use"] =
		{
			["en"] = "Use",
			["he"] = "בחר",			
			["es"] = "Usar",			
			["de"] = "Verwendung",			
			["fr"] = "Utiliser",			
			["ar"] = "استخدم",		
			["ru"] = "Нанять",
			["it"] = "Usa",
			["pl"] = "Użyj",
			["pt"] = "Usar",
			
		},	
["Cancel"] =
		{
			["en"] = "Cancel",
			["he"] = "ביטול",			
			["es"] = "Cancel",			
			["de"] = "Stornieren",			
			["fr"] = "Annuler",			
			["ar"] = "إلغاء",		
			["ru"] = "Отмена",
			["it"] = "Annulla",
			["pl"] = "Anuluj",
			["pt"] = "Cancelar",
			
		},	
["SupaGems"] =
		{
			["en"] = "Supa Gems",
			["he"] = "סופה ג׳מס",			
			["es"] = "Supa Gemas",			
			["de"] = "Supa Edelsteine",			
			["fr"] = "Supa Gems",			
			["ar"] = "جواهر سوبا",		
			["ru"] = "Супер кристаллы",
			["it"] = "Gemma Supa",
			["pl"] = "Klejnoty Supa",
			["pt"] = "Joias Supa",
			
		},	
["Highscore"] =
		{
			["en"] = "High score",
			["he"] = "שיא",			
			["es"] = "Puntuación Más Alta",			
			["de"] = "Highscore",			
			["fr"] = "Score élevé",			
			["ar"] = "نتيجة عالية",		
			["ru"] = "Рекорд",
			["it"] = "Punteggio più alto",
			["pl"] = "Najwyższy wynik",
			["pt"] = "Pontuação",
			
		},	
["MainMenu"] =
		{
			["en"] = "MAIN MENU",
			["he"] = "תפריט",						
			["es"] = "Menú",			
			["de"] = "Hauptmenü",			
			["fr"] = "Menu principal",			
			["ar"] = "القائمة الرئيسية",		
			["ru"] = "Главное Меню",
			["it"] = "Menu Principale",
			["pl"] = "główne menu",
			["pt"] = "menu principal",
		},	
["ShareScore"] =
		{
			["en"] = "SHARE SCORE",
			["he"] = "שתף תוצאה",						
			["es"] = "Compartir",			
			["de"] = "teilen sie sich",			
			["fr"] = "Partage de score",			
			["ar"] = "انتهت اللعبة",		
			["ru"] = "общий счет",
			["it"] = "Condividi il punteggio",
			["pl"] = "podziel się wynikiem",
			["pt"] = "partilhar pontuação",
		},	
["OK"] =
		{
			["en"] = "OK",
			["he"] = "סבבה",						
			["es"] = "OK",			
			["de"] = "OK",			
			["fr"] = "OK",			
			["ar"] = "OK",		
			["ru"] = "OK",
			["it"] = "OK",
			["pl"] = "OK",
			["pt"] = "OK",
		},						
["GamesPlayed"] =
		{
			["en"] = "Games played",
			["he"] = "משחקים",						
			["es"] = "Partidos jugados",			
			["de"] = "Gespielte Spiele",			
			["fr"] = "Jeux joués",			
			["ar"] = "الألعاب الملعوبة",		
			["ru"] = "Игр сыграно",
			["it"] = "Partite giocate",
			["pl"] = "Rozegrane gry",
			["pt"] = "Jogos jogados",
		},	
["AverageScore"] =
		{
			["en"] = "Average Score",
			["he"] = "תוצאה ממוצעת",						
			["es"] = "Puntuación media",			
			["de"] = "Durchschnittliche Punktzahl",			
			["fr"] = "Score moyen",			
			["ar"] = "متوسط النتيجة",		
			["ru"] = "Средний балл",
			["it"] = "Punteggio medio",
			["pl"] = "Średni wynik",
			["pt"] = "Pontuação média",
		},	
["PerfectRatio"] =
		{
			["en"] = "Perfect ratio",
			["he"] = "אחוז פרפקט",						
			["es"] = "Proporción de Perfección",			
			["de"] = "Perfektes Verhältnis",			
			["fr"] = "Rapport parfait",			
			["ar"] = "النسبة المثالية",		
			["ru"] = "Отличное соотношение",
			["it"] = "Rapporto perfetto",
			["pl"] = "Idealny wskaźnik",
			["pt"] = "Rácio perfeito",
		},	
["HighestCombo"] =
		{
			["en"] = "Highest combo",
			["he"] = "קומבו מקסימלי",						
			["es"] = "Combo más alto",			
			["de"] = "Höchste Combo",			
			["fr"] = "Plus haut combo",			
			["ar"] = "أعلى كومبو",		
			["ru"] = "Высшая комбинация",
			["it"] = "Combinazione più alta",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Maior Combo",
		},	
["Continue"] =
		{
			["en"] = "Continue",
			["he"] = "המשך",						
			["es"] = "Continuar",			
			["de"] = "Fortsetzen",			
			["fr"] = "Continuer",			
			["ar"] = "تابع",		
			["ru"] = "Продолжить",
			["it"] = "Continua",
			["pl"] = "Kontynuuj",
			["pt"] = "Continuar",
		},	
["YouWon"] =
		{
			["en"] = "You won",
			["he"] = "זכית ב",						
			["es"] = "Ganaste",			
			["de"] = "Sie haben gewonnen",			
			["fr"] = "Vous avez gagné",			
			["ar"] = "لقد فزت",		
			["ru"] = "ВЫ победили",
			["it"] = "Hai vinto",
			["pl"] = "Wygrałeś",
			["pt"] = "Ganhou",
		},	
["TryAgain"] =
		{
			["en"] = "Try again",
			["he"] = "נסה שוב",						
			["es"] = "Inténtalo de nuevo",			
			["de"] = "Versuchen Sie es noch einmal",			
			["fr"] = "Réessayez",			
			["ar"] = "حاول مجددا",		
			["ru"] = "Попробуйте еще раз",
			["it"] = "Riprova",
			["pl"] = "Spróbuj ponownie",
			["pt"] = "Tentar novamente",
		},	
["Level"] =
		{
			["en"] = "Level",
			["he"] = "רמה",						
			["es"] = "Nivel",			
			["de"] = "Ebene",			
			["fr"] = "Niveau",			
			["ar"] = "مستوى",		
			["ru"] = "Уровень",
			["it"] = "Livello",
			["pl"] = "Poziom",
			["pt"] = "Nível",
		},	
["WatchAd"] =
		{
			["en"] = "WATCH AD",
			["he"] = "צפה בפרסומת",						
			["es"] = "Ver anuncio",			
			["de"] = "Anzeige sehen",			
			["fr"] = "Voir l'annonce",			
			["ar"] = "مشاهدة الإعلان",		
			["ru"] = "смотреть объявление",
			["it"] = "Guarda l'annuncio",
			["pl"] = "obejrzyj reklamę",
			["pt"] = "ver anúncio",
		},	
["Score"] =
		{
			["en"] = "SCORE",
			["he"] = "תוצאה",						
			["es"] = "Puntuación",			
			["de"] = "Ergebnis",			
			["fr"] = "Score",			
			["ar"] = "النتيجة",		
			["ru"] = "Счет",
			["it"] = "Punteggio",
			["pl"] = "Wynik",
			["pt"] = "Pontuação",
		},	
["Challenges"] =
		{
			["en"] = "CHALLENGES",
			["he"] = "אתגרים",						
			["es"] = "Desafíos",			
			["de"] = "Herausforderungen",			
			["fr"] = "Défis",			
			["ar"] = "التحديات",		
			["ru"] = "задания",
			["it"] = "Sfide",
			["pl"] = "Wyzwania",
			["pt"] = "Desafios",
		},			

["TimingTip"] =
		{
			["en"] = "Kick the ball when the circle turns green, to gain speed and combo",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Essayez de frapper la balle lorsque le cercle se ferme, pour gagner de la vitesse et combo.",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Tente acertar na bola quando o círculo está a fechar, para ganhar velocidade e combo.",
		},								
["SupaTip"] =
		{
			["en"] = "SUPA TIP",
			["he"] = "סופה טיפ",						
		},		
["totalMeters"] =
		{
			["en"] = "total meters",
			["he"] = "סהכ מטרים",						
			["es"] = "Contador total",			
			["de"] = "Gesamtzähler",			
			["fr"] = "compteurs totaux",			
			["ar"] = "مجموع متر",		
			["ru"] = "общий счетчик",
			["it"] = "contatore totale",
			["pl"] = "Licznik całkowity",				
			["pt"] = "metros totais",
		},										
["youReached"] =
		{
			["en"] = "you reached",
			["he"] = "הגעת ל",						
			["es"] = "Alcanzaste",			
			["de"] = "du hast erreicht",			
			["fr"] = "vous avez atteint",			
			["ar"] = "انت وصلت",		
			["ru"] = "вы достигли",
			["it"] = "hai raggiunto",
			["pl"] = "dostałeś",				
			["pt"] = "você alcançou",
		},					



["reacehedMeters10"] =
		{
			["en"] = "Reach 10 Meters",
			["he"] = "רוץ 10 מטרים",						
			["es"] = "Alcanza 10 metros",			
			["de"] = "Reichweite 10 Meter",			
			["fr"] = "Atteindre 10 mètres",			
			["ar"] = "قم بالوصول إلى  10 أمتار",		
			["ru"] = "Достигните 10 метров",
			["it"] = "Raggiungi 10 metri",
			["pl"] = "Osiągnij 10 Metrów",
			["pt"] = "Alcançar 10 Metros",
			
		},
["reacehedMeters20"] =
		{
			["en"] = "Reach 20 Meters",
			["he"] = "רוץ 20 מטרים",						
			["es"] = "Alcanza 20 metros",			
			["de"] = "Reichweite 20 Meter",			
			["fr"] = "Atteindre 20 mètres",			
			["ar"] = "قم بالوصول إلى  20 أمتار",		
			["ru"] = "Достигните 20 метров",
			["it"] = "Raggiungi 20 metri",
			["pl"] = "Osiągnij 20 Metrów",
			["pt"] = "Alcançar 20 Metros",
		},
["reacehedMeters50"] =
		{
			["en"] = "Reach 50 Meters",
			["he"] = "רוץ 50 מטרים",						
			["es"] = "Alcanza 50 metros",			
			["de"] = "Reichweite 50 Meter",			
			["fr"] = "Atteindre 10 mètres",			
			["ar"] = "قم بالوصول إلى  50 أمتار",		
			["ru"] = "Достигните 50 метров ",
			["it"] = "Raggiungi 50 metri",
			["pl"] = "Osiągnij 50 Metrów",
			["pt"] = "Alcançar 50 Metros",
		},
["reacehedMeters100"]  =
		{
			["en"] = "Reach 100 Meters" ,
			["he"] = "רוץ 100 מטרים",						
			["es"] = "Alcanza 100 metros",			
			["de"] = "Reichweite 100 Meter",			
			["fr"] = "Atteindre 100 mètres",			
			["ar"] = "قم بالوصول إلى  100 أمتار",		
			["ru"] = "Достигните 100 метров ",
			["it"] = "Raggiungi 100 metri",
			["pl"] = "Osiągnij 100 Metrów",
			["pt"] = "Alcançar 100 Metros",
		},
["reacehedMeters150"]  =
		{
			["en"] = "Reach 150 Meters" ,
			["he"] = "רוץ 150 מטרים",						
			["es"] = "Alcanza 150 metros",			
			["de"] = "Reichweite 150 Meter",			
			["fr"] = "Atteindre 150 mètres",			
			["ar"] = "قم بالوصول إلى  150 أمتار",		
			["ru"] = "Достигните 150 метров",
			["it"] = "Raggiungi 150 metri",
			["pl"] = "Osiągnij 150 Metrów",
			["pt"] = "Alcançar 150 Metros",
		},
["reacehedMeters200"] =
		{
			["en"] = "Reach 200 Meters" ,
			["he"] = "רוץ 200 מטרים",						
			["es"] = "Alcanza 200 metros",			
			["de"] = "Reichweite 200 Meter",			
			["fr"] = "Atteindre 200 mètres",			
			["ar"] = "قم بالوصول إلى  200 أمتار",		
			["ru"] = "Достигните 200 метров",
			["it"] = "Raggiungi 200 metri",
			["pl"] = "Osiągnij 200 Metrów",
			["pt"] = "Alcançar 200 Metros",
		},
["reacehedMeters300"] =
		{
			["en"] = "Reach 300 Meters" ,
			["he"] = "רוץ 300 מטרים",						
			["es"] = "Alcanza 300 metros",			
			["de"] = "Reichweite 300 Meter",			
			["fr"] = "Atteindre 300 mètres",			
			["ar"] = "قم بالوصول إلى  300 أمتار",		
			["ru"] = "Достигните 300 метров",
			["it"] = "Raggiungi 300 metri",
			["pl"] = "Osiągnij 300 Metrów",
			["pt"] = "Alcançar 300 Metros",
		},
["kick5time"] =
		{
			["en"] = "Kick the ball 5 times",
			["he"] = "בעט בכדור 5 פעמים",						
			["es"] = "Patear la pelota 5 veces",			
			["de"] = "Kick en Sie den Ball 5 mal",			
			["fr"] = "Kick la balle 5 fois",			
			["ar"] = "أركل الكرة 5 مرات",		
			["ru"] = "Ударьте мяч 5 раз",
			["it"] = "Calcia la palla 5 volte",
			["pl"] = "Uderz piłkę 5 razy",
			["pl"] = "Chutar a bola 5 vezes",
		},
["collectCoin"] =
		{
			["en"] = "Collect a coin",
			["he"] = "אסוף מטבע",						
			["es"] = "Recoger una moneda",			
			["de"] = "Sammeln Sie eine Münze",			
			["fr"] = "Collecter une pièce de monnaie",			
			["ar"] = "إجمع قطعة نقدية",		
			["ru"] = "Соберите монеты",
			["it"] = "Raccogli una moneta",
			["pl"] = "Zbierz monetę",
			["pt"] = "Recolher uma moeda",
		},
["jumpObstecale"] =
		{
			["en"] = "Jump over obstacle",
			["he"] = "קפוץ מעל מכשול",						
			["es"] = "Saltar sobre el obstáculo",			
			["de"] = "Sprung über Hindernisse",			
			["fr"] = "Sauter par-dessus obstacle",			
			["ar"] = "اقفز فوق عائق",		
			["ru"] = "Перепрыгните через препятствие",
			["it"] = "Salta l'ostacolo",
			["pl"] = "Przeskocz przez przeszkodę",
			["pt"] = "Saltar sobre obstáculo",
		},

["swap6"] =
		{
			["en"] = "Swap legs 6 times",
			["he"] = "החלף רגליים בבעיטה 6 פעמים ברציפות",						
			["es"] = "Cambiar las piernas 6 veces",			
			["de"] = "Tauschen Beine 6 mal",			
			["fr"] = "Echanger les jambes 6 fois",			
			["ar"] = "بدل الأقدام 6 مرات",		
			["ru"] = "Меняйте ноги 6 раз",
			["it"] = "Scambia le gambe 6 volte",
			["pl"] = "Zmień nogi 6 razy",
			["pt"] = "Trocar de pernas 6 vezes",
		},

["perfect4"] =
		{
			["en"] = "Perfect kick 4 times",
			["he"] = "בעט בכדור בתזמון מושלם 4 פעמים",						
			["es"] = "Patada perfecto 4 veces",			
			["de"] = "Perfekter Kick 4 Mal",			
			["fr"] = "Frapper parfait 4 fois",			
			["ar"] = "قم بأربعة ركلات مثالية",		
			["ru"] = "Совершите Идеальный удар 4 раза",
			["it"] = "Calcio perfetto 4 volte",
			["pl"] = "Uderz idealnie 4 razy",
			["pt"] = "Um pontapé perfeito 4 vezes",
		},
["perfect6"] =
		{
			["en"] = "Perfect kick 6 times",
			["he"] = "בעט בכדור בתזמון מושלם 4 פעמים",						
			["es"] = "Patada perfecto 6 veces",			
			["de"] = "Perfekter Kick 6 Mal",			
			["fr"] = "Frapper parfait 6 fois",			
			["ar"] = "جعل ستة ركلات مثالية",		
			["ru"] = "Совершите Идеальный удар 4 раза",
			["it"] = "Calcio perfetto 6 volte",
			["pl"] = "Uderz idealnie 6 razy",
			["pt"] = "Um pontapé perfeito 6 vezes",
		},
["scoreGoal"] =
		{
			["en"] = "Score a goal",
			["he"] = "שים גול",						
			["es"] = "Meter gol",			
			["de"] = "Ein Tor schießen",			
			["fr"] = "Marquer un but",			
			["ar"] = "احرز هدف",		
			["ru"] = "Забейте гол",
			["it"] = "Segna un goal",
			["pl"] = "Strzel gola",
			["pt"] = "Marcar um golo",
		},


["noJump60"] =
		{
			["en"] = "Reach 60 Meters without jumping",
			["he"] = "רוץ 60 מטרים בלי לקפוץ",						
			["es"] = "Alcanza 60 metros sin saltar",			
			["de"] = "60 Meter Reichweite ohne zu Springen",			
			["fr"] = "Atteindre 60 mètres sans sauter",			
			["ar"] = "قم بالوصول إلى 60 متر دون قفز",		
			["ru"] = "Достигните 60 метров без прыжков",
			["it"] = "Raggiungi 60 metri senza saltare",
			["pl"] = "Osiągnij 60 Metrów bez skakania",
			["pt"] = "Alcançar 60 Metros sem saltar",
		},
["runFromBully"] =
		{
			["en"] = "Run away from the bully",
			["he"] = "ברח מהבריון שמאחוריך",						
			["es"] = "Escapa del matón",			
			["de"] = "Laufen Sie weg von dem Tyrann",			
			["fr"] = "Fuis l'intimidateur",			
			["ar"] = "أهرب من المتنمر",		
			["ru"] = "Убегите от хулигана",
			["it"] = "Scappa dal bullo",
			["pl"] = "Ucieknij od prześladowcy",
			["pt"] = "Fugir do agressor",
		},
["maxSpeed"] =
		{
			["en"] = "Reach maximum speed",
			["he"] = "רוץ במהירות המקסימלית של השחקן",						
			["es"] = "Alcanzar la velocidad máxima",			
			["de"] = "Maximale Geschwindigkeit erreichen",			
			["fr"] = "Atteindre la vitesse maximale",			
			["ar"] = "قم بالوصول إلى السرعة القصوى",		
			["ru"] = "Достигните максимальной скорости",
			["it"] = "Raggiungi la velocità massima",
			["pl"] = "Osiągnij maksymalną szybkość",
			["pt"] = "Alcançar a velocidade máxima",
		},


["collectSpreeCoins"] =
		{
			["en"] = "Collect 4 coins in perfect spree",
			["he"] = "אסוף 4 מטבעות בזמן פרפקט קומבו",						
			["es"] = "Recoge 4 monedas en una juerga perfecta",			
			["de"] = "Sammeln Sie 4 Münzen in einem perfekten Lauf",			
			["fr"] = "Collectionnez 4 pièces en parfaite frénésie",			
			["ar"] = "اجمع 4 قطع نقدية في إنغماس مثالي",		
			["ru"] = "Соберите 4 монеты в комбо режиме",
			["it"] = "Raccogli 4 monete in perfetta catena",
			["pl"] = "Zbierz 4 monety w idealnej hulance",
			["pt"] = "Recolher 4 moedas numa sequência perfeita",
		},
["collectSpreeCoins2"] =
		{
			["en"] = "Collect 6 coins in perfect spree",
			["he"] = "אסוף 6 מטבעות בזמן פרפקט קומבו",						
			["es"] = "Recoge 6 monedas en una juerga perfecta",			
			["de"] = "Sammeln Sie 6 Münzen in einem perfekten Lauf",			
			["fr"] = "Collectionnez 6 pièces en parfaite frénésie",			
			["ar"] = "اجمع 6 قطع نقدية في إنغماس مثالي",		
			["ru"] = "Соберите 6 монеты в комбо режиме",
			["it"] = "Raccogli 6 monete in perfetta catena",
			["pl"] = "Zbierz 6 monet w idealnej hulance",
			["pt"] = "Recolher 6 moedas numa sequência perfeita",
		},
["topScore350"] =
		{
			["en"] = "Reach 50 meters 3 games in a row",
			["he"] = "רוץ 50 מטרים ב3 משחקים רצופים",						
			["es"] = "Alcanzar 50 metros 3 juegos seguidos",			
			["de"] = "Reichweite 50 Meter 3 Spiele in Folge",			
			["fr"] = "Atteindre 50 mètres 3 matchs de suite",			
			["ar"] = "قم بالوصول إلى 50 متر 3 مباريات على التوالي",		
			["ru"] = "Достигните 50 метров 3 игры подряд",
			["it"] = "Raggiungi 50 metri per 3 giochi di fila",
			["pl"] = "Osiągnij 50 metrów w 3 grach pod rząd",
			["pt"] = "Alcançar 50 metros em 3 jogos seguidos",
		},
["topScore3100"] =
		{
			["en"] = "Reach 100 meters 3 games in a row",
			["he"] = "רוץ 100 מטרים ב3 משחקים רצופים",						
			["es"] = "Alcanzar 100 metros 3 juegos seguidos",			
			["de"] = "Reichweite 100 Meter 3 Spiele in Folge",			
			["fr"] = "Atteindre 100 mètres 3 matchs de suite",			
			["ar"] = "قم بالوصول إلى 50 متر 3 مباريات على التوالي",		
			["ru"] = "Достигните 100 метров 3 игры подряд",
			["it"] = "Raggiungi 100 metri per 3 giochi di fila",
			["pl"] = "Osiągnij 100 metrów w 3 grach pod rząd",
			["pt"] = "Alcançar 100 metros em 3 jogos seguidos",
		},


["hattrick"] =
		{
			["en"] = "Score a goal 3 games in a row",
			["he"] = "שים גול ב3 משחקים ברצף",						
			["es"] = "Mete gol 3 juegos seguidos",			
			["de"] = "In 3 Spielen in Folge ein Tor erzielen",			
			["fr"] = "Marquer un but 3 matchs dans une rangée",			
			["ar"] = "احرز هدفاً 3 مباريات على التوالي",		
			["ru"] = "Забейте гол 3 игры подряд",
			["it"] = "Segna un goal per 3 partite di fila",
			["pl"] = "Strzel gola w 3 grach pod rząd",
			["pt"] = "Marcar um golo 3 jogos seguidos",
		},
["fireGoal"] =
		{
			["en"] = "Score a goal with fire ball",
			["he"] = "שים גול בזמן קומבו פרקפקט",						
			["es"] = "Mete un gol con una bola de fuego",			
			["de"] = "Erziele ein Ziel mit Feuerball",			
			["fr"] = "Marquer un but avec boule de feu",			
			["ar"] = "احرز هدف بكرة النار",		
			["ru"] = "Забейте гол огненным мячом",
			["it"] = "Segna un goal con la palla di fuoco",
			["pl"] = "Strzel gola kulą ognia",
			["pt"] = "Marcar um golo com a bola de fogo",
		},
["headerGoal"] =
		{
			["en"] = "Score a goal with a header",
			["he"] = "שים גול עם הראש",						
			["es"] = "Mete un gol con un cabezazo",			
			["de"] = "Erziele ein Ziel mit einem Header",			
			["fr"] = "Marquer un but avec un en-tête",			
			["ar"] = "احرز هدف برأسية",		
			["ru"] = "Забейте гол заголовком",
			["it"] = "Valuta un obiettivo con una testata",
			["pl"] = "Strzel gola głową",
			["pt"] = "Marcar um golo com um cabeceamento",
		},
["saltaGoal"] =
		{
			["en"] = "Score a goal with a bicycle kick",
			["he"] = "שים גול במספרת",						
			["es"] = "Mete gol con una patada de bicicleta",			
			["de"] = "Erreichen Sie Ihr Ziel mit einem Fahrradstoß",			
			["fr"] = "Marquer un but avec un kick de vélo",			
			["ar"] = "احرز هدف بركلة مزدوجة",		
			["ru"] = "Забейте гол с помощью велосипедного удара",
			["it"] = "Valuta un gol con una sforbiciata",
			["pl"] = "Strzel gola przewrotką",
			["pt"] = "Marcar um golo com um pontapé de bicicleta",
		},
["marathon"] =
		{
			["en"] = "Run a marthon",
			["he"] = "רוץ למרחק של מרתון",						
			["es"] = "Corre un maratón",			
			["de"] = "Machen Sie einen Marthon",			
			["fr"] = "Exécuter un Marathon",			
			["ar"] = "اجري ماراثون",		
			["ru"] = "Запустите мартон",
			["it"] = "Valuta un gol con una sforbiciata",
			["pl"] = "Przebiegnij maraton",
			["pt"] = "Correr uma maratona",
		},
["goldDigger"] =
		{
			["en"] = "Collect a coin from the edge",
			["he"] = "אסוף מטבע מקצה המסך למעלה",						
			["es"] = "Recoge una moneda desde el borde",			
			["de"] = "Sammeln Sie eine Münze vom Rand",			
			["fr"] = "Collecter une pièce de monnaie du bord",			
			["ar"] = "إجمع قطعة نقدية من الحافة",		
			["ru"] = "Соберите монету с верхнего края",
			["it"] = "Raccogli una moneta dal bordo",
			["pl"] = "Zbierz monetę z krawędzi",
			["pt"] = "Recolher uma moeda na extremidade",
		},

["challengeCompleted"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Desafío completado",			
			["de"] = "Herausforderung abgeschlossen",			
			["fr"] = "Défi terminé",			
			["ar"] = "إنتهى التحدي",		
			["ru"] = "Задание выполнено",
			["it"] = "Sfida completata",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Desafio Concluído ",
		},		

["changeLegTip"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Desafío completado",			
			["de"] = "Herausforderung abgeschlossen",			
			["fr"] = "Défi terminé",			
			["ar"] = "إنتهى التحدي",		
			["ru"] = "Задание выполнено",
			["it"] = "Sfida completata",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Desafio Concluído ",
		},		

["jumpingTip"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Desafío completado",			
			["de"] = "Herausforderung abgeschlossen",			
			["fr"] = "Défi terminé",			
			["ar"] = "إنتهى التحدي",		
			["ru"] = "Задание выполнено",
			["it"] = "Sfida completata",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Desafio Concluído ",
		},		

["perfectSafeTip"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Desafío completado",			
			["de"] = "Herausforderung abgeschlossen",			
			["fr"] = "Défi terminé",			
			["ar"] = "إنتهى التحدي",		
			["ru"] = "Задание выполнено",
			["it"] = "Sfida completata",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Desafio Concluído ",
		},	
["jumpingDecelerateTip"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Desafío completado",			
			["de"] = "Herausforderung abgeschlossen",			
			["fr"] = "Défi terminé",			
			["ar"] = "إنتهى التحدي",		
			["ru"] = "Задание выполнено",
			["it"] = "Sfida completata",
			["pl"] = "Najwyższa Kombinacja",
			["pt"] = "Desafio Concluído ",
		},		
["levelNewItems"] =
		{
			["en"] = "You can now use the following items in the shop",
			["he"] = "אתה יכול לבחור את הפריטים הבאים בחנות",						
			["es"] = "Ahora puede utilizar los siguientes artículos en la tienda",			
			["de"] = "Sie können nun die folgenden Artikel im Shop verwenden",			
			["fr"] = "Vous pouvez maintenant utiliser les éléments suivants dans la boutique",			
			["ar"] = "يمكنك الآن استخدام العناصر التالية في المتجر",		
			["ru"] = "Теперь вы можете использовать следующие предметы в магазине",
			["it"] = "Adesso puoi usare i seguenti elementi nel negozio",
			["pl"] = "Możesz teraz skorzystać z następujących przedmiotów w sklepie",
			["pt"] = "Pode agora utilizar os seguintes itens na loja",
		},				
["levelUp"] =
		{
			["en"] = "LEVEL UP",
			["he"] = "עלית רמה",						
			["es"] = "Nivel",			
			["de"] = "LEVEL UP",			
			["fr"] = "niveau",			
			["ar"] = "مستوى",		
			["ru"] = "уровень",
			["it"] = "Livello",
			["pl"] = "Poziom",
			["pt"] = "Nível",
		},		



--You must change leg every kick
--Remeber to jump over static obstacles
--You need to run faster to avoid the enemy behind you
--Pay attention to the coach and you will know if you kick the ball correctly
--Scoring goals gives you more coins
--During perfect combo you are safe from enemies and obstacles	
--Rookie
--Beginner
--Talented
--Advanced
--Professional
--Expert
--Master
--Supa Strika
--You reached Level
--You can now use the following items in the shop
--Special Offer
--Remove ads
--Limited time offer
--Starter pack
--Big pack
--special pack
--Buy 
--Shakes, Rasta, El Matador, Cool Joe, Twisting Tiger, North Shaw, Blok, Klaus, Big Bo
--Stadium, Glacier, Desert, Castle, Eagle

--CHALLENGES
--Reach 10 Meters"
--Kick the ball 5 times"
--Collect a coin
--Jump over obstacle"
--"Swap legs 6 times"
--"Perfect kick 4 times"
--"Score a goal"
--"Reach 60 Meters without jumping"
--"Run away from the bully"
--"Reach maximum speed"
--"Collect 4 coins in perfect spree"
--"Collect 6 coins in perfect spree"
--"Reach 50 meters 3 games in a row"
--"Reach 100 meters 3 games in a row"
--"Score a goal 3 games in a row"
--"Score a goal with fire ball"
--"Score a goal with a header"
--"Score a goal with a bicycle kick"
--"Run a marthon"
--"Collect a coin from the edge"
--Challenge Completed


}
--local language =  system.getPreference("ui", "language")
 



local defaultLanguage = "en"
--local defaultLanguage = "he"

function getTransaltedText( labelCode )
	local language = system.getPreference("ui", "language")


	if commonData.gameData and commonData.gameData.language  then
		language = commonData.gameData.language
	end

	
	if language == "Hebrew" or language == "עברית" then
		language = "he"
	end	

	if language == "Italian" or  language == "italian" or language == "Italiano" then
		language = "it"
	end	

	if language == "uk" then
	 	language = "ru"
	end	

	--print(language)
 	if dictionary[labelCode] then
 		if dictionary[labelCode][language] then
 			return dictionary[labelCode][language]
 		else
 			return dictionary[labelCode][defaultLanguage]
 		end	
 	else 
 		return ""	
 	end	
end 

function setTransalteLang( lang )
	language = lang
end 
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
			["ru"] = "Использование",
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
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "compteurs totaux",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",				
			["pt"] = "metros totais",
		},										
["youReached"] =
		{
			["en"] = "you reached",
			["he"] = "הגעת ל",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "vous avez atteint",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",				
			["pt"] = "você alcançou",
		},					



["reacehedMeters10"] =
		{
			["en"] = "Reach 10 Meters",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 10 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 10 Metros",
			
		},
["reacehedMeters20"] =
		{
			["en"] = "Reach 20 Meters",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 20 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 20 Metros",
		},
["reacehedMeters50"] =
		{
			["en"] = "Reach 50 Meters",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 10 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 50 Metros",
		},
["reacehedMeters100"]  =
		{
			["en"] = "Reach 100 Meters" ,
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 100 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 100 Metros",
		},
["reacehedMeters150"]  =
		{
			["en"] = "Reach 150 Meters" ,
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 150 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 150 Metros",
		},
["reacehedMeters200"] =
		{
			["en"] = "Reach 200 Meters" ,
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 200 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 200 Metros",
		},
["reacehedMeters300"] =
		{
			["en"] = "Reach 300 Meters" ,
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 300 mètres",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 300 Metros",
		},
["kick5time"] =
		{
			["en"] = "Kick the ball 5 times",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Kick la balle 5 fois",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Chutar a bola 5 vezes",
		},
["collectCoin"] =
		{
			["en"] = "Collect a coin",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Collecter une pièce de monnaie",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Recolher uma moeda",
		},
["jumpObstecale"] =
		{
			["en"] = "Jump over obstacle",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Sauter par-dessus obstacle",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Saltar sobre obstáculo",
		},

["swap6"] =
		{
			["en"] = "Swap legs 6 times",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Echanger les jambes 6 fois",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Trocar de pernas 6 vezes",
		},

["perfect4"] =
		{
			["en"] = "Perfect kick 4 times",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Frapper parfait 4 fois",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Um pontapé perfeito 4 vezes",
		},
["perfect6"] =
		{
			["en"] = "Perfect kick 6 times",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Frapper parfait 6 fois",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Um pontapé perfeito 6 vezes",
		},
["scoreGoal"] =
		{
			["en"] = "Score a goal",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Marquer un but",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Marcar um golo",
		},


["noJump60"] =
		{
			["en"] = "Reach 60 Meters without jumping",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 60 mètres sans sauter",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 60 Metros sem saltar",
		},
["runFromBully"] =
		{
			["en"] = "Run away from the bully",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Fuis l'intimidateur",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Fugir do agressor",
		},
["maxSpeed"] =
		{
			["en"] = "Reach maximum speed",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre la vitesse maximale",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar a velocidade máxima",
		},


["collectSpreeCoins"] =
		{
			["en"] = "Collect 4 coins in perfect spree",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Collectionnez 4 pièces en parfaite frénésie",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Recolher 4 moedas numa sequência perfeita",
		},
["collectSpreeCoins2"] =
		{
			["en"] = "Collect 6 coins in perfect spree",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Collectionnez 6 pièces en parfaite frénésie",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Recolher 6 moedas numa sequência perfeita",
		},
["topScore350"] =
		{
			["en"] = "Reach 50 meters 3 games in a row",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 50 mètres 3 matchs de suite",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 50 metros em 3 jogos seguidos",
		},
["topScore3100"] =
		{
			["en"] = "Reach 100 meters 3 games in a row",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Atteindre 100 mètres 3 matchs de suite",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Alcançar 100 metros em 3 jogos seguidos",
		},


["hattrick"] =
		{
			["en"] = "Score a goal 3 games in a row",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Marquer un but 3 matchs dans une rangée",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Marcar um golo 3 jogos seguidos",
		},
["fireGoal"] =
		{
			["en"] = "Score a goal with fire ball",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Marquer un but avec boule de feu",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Marcar um golo com a bola de fogo",
		},
["headerGoal"] =
		{
			["en"] = "Score a goal with a header",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Marquer un but avec un en-tête",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Marcar um golo com um cabeceamento",
		},
["saltaGoal"] =
		{
			["en"] = "Score a goal with a bicycle kick",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Marquer un but avec un kick de vélo",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Marcar um golo com um pontapé de bicicleta",
		},
["marathon"] =
		{
			["en"] = "Run a marthon",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Exécuter un Marathon",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Correr uma maratona",
		},
["goldDigger"] =
		{
			["en"] = "Collect a coin from the edge",
			["he"] = "בעט בכדור כשהעיגול נהיה ירוק, כדי להגביר מהירות ולקבל קומבו",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Collecter une pièce de monnaie du bord",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Recolher uma moeda na extremidade",
		},

["challengeCompleted"] =
		{
			["en"] = "Challenge Completed",
			["he"] = "האתגר הושלם",						
			["es"] = "Trate de golpear la pelota cuando el círculo se está cerrando, para ganar velocidad y combos",			
			["de"] = "Versuchen Sie, den Ball zu treffen, wenn der Kreis sich schließt, um Geschwindigkeit und Combopunkte zu gewinnen.",			
			["fr"] = "Défi terminé",			
			["ar"] = "حاول أن تركل الكرة أثناء إغلاق الدائرة, لتحصل على سرعة و كومبو",		
			["ru"] = "Попытайтесь поразить мяч, когда круг закрывается, чтобы получить скорость и комбо.",
			["it"] = "Cerca di colpire la palla quando il cerchio si sta chiudendo, per guadagnare velocità e combinazione.",
			["pl"] = "Próbuj uderzyć piłkę, gdy koło się zamyka, aby zyskać szybkość i kombinacje.",
			["pt"] = "Desafio Concluído",
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
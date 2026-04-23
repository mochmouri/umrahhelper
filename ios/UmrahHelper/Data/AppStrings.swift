import Foundation

struct AppStrings {
    let isArabic: Bool

    // MARK: - Tabs
    var tabGuide: String    { isArabic ? "الدليل"  : "Guide" }
    var tabHistory: String  { isArabic ? "السجل"   : "History" }
    var tabAdhkar: String   { isArabic ? "الأذكار" : "Adhkar" }

    // MARK: - Stage 0 — Welcome
    var welcomeSubtitle: String { isArabic
        ? "دليلٌ خطوةً بخطوةٍ لأداء عمرتك"
        : "A step-by-step companion for your Umrah"
    }
    var welcomeBody: String { isArabic
        ? "العمرة هي الحجّ الأصغر إلى مكة المكرمة؛ وهي عبادة تطوّعية يمكن أداؤها في أي وقت من العام. وعلى الرغم من أنها أقصر من الحج، إلا أنها تحمل ثقلًا روحيًا عظيمًا، وفرصةً نفيسة للتجديد والتقرّب إلى الله. يرشدك هذا الدليل خلال كل خطوة — من لبس الإحرام حتى قصّ الشعر — ليبقى قلبك في العبادة لا في اللوجستيات."
        : "Umrah is the lesser pilgrimage to Makkah; it is a voluntary act of worship that may be performed at any time of the year. Though shorter than Hajj, it carries immense spiritual weight and is a profound opportunity for renewal and closeness to Allah. This guide walks you through each step, from putting on Ihram to the final cut of the hair, so your heart can remain in worship rather than in logistics."
    }
    var beginButton: String     { isArabic ? "ابدأ"                 : "BEGIN" }
    var orJumpToStep: String    { isArabic ? "أو انتقل إلى خطوة"    : "or jump to a step" }
    var stageLabels: [String]   { isArabic
        ? ["التجهّز للميقات", "عند الميقات", "الطواف", "السعي", "التحلّل"]
        : ["Miqat Prep", "At Miqat", "Tawaf", "Saʿi", "Tahleel"]
    }

    // alerts (welcome)
    var jumpAheadTitle: String   { isArabic ? "تخطّي للأمام؟"                                    : "Jump ahead?" }
    var jumpAheadConfirm: String { isArabic ? "تخطّي للأمام"                                     : "Jump ahead" }
    var jumpAheadCancel: String  { isArabic ? "إلغاء"                                             : "Cancel" }
    var jumpAheadMessage: String { isArabic ? "لم تصل إلى هذه الخطوة بعد. هل تريد التخطّي على أي حال؟" : "You haven't reached this step yet. Jump ahead anyway?" }

    // alerts (back)
    var goBackTitle: String   { isArabic ? "الرجوع؟"                  : "Go back?" }
    var goBackConfirm: String { isArabic ? "الرجوع"                   : "Go back" }
    var goBackStay: String    { isArabic ? "البقاء"                   : "Stay" }
    var goBackMessage: String { isArabic ? "تقدّمك في هذه المرحلة محفوظ." : "Your progress in this stage is saved and will be preserved." }

    // MARK: - Stage 1
    var stage1Number: String   { isArabic ? "المرحلة ١"  : "Stage 1" }
    var stage1Title: String    { isArabic ? "قبل الميقات" : "Before Miqat" }
    var stage1Subtitle: String { isArabic ? "أعدّ جسدك وثيابك ونيّتك." : "Prepare your body, your garments, and your intention." }
    var saudiaNote: String     { isArabic
        ? "هل أنت على الخطوط السعودية؟ سيُعلن طاقم الطائرة عند اقترابكم من الميقات. كن مستعدًا بثياب الإحرام قبل الصعود إلى الطائرة، أو على الأقل قبل الإعلان."
        : "Travelling on Saudia Airlines? The cabin crew will announce when you are crossing the Miqat. Be ready in Ihram clothing before boarding, or at least before the announcement."
    }
    var dosAndDontsTitle: String { isArabic ? "المسموح والممنوع" : "Do's & Don'ts" }
    var dosAndDonts: [(text: String, isDo: Bool)] { isArabic ? [
        ("الاغتسال (الغسل الكامل للجسم) قبل الإحرام", true),
        ("للرجال: إزار ورداء أبيضان غير مخيطين. يمكن استخدام حزام لتثبيتهما.", true),
        ("للنساء: ملابس محتشمة وفضفاضة — بأي لون", true),
        ("النيّة عند الوصول إلى الميقات", true),
        ("قصّ الأظافر وتقليم الشعر قبل الإحرام — لا يجوز بعد النيّة", true),
        ("لا عطر ولا منتجات معطّرة — بعد النيّة", false),
        ("للرجال: لا ملابس مخيطة — بعد النيّة", false),
        ("للرجال: لا غطاء للرأس — بعد النيّة", false),
        ("لا قصّ ولا نتف ولا حلق للشعر أو الأظافر — بعد النيّة", false),
        ("لا علاقات زوجية — بعد النيّة", false),
        ("لا جدال ولا قتال ولا سبّ ولا فحش في القول.", false),
        ("لا صيد ولا إيذاء للحيوانات. غير أن قتل الحيوانات الضارة (كالأفاعي والعقارب) جائز.", false),
    ] : [
        ("Make Ghusl (full body wash) before entering Ihram", true),
        ("Men: wear two white unstitched sheets (izaar + rida'). A belt can be used to secure them.", true),
        ("Women: wear modest, loose clothing — any colour", true),
        ("Make your Niyyah when you reach the Miqat", true),
        ("Clip nails and trim hair before — not permissible after Niyyah", true),
        ("No perfume or scented products — after Niyyah", false),
        ("Men: no stitched clothing — after Niyyah", false),
        ("Men: no head covering — after Niyyah", false),
        ("No cutting/plucking/shaving of hair or nails — after Niyyah", false),
        ("No sexual relations — after Niyyah", false),
        ("No arguing, fighting, cursing, or using foul language.", false),
        ("No hunting or disturbing wildlife. However, killing harmful animals (like snakes/scorpions) is allowed.", false),
    ]}
    var stage1BodyText: String   { isArabic
        ? "بعد أن تغتسل وتُعدّ ثيابك، توجّه إلى الميقات, ستُعلن نيّتك وتبدأ التلبية من هناك."
        : "Once you have made Ghusl and prepared your garments, proceed to the Miqat. You will make your Niyyah and begin reciting the Talbiyah there."
    }
    var continueToMiqat: String  { isArabic ? "متابعة إلى الميقات ←" : "CONTINUE TO MIQAT →" }

    // MARK: - Stage 2
    var stage2Number: String   { isArabic ? "المرحلة ٢"   : "Stage 2" }
    var stage2Title: String    { isArabic ? "عند الميقات"  : "At the Miqat" }
    var stage2Subtitle: String { isArabic ? "بعد النيّة تبدأ أحكام الإحرام." : "The moment you make Niyyah, Ihram begins." }

    var niyyahTitle: String { isArabic ? "النيّة" : "Niyyah — The Intention" }
    var niyyahBody: String  { isArabic
        ? "استقبل القبلة إن أمكن، وارتدِ ثياب الإحرام إن لم تكن قد لبستها، ثم اعقد النيّة في قلبك أوانطق بها."
        : "Face the Qibla (if possible), put on your Ihram garments if not already wearing them, and make this intention with your heart or say it aloud."
    }
    // Arabic: one string. English: split around the italic word.
    var niyyahNoteArabic: String { "لهذه الصيغة من النيّة فائدة خاصة: إذا حال مانعٌ من إتمام العمرة — كالمرض أو العجز المالي أو الحيض أو أي طارئ آخر — جاز للمُحرِم التحلّل دون أن يلزمه هدي الإحصار أو فدية." }
    var niyyahNotePre: String    { "There are several forms of declaring your intention. The benefit of this particular form is that if an obstacle prevents completion — such as illness, lack of funds, menstruation for women, or any other emergency — the person in Ihram may exit their Ihram and is not required to offer the sacrifice due for being prevented (" }
    var niyyahNoteItalic: String { "hady al-iḥṣār" }
    var niyyahNotePost: String   { "), nor any expiatory sacrifice." }

    var talbiyahTitle: String      { isArabic ? "التلبية" : "Talbiyah" }
    var talbiyahBody: String       { isArabic
        ? "ابدأ التلبية فور الإحرام. واستمرّ في ترديدها — بصوت عالٍ للرجال، وبصوت خافت للنساء — حتى تبدأ بالطواف."
        : "Begin reciting the Talbiyah immediately after Niyyah. Continue reciting it — loudly for men, softly for women — until you begin Tawaf."
    }
    var talbiyahStarted: String    { isArabic ? "✓  بدأتُ بالتلبية"    : "✓  I have started reciting" }
    var talbiyahMarkStarted: String { isArabic ? "سجّل البداية"        : "Mark as started" }
    var talbiyahReminder: String   { isArabic ? "سجّل بداية التلبية قبل المتابعة." : "Mark the Talbiyah as started before proceeding." }

    var mosqueTitle: String { isArabic ? "دخول المسجد الحرام" : "Entering Al-Masjid Al-Haraam" }
    var mosquePre: String   { isArabic ? "ادخل بقدمك "        : "Enter with your " }
    var mosqueBold: String  { isArabic ? "اليمنى أولًا"        : "right foot first" }
    var mosquePost: String  { isArabic
        ? ". قل هذا الدعاء عند الدخول. وحين ترى الكعبة للمرة الأولى، قِف وادعُ, فهذه لحظة إجابة الدعاء."
        : ". Say this dua as you step inside. When you first see the Ka'bah, pause — this is a moment when duas are answered."
    }
    var proceedToTawaf: String { isArabic ? "متابعة إلى الطواف ←" : "PROCEED TO TAWAF →" }

    // MARK: - Stage 3
    var stage3Number: String   { isArabic ? "المرحلة ٣" : "Stage 3" }
    var stage3Title: String    { isArabic ? "الطواف"    : "Tawaf" }
    var stage3Subtitle: String { isArabic
        ? "سبعة أشواط عكس اتجاه عقارب الساعة حول الكعبة، تبدأ وتنتهي عند الحجر الأسود."
        : "Seven anti-clockwise circuits around the Ka'bah, beginning and ending at the Black Stone."
    }
    var beforeYouBegin: String    { isArabic ? "قبل البدء"           : "Before You Begin" }
    var checkWudu: String         { isArabic ? "أنا على طهارة (وضوء)" : "I am in a state of Wudu'" }
    var checkBlackStone: String   { isArabic
        ? "حدّدتُ ركن الحجر الأسود (يجب أن تكون الأضواء الخضراء على يمينك)"
        : "I have located the Black Stone corner (there should be green lights to your right)"
    }
    var checkRaisedHand: String   { isArabic
        ? "استلمتُ الحجر الأسود (إن أمكن) أو رفعتُ يمناي ناحيته (يحب أن يكون الحجر على يسارك)"
        : "I have kissed the Black Stone (if possible) or raised my right hand towards it"
    }
    var blackStoneDuaTitle: String { isArabic ? "دعاء الحجر الأسود" : "Dua at the Black Stone" }
    var blackStoneDuaBody: String  { isArabic
        ? "قله عند استلام الحجر الأسود أو رفع يمناك ناحيته في بداية كل شوط."
        : "Say this when you reach or raise your right hand towards the Black Stone to begin each lap."
    }
    var beginTawaf: String         { isArabic ? "ابدأ الطواف"    : "BEGIN TAWAF" }
    var currentLapLabel: String    { isArabic ? "الشوط الحالي"  : "CURRENT LAP" }
    var yemeniCornerTitle: String  { isArabic ? "تذكير: الركن اليماني" : "YEMENI CORNER REMINDER" }
    var yemeniCornerBody: String   { isArabic
        ? "عند مرورك بالركن اليماني (قبل الحجر الأسود مباشرة)، ابدأ بترديد:"
        : "When you pass the Yemeni corner (the one before the Black Stone), begin reciting:"
    }
    var checkYemeniCorner: String  { isArabic
        ? "مررتُ بالركن اليماني وقرأتُ الدعاء"
        : "I have passed the Yemeni corner and recited the dua"
    }
    var blackStonePassTitle: String { isArabic ? "تذكير: الحجر الأسود" : "BLACK STONE CHECKPOINT" }
    var blackStonePassBody: String  { isArabic
        ? "عند العودة إلى الحجر الأسود، ارفع يمناك وقل:"
        : "When you return to the Black Stone, raise your right hand and say:"
    }
    var checkBlackStonePass: String { isArabic
        ? "مررتُ بالحجر الأسود ورفعتُ يمناي (أو استلمته)"
        : "I have passed the Black Stone and raised my right hand (or kissed it)"
    }
    var recommendedDhikrPrefix: String { isArabic ? "الأذكار المستحبة — الشوط" : "RECOMMENDED DHIKR — LAP" }
    var completeLapPromptPre: String   { isArabic ? "عند الحجر الأسود، ارفع يدك وقل "     : "At the Black Stone, raise your hand and say " }
    var completeLapPromptPost: String  { isArabic ? "، ثم اضغط عند إتمام الشوط."           : ", then tap when you have completed the circuit." }
    func completeLapButton(_ n: Int) -> String { isArabic ? "إتمام الشوط \(numeral(n))" : "COMPLETE LAP \(n)" }

    var tawafAdhkarNote: String { isArabic
        ? "هذه أذكار مستحبة. يمكنك أيضًا تلاوة القرآن الكريم، أو الدعاء، أو قول أي ذكر تشاء."
        : "These are recommended adhkar. You may also recite Quran, make personal du'a, or say any dhikr you wish."
    }

    // Converts an integer to Eastern Arabic numerals when isArabic, Western otherwise
    func numeral(_ n: Int) -> String {
        guard isArabic else { return "\(n)" }
        let eastern = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        return String(n).compactMap { c in c.wholeNumberValue.map { eastern[$0] } }.joined()
    }

    var tawafCompleteMessage: String { isArabic ? "اكتمل الطواف — تقبّل الله." : "Tawaf complete — may Allah accept it." }
    var tawafTimesTitle: String      { isArabic ? "أوقات الطواف"                : "Tawaf times" }
    func lapLabel(_ i: Int) -> String { isArabic ? "الشوط \(numeral(i + 1))" : "Lap \(i + 1)" }

    var maqamSunnahNote: String { isArabic
        ? "صلاة ركعتين خلف مقام إبراهيم سنة مؤكدة."
        : "Praying two raka'ah behind Maqam Ibrahim is a confirmed Sunnah."
    }
    var checkMaqam: String { isArabic
        ? "صلّيتُ الركعتين خلف المقام (سنة)"
        : "I have prayed two raka'ah behind Maqam Ibrahim (Sunnah)"
    }
    var maqamTitle: String  { isArabic ? "مقام إبراهيم" : "Maqam Ibrahim" }
    var maqamBody: String   { isArabic
        ? "صلِّ ركعتين خلف مقام إبراهيم أو في أي مكان خلفه إن كان مزدحمًا."
        : "Pray two raka'ah behind Maqam Ibrahim — or anywhere behind it if it is crowded."
    }
    var raka1Pre: String    { isArabic ? "الركعة الأولى: الفاتحة، ثم"  : "First raka'ah: Al-Fatiha, then" }
    var raka1Surah: String  { isArabic ? "سورة الكافرون (١٠٩)"          : "Al-Kafirun (109)" }
    var raka2Pre: String    { isArabic ? "الركعة الثانية: الفاتحة، ثم" : "Second raka'ah: Al-Fatiha, then" }
    var raka2Surah: String  { isArabic ? "سورة الإخلاص (١١٢)"           : "Al-Ikhlas (112)" }
    var zamzamText: String  { isArabic
        ? "ثم اشرب من ماء زمزم. استقبل القبلة وادعُ الله. هذا من السنة النبوية."
        : "Then drink from Zamzam. Face the Ka'bah and make dua. This is Sunnah."
    }
    var proceedToSai: String { isArabic ? "متابعة إلى السعي ←" : "PROCEED TO SAʿI →" }

    // MARK: - Stage 4
    var stage4Number: String   { isArabic ? "المرحلة ٤" : "Stage 4" }
    var stage4Title: String    { isArabic ? "السعي"     : "Saʿi" }
    var stage4Subtitle: String { isArabic
        ? "سبعة أشواط بين الصفا والمروة. الشوط = اتجاه واحد. ابدأ من الصفا."
        : "Seven rounds between Safa and Marwa. One round = one direction. Begin at Safa."
    }
    var atSafaTitle: String    { isArabic ? "عند الصفا" : "At Safa" }
    var safaPre: String        { isArabic ? "استقبل القبلة. ارفع يديك. قل " : "Face the Ka'bah. Raise your hands. Say " }
    var safaPost: String       { isArabic ? ". ادعُ الله. ثم ردّد هذا "      : ". Make personal dua. Then recite this " }
    var safaThreeTimes: String { isArabic ? "ثلاث مرات" : "three times" }
    var beginSai: String       { isArabic ? "ابدأ السعي" : "BEGIN SAʿI" }

    var roundCounterLabel: String { isArabic ? "الشوط" : "ROUND" }
    var roundLabels: [String] { isArabic
        ? ["الصفا ← المروة", "المروة ← الصفا", "الصفا ← المروة", "المروة ← الصفا",
           "الصفا ← المروة", "المروة ← الصفا", "الصفا ← المروة"]
        : ["Safa → Marwa", "Marwa → Safa", "Safa → Marwa", "Marwa → Safa",
           "Safa → Marwa", "Marwa → Safa", "Safa → Marwa"]
    }
    var endpointLabels: [String] { isArabic
        ? ["وصلتَ إلى المروة.", "عدتَ إلى الصفا.", "وصلتَ إلى المروة.", "عدتَ إلى الصفا.",
           "وصلتَ إلى المروة.", "عدتَ إلى الصفا.", "وصلتَ إلى المروة — اكتمل السعي."]
        : ["You have reached Marwa.", "You have returned to Safa.", "You have reached Marwa.", "You have returned to Safa.",
           "You have reached Marwa.", "You have returned to Safa.", "You have reached Marwa — Saʿi is complete."]
    }
    var atCurrentEndpoint: String   { isArabic ? "عند نقطتك الحالية"      : "AT YOUR CURRENT ENDPOINT" }
    var endpointDhikrBody: String   { isArabic ? " استقبل القبلة وردّد (×٣): "   : " Face the Ka'bah and recite (×3):" }
    func completeRoundButton(_ n: Int) -> String { isArabic ? "إتمام الشوط \(numeral(n))" : "COMPLETE ROUND \(n)" }
    var saiWuduNote: String { isArabic
        ? "يجوز السعي على غير طهارة، غير أن الطهارة مستحبة إذ قد ترغب في صلاة نوافل."
        : "Being in a state of Wudu' is not required for Sa'i, but is recommended as you may wish to pray optional prayers."
    }

    var saiCompleteMessage: String { isArabic ? "اكتمل السعي — تقبّل الله."  : "Saʿi complete — may Allah accept it." }
    var saiTimesTitle: String      { isArabic ? "أوقات السعي"                 : "Saʿi times" }
    func roundLabel(_ i: Int) -> String { isArabic ? "الشوط \(numeral(i + 1))" : "Round \(i + 1)" }
    var proceedToTahleel: String   { isArabic ? "متابعة إلى التحلّل ←" : "PROCEED TO TAHLEEL →" }

    // MARK: - Stage 5
    var stage5Number: String   { isArabic ? "المرحلة ٥"  : "Stage 5" }
    var stage5Title: String    { isArabic ? "التحلّل"     : "Tahleel" }
    var stage5Subtitle: String { isArabic
        ? "المرحلة الأخيرة — قصّ الشعر — هكذا يتم التحليل من الإحرام."
        : "The final act — cutting the hair — marks the end of Ihram."
    }
    var hairCuttingTitle: String { isArabic ? "قصّ الشعر" : "Hair cutting" }
    var menLabel: String         { isArabic ? "رجال"       : "Men" }
    var menText: String          { isArabic
        ? "الحدّ الأدنى هو قصّ مقدار رأس الأصبع من أنحاء الرأس كله, والأفضل حلق الرأس كله."
        : "The minimum is to cut a fingertip's length of hair from all parts of the head. The preferable act is to shave all the hair off (Halq). This is more virtuous than trimming (Taqseer)."
    }
    var womenLabel: String { isArabic ? "نساء" : "Women" }
    var womenText: String  { isArabic
        ? "اجمعي خصلةً من الشعر واقطعي منها بمقدار رأس الأصبع, ولا يجوز الحلق."
        : "Gather a lock of hair and cut a fingertip's length from its end. Do not shave."
    }
    var ihramLiftedNote: String  { isArabic
        ? "بعد القصّ، يُرفع الإحرام وتعود جميع المحظورات مباحة."
        : "After cutting, Ihram is lifted. All restrictions are now removed."
    }
    var congratsSubtitle: String { isArabic ? "تقبّل الله عمرتك."  : "May Allah accept your Umrah." }
    var congratsBody: String     { isArabic
        ? "لقد أتممتَ عمرتك. جعلها الله سببًا للمغفرة والرحمة والقُرب منه."
        : "You have completed your Umrah. May it be a source of forgiveness, mercy, and nearness to Allah."
    }
    var summaryTitle: String     { isArabic ? "الملخّص"         : "Summary" }
    var tawafLabel: String       { isArabic ? "الطواف"          : "Tawaf" }
    var saiLabel: String         { isArabic ? "السعي"           : "Saʿi" }
    var totalUmrahLabel: String  { isArabic ? "إجمالي العمرة"   : "Total Umrah" }
    var tawafLapBreakdown: String  { isArabic ? "الطواف — تفاصيل الأشواط" : "Tawaf — lap breakdown" }
    var saiRoundBreakdown: String  { isArabic ? "السعي — تفاصيل الأشواط"  : "Saʿi — round breakdown" }
    var shareSummary: String     { isArabic ? "مشاركة الملخّص"  : "SHARE SUMMARY" }
    var startOverButton: String  { isArabic ? "البدء من جديد"   : "START OVER" }
    var startOverTitle: String   { isArabic ? "البدء من جديد؟"  : "Start over?" }
    var startOverMessage: String { isArabic
        ? "سيُمسح كل تقدّم وبيانات التوقيت."
        : "This will clear all progress and timing data."
    }
    var resetButton: String  { isArabic ? "إعادة الضبط" : "Reset" }
    var cancelButton: String { isArabic ? "إلغاء"        : "Cancel" }

    // MARK: - Metrics (shared)
    var averageLabel: String { isArabic ? "المتوسط" : "Average" }
    var totalLabel: String   { isArabic ? "المجموع" : "Total" }

    // MARK: - History
    var historyTitle: String    { isArabic ? "السجل"                    : "History" }
    var noUmrahsTitle: String   { isArabic ? "لا توجد عمرات مسجّلة بعد." : "No Umrahs recorded yet." }
    var noUmrahsBody: String    { isArabic
        ? "أكمل عمرة باستخدام الدليل لرؤية سجلّك هنا."
        : "Complete an Umrah using the guide to see your history here."
    }
    var totalPill: String { isArabic ? "المجموع" : "Total" }

    // MARK: - Session Detail
    var sessionTitle: String    { isArabic ? "الجلسة"            : "Session" }
    var deleteEntry: String     { isArabic ? "حذف"               : "Delete" }
    var deleteTitle: String     { isArabic ? "حذف هذه العمرة؟"   : "Delete this entry?" }
    var deleteMessage: String   { isArabic ? "لا يمكن التراجع عن هذا الإجراء." : "This cannot be undone." }
    var deleteConfirm: String   { isArabic ? "حذف"               : "Delete" }
    var cancelButton2: String   { isArabic ? "إلغاء"             : "Cancel" }

    // MARK: - Back navigation
    var backButton: String      { isArabic ? "→ المرحلة السابقة" : "← Previous section" }

    // MARK: - Adhkar tab
    var adhkarNavTitle: String  { isArabic ? "الأذكار"                                          : "Adhkar" }
    var adhkarSubtitle: String  { isArabic ? "أذكار مأثورة من جوامع الدعاء يمكن ترديدها خلال الطواف والسعي"    : "Supplications to recite during Tawaf and Sa'i" }

    var saiAdhkarNote: String { isArabic
        ? "يمكنك تلاوة القرآن الكريم، أو الدعاء، أو قول أي ذكر تشاء وأنت تسعى."
        : "You may recite Quran, make personal du'a, or say any dhikr you wish while completing each round."
    }

    // MARK: - Sa'i jogging note
    var saiJoggingNote: String  { isArabic
        ? "ابحث عن الأضواء الخضراء على سقف المسعى. يُستحب للرجال الهرولة بينها في كل شوط. هذه سنة نبوية فقد أمر النبي ﷺ أصحابه بالإسراع هنا إظهارًا للقوة."
        : "Look for the green lights on top of the Mas'aa — men are encouraged to jog between them in every round. This is Sunnah: the Prophet ﷺ instructed the Companions to hasten here to show their strength."
    }
}

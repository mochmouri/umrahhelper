// Bilingual string system — mirrors iOS AppStrings.swift

export function toEasternArabic(n: number): string {
  const eastern = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩']
  return String(n).split('').map(c => eastern[parseInt(c)] ?? c).join('')
}

export function numeral(n: number, isArabic: boolean): string {
  return isArabic ? toEasternArabic(n) : String(n)
}

export interface Strings {
  isArabic: boolean

  // Tabs
  tabGuide: string
  tabHistory: string
  tabAdhkar: string

  // Stage 0
  welcomeSubtitle: string
  welcomeBody: string
  beginButton: string
  orJumpToStep: string
  stageLabels: string[]
  jumpAheadTitle: string
  jumpAheadMessage: string
  jumpAheadConfirm: string
  jumpAheadCancel: string
  goBackTitle: string
  goBackMessage: string
  goBackConfirm: string
  goBackStay: string

  // Stage 1
  stage1Number: string
  stage1Title: string
  stage1Subtitle: string
  saudiaNote: string
  dosAndDontsTitle: string
  dosAndDonts: { text: string; isDo: boolean }[]
  stage1BodyText: string
  continueToMiqat: string

  // Stage 2
  stage2Number: string
  stage2Title: string
  stage2Subtitle: string
  niyyahTitle: string
  niyyahBody: string
  niyyahNoteArabic: string
  niyyahNotePre: string
  niyyahNoteItalic: string
  niyyahNotePost: string
  talbiyahTitle: string
  talbiyahBody: string
  talbiyahStarted: string
  talbiyahMarkStarted: string
  talbiyahReminder: string
  mosqueTitle: string
  mosquePre: string
  mosqueBold: string
  mosquePost: string
  proceedToTawaf: string

  // Stage 3
  stage3Number: string
  stage3Title: string
  stage3Subtitle: string
  beforeYouBegin: string
  checkWudu: string
  checkBlackStone: string
  checkRaisedHand: string
  blackStoneDuaTitle: string
  blackStoneDuaBody: string
  beginTawaf: string
  currentLapLabel: string
  yemeniCornerTitle: string
  yemeniCornerBody: string
  checkYemeniCorner: string
  blackStonePassTitle: string
  blackStonePassBody: string
  checkBlackStonePass: string
  showDhikr: (n: number) => string
  hideDhikr: string
  completeLapButton: (n: number) => string
  tawafAdhkarNote: string
  tawafCompleteMessage: string
  tawafTimesTitle: string
  lapLabel: (i: number) => string
  maqamSunnahNote: string
  checkMaqam: string
  maqamTitle: string
  maqamBody: string
  raka1Pre: string
  raka1Surah: string
  raka2Pre: string
  raka2Surah: string
  zamzamText: string
  proceedToSai: string

  // Stage 4
  stage4Number: string
  stage4Title: string
  stage4Subtitle: string
  atSafaTitle: string
  safaPre: string
  safaPost: string
  safaThreeTimes: string
  beginSai: string
  roundCounterLabel: string
  roundLabels: string[]
  endpointLabels: string[]
  atCurrentEndpoint: string
  endpointDhikrBody: string
  completeRoundButton: (n: number) => string
  saiWuduNote: string
  saiCompleteMessage: string
  saiTimesTitle: string
  roundLabel: (i: number) => string
  proceedToTahleel: string
  saiAdhkarNote: string
  saiJoggingNote: string

  // Stage 5
  stage5Number: string
  stage5Title: string
  stage5Subtitle: string
  hairCuttingTitle: string
  menLabel: string
  menText: string
  womenLabel: string
  womenText: string
  ihramLiftedNote: string
  congratsSubtitle: string
  congratsBody: string
  summaryTitle: string
  tawafLabel: string
  saiLabel: string
  totalUmrahLabel: string
  tawafLapBreakdown: string
  saiRoundBreakdown: string
  shareSummary: string
  startOverButton: string
  startOverTitle: string
  startOverMessage: string
  resetButton: string
  cancelButton: string

  // Metrics
  averageLabel: string
  totalLabel: string

  // History
  historyTitle: string
  noUmrahsTitle: string
  noUmrahsBody: string
  totalPill: string
  deleteEntry: string
  deleteTitle: string
  deleteMessage: string
  deleteConfirm: string
  cancelButton2: string

  // Back navigation
  backButton: string

  // Adhkar tab
  adhkarNavTitle: string
  adhkarSubtitle: string

  // Share
  shareCopied: string
}

export function getStrings(isArabic: boolean): Strings {
  const n = (x: number) => numeral(x, isArabic)

  return {
    isArabic,

    tabGuide: isArabic ? 'الدليل' : 'Guide',
    tabHistory: isArabic ? 'السجل' : 'History',
    tabAdhkar: isArabic ? 'الأذكار' : 'Adhkar',

    welcomeSubtitle: isArabic
      ? 'دليلٌ خطوةً بخطوةٍ لأداء عمرتك'
      : 'A step-by-step companion for your Umrah',
    welcomeBody: isArabic
      ? 'العمرة هي الحجّ الأصغر إلى مكة المكرمة؛ وهي عبادة تطوّعية يمكن أداؤها في أي وقت من العام. وعلى الرغم من أنها أقصر من الحج، إلا أنها تحمل ثقلًا روحيًا عظيمًا، وفرصةً نفيسة للتجديد والتقرّب إلى الله. يرشدك هذا الدليل خلال كل خطوة — من لبس الإحرام حتى قصّ الشعر — ليبقى قلبك في العبادة لا في اللوجستيات.'
      : "Umrah is the lesser pilgrimage to Makkah; it is a voluntary act of worship that may be performed at any time of the year. Though shorter than Hajj, it carries immense spiritual weight and is a profound opportunity for renewal and closeness to Allah. This guide walks you through each step, from putting on Ihram to the final cut of the hair, so your heart can remain in worship rather than in logistics.",
    beginButton: isArabic ? 'ابدأ' : 'BEGIN',
    orJumpToStep: isArabic ? 'أو انتقل إلى خطوة' : 'or jump to a step',
    stageLabels: isArabic
      ? ['التجهّز للميقات', 'عند الميقات', 'الطواف', 'السعي', 'التحلّل']
      : ['Miqat Prep', 'At Miqat', 'Tawaf', 'Saʿi', 'Tahleel'],
    jumpAheadTitle: isArabic ? 'تخطّي للأمام؟' : 'Jump ahead?',
    jumpAheadMessage: isArabic
      ? 'لم تصل إلى هذه الخطوة بعد. هل تريد التخطّي على أي حال؟'
      : "You haven't reached this step yet. Jump ahead anyway?",
    jumpAheadConfirm: isArabic ? 'تخطّي للأمام' : 'Jump ahead',
    jumpAheadCancel: isArabic ? 'إلغاء' : 'Cancel',
    goBackTitle: isArabic ? 'الرجوع؟' : 'Go back?',
    goBackMessage: isArabic
      ? 'تقدّمك في هذه المرحلة محفوظ.'
      : 'Your progress in this stage is saved and will be preserved.',
    goBackConfirm: isArabic ? 'الرجوع' : 'Go back',
    goBackStay: isArabic ? 'البقاء' : 'Stay',

    stage1Number: isArabic ? 'المرحلة ١' : 'Stage 1',
    stage1Title: isArabic ? 'قبل الميقات' : 'Before Miqat',
    stage1Subtitle: isArabic ? 'أعدّ جسدك وثيابك ونيّتك.' : 'Prepare your body, your garments, and your intention.',
    saudiaNote: isArabic
      ? 'هل أنت على الخطوط السعودية؟ سيُعلن طاقم الطائرة عند اقترابكم من الميقات. كن مستعدًا بثياب الإحرام قبل الصعود إلى الطائرة، أو على الأقل قبل الإعلان.'
      : 'Travelling on Saudia Airlines? The cabin crew will announce when you are crossing the Miqat. Be ready in Ihram clothing before boarding, or at least before the announcement.',
    dosAndDontsTitle: isArabic ? 'المسموح والممنوع' : "Do's & Don'ts",
    dosAndDonts: isArabic ? [
      { text: 'الاغتسال (الغسل الكامل للجسم) قبل الإحرام', isDo: true },
      { text: "للرجال: إزار ورداء أبيضان غير مخيطين. يمكن استخدام حزام لتثبيتهما.", isDo: true },
      { text: 'للنساء: ملابس محتشمة وفضفاضة — بأي لون', isDo: true },
      { text: 'النيّة عند الوصول إلى الميقات', isDo: true },
      { text: 'قصّ الأظافر وتقليم الشعر قبل الإحرام — لا يجوز بعد النيّة', isDo: true },
      { text: 'لا عطر ولا منتجات معطّرة — بعد النيّة', isDo: false },
      { text: 'للرجال: لا ملابس مخيطة — بعد النيّة', isDo: false },
      { text: 'للرجال: لا غطاء للرأس — بعد النيّة', isDo: false },
      { text: 'لا قصّ ولا نتف ولا حلق للشعر أو الأظافر — بعد النيّة', isDo: false },
      { text: 'لا علاقات زوجية — بعد النيّة', isDo: false },
      { text: 'لا جدال ولا قتال ولا سبّ ولا فحش في القول.', isDo: false },
      { text: 'لا صيد ولا إيذاء للحيوانات. غير أن قتل الحيوانات الضارة (كالأفاعي والعقارب) جائز.', isDo: false },
    ] : [
      { text: 'Make Ghusl (full body wash) before entering Ihram', isDo: true },
      { text: "Men: wear two white unstitched sheets (izaar + rida'). A belt can be used to secure them.", isDo: true },
      { text: 'Women: wear modest, loose clothing — any colour', isDo: true },
      { text: 'Make your Niyyah when you reach the Miqat', isDo: true },
      { text: 'Clip nails and trim hair before — not permissible after Niyyah', isDo: true },
      { text: 'No perfume or scented products — after Niyyah', isDo: false },
      { text: 'Men: no stitched clothing — after Niyyah', isDo: false },
      { text: 'Men: no head covering — after Niyyah', isDo: false },
      { text: 'No cutting/plucking/shaving of hair or nails — after Niyyah', isDo: false },
      { text: 'No sexual relations — after Niyyah', isDo: false },
      { text: 'No arguing, fighting, cursing, or using foul language.', isDo: false },
      { text: 'No hunting or disturbing wildlife. However, killing harmful animals (like snakes/scorpions) is allowed.', isDo: false },
    ],
    stage1BodyText: isArabic
      ? 'بعد أن تغتسل وتُعدّ ثيابك، توجّه إلى الميقات, ستُعلن نيّتك وتبدأ التلبية من هناك.'
      : 'Once you have made Ghusl and prepared your garments, proceed to the Miqat. You will make your Niyyah and begin reciting the Talbiyah there.',
    continueToMiqat: isArabic ? 'متابعة إلى الميقات →' : 'CONTINUE TO MIQAT →',

    stage2Number: isArabic ? 'المرحلة ٢' : 'Stage 2',
    stage2Title: isArabic ? 'عند الميقات' : 'At the Miqat',
    stage2Subtitle: isArabic ? 'بعد النيّة تبدأ أحكام الإحرام.' : 'The moment you make Niyyah, Ihram begins.',
    niyyahTitle: isArabic ? 'النيّة' : 'Niyyah — The Intention',
    niyyahBody: isArabic
      ? 'استقبل القبلة إن أمكن، وارتدِ ثياب الإحرام إن لم تكن قد لبستها، ثم اعقد النيّة في قلبك أو انطق بها.'
      : 'Face the Qibla (if possible), put on your Ihram garments if not already wearing them, and make this intention with your heart or say it aloud.',
    niyyahNoteArabic: 'لهذه الصيغة من النيّة فائدة خاصة: إذا حال مانعٌ من إتمام العمرة — كالمرض أو العجز المالي أو الحيض أو أي طارئ آخر — جاز للمُحرِم التحلّل دون أن يلزمه هدي الإحصار أو فدية.',
    niyyahNotePre: 'There are several forms of declaring your intention. The benefit of this particular form is that if an obstacle prevents completion — such as illness, lack of funds, menstruation for women, or any other emergency — the person in Ihram may exit their Ihram and is not required to offer the sacrifice due for being prevented (',
    niyyahNoteItalic: 'hady al-iḥṣār',
    niyyahNotePost: '), nor any expiatory sacrifice.',
    talbiyahTitle: isArabic ? 'التلبية' : 'Talbiyah',
    talbiyahBody: isArabic
      ? 'ابدأ بالتلبية فور الإحرام. واستمرّ في ترديدها — بصوت عالٍ للرجال، وبصوت خافت للنساء — حتى تبدأ بالطواف.'
      : 'Begin reciting the Talbiyah immediately after Niyyah. Continue reciting it — loudly for men, softly for women — until you begin Tawaf.',
    talbiyahStarted: isArabic ? '✓  بدأتُ بالتلبية' : '✓  I have started reciting',
    talbiyahMarkStarted: isArabic ? 'سجّل البداية' : 'Mark as started',
    talbiyahReminder: isArabic ? 'سجّل بداية التلبية قبل المتابعة.' : 'Mark the Talbiyah as started before proceeding.',
    mosqueTitle: isArabic ? 'دخول المسجد الحرام' : 'Entering Al-Masjid Al-Haraam',
    mosquePre: isArabic ? 'ادخل بقدمك ' : 'Enter with your ',
    mosqueBold: isArabic ? 'اليمنى أولًا' : 'right foot first',
    mosquePost: isArabic
      ? '. قل هذا الدعاء عند الدخول. وحين ترى الكعبة للمرة الأولى، قِف وادعُ, فهذه لحظة إجابة الدعاء.'
      : ". Say this dua as you step inside. When you first see the Ka'bah, pause — this is a moment when duas are answered.",
    proceedToTawaf: isArabic ? 'متابعة إلى الطواف →' : 'PROCEED TO TAWAF →',

    stage3Number: isArabic ? 'المرحلة ٣' : 'Stage 3',
    stage3Title: isArabic ? 'الطواف' : 'Tawaf',
    stage3Subtitle: isArabic
      ? 'سبعة أشواط عكس اتجاه عقارب الساعة حول الكعبة، تبدأ وتنتهي عند الحجر الأسود.'
      : "Seven anti-clockwise circuits around the Ka'bah, beginning and ending at the Black Stone.",
    beforeYouBegin: isArabic ? 'قبل البدء' : 'Before You Begin',
    checkWudu: isArabic ? "أنا على طهارة (وضوء)" : "I am in a state of Wudu'",
    checkBlackStone: isArabic
      ? 'حدّدتُ ركن الحجر الأسود (يجب أن تكون الأضواء الخضراء على يمينك)'
      : 'I have located the Black Stone corner (there should be green lights to your right)',
    checkRaisedHand: isArabic
      ? 'استلمتُ الحجر الأسود (إن أمكن) أو رفعتُ يمناي ناحيته (يحب أن يكون الحجر على يسارك)'
      : 'I have kissed the Black Stone (if possible) or raised my right hand towards it',
    blackStoneDuaTitle: isArabic ? 'دعاء الحجر الأسود' : 'Dua at the Black Stone',
    blackStoneDuaBody: isArabic
      ? 'قله عند استلام الحجر الأسود أو رفع يمناك ناحيته في بداية كل شوط.'
      : 'Say this when you reach or raise your right hand towards the Black Stone to begin each lap.',
    beginTawaf: isArabic ? 'ابدأ الطواف' : 'BEGIN TAWAF',
    currentLapLabel: isArabic ? 'الشوط الحالي' : 'CURRENT LAP',
    yemeniCornerTitle: isArabic ? 'تذكير: الركن اليماني' : 'YEMENI CORNER REMINDER',
    yemeniCornerBody: isArabic
      ? 'عند مرورك بالركن اليماني (قبل الحجر الأسود مباشرة)، ابدأ بترديد:'
      : 'When you pass the Yemeni corner (the one before the Black Stone), begin reciting:',
    checkYemeniCorner: isArabic
      ? 'مررتُ بالركن اليماني وقرأتُ الدعاء'
      : 'I have passed the Yemeni corner and recited the dua',
    blackStonePassTitle: isArabic ? 'تذكير: الحجر الأسود' : 'BLACK STONE CHECKPOINT',
    blackStonePassBody: isArabic
      ? 'عند العودة إلى الحجر الأسود، ارفع يمناك وقل:'
      : 'When you return to the Black Stone, raise your right hand and say:',
    checkBlackStonePass: isArabic
      ? 'مررتُ بالحجر الأسود وقبلته (أو رفعتُ يمناي باتجاهه)'
      : 'I have passed the Black Stone and kissed it (or raised my hand towards it)',
    showDhikr: (x: number) => {
      if (isArabic) {
        const arabic = x === 2 ? 'دعائين' : `${n(x)} دعاء`
        return `عرض الأذكار المستحبة (${arabic})`
      }
      return `Show recommended dhikr (${x} ${x === 1 ? 'prayer' : 'prayers'})`
    },
    hideDhikr: isArabic ? 'إخفاء الأذكار' : 'Hide dhikr',
    completeLapButton: (x: number) => isArabic ? `إتمام الشوط ${n(x)}` : `COMPLETE LAP ${x}`,
    tawafAdhkarNote: isArabic
      ? 'هذه أذكار مستحبة. يمكنك أيضًا تلاوة القرآن الكريم، أو الدعاء، أو قول أي ذكر تشاء.'
      : "These are recommended adhkar. You may also recite Quran, make personal du'a, or say any dhikr you wish.",
    tawafCompleteMessage: isArabic ? 'اكتمل الطواف — تقبّل الله.' : 'Tawaf complete — may Allah accept it.',
    tawafTimesTitle: isArabic ? 'أوقات الطواف' : 'Tawaf times',
    lapLabel: (i: number) => isArabic ? `الشوط ${n(i + 1)}` : `Lap ${i + 1}`,
    maqamSunnahNote: isArabic
      ? 'صلاة ركعتين خلف مقام إبراهيم سنة مؤكدة.'
      : "Praying two raka'ah behind Maqam Ibrahim is a confirmed Sunnah.",
    checkMaqam: isArabic
      ? 'صلّيتُ الركعتين خلف المقام (سنة)'
      : "I have prayed two raka'ah behind Maqam Ibrahim (Sunnah)",
    maqamTitle: isArabic ? 'مقام إبراهيم' : 'Maqam Ibrahim',
    maqamBody: isArabic
      ? 'صلِّ ركعتين خلف مقام إبراهيم أو في أي مكان خلفه إن كان مزدحمًا.'
      : "Pray two raka'ah behind Maqam Ibrahim — or anywhere behind it if it is crowded.",
    raka1Pre: isArabic ? 'الركعة الأولى: الفاتحة، ثم' : "First raka'ah: Al-Fatiha, then",
    raka1Surah: isArabic ? 'سورة الكافرون (١٠٩)' : 'Al-Kafirun (109)',
    raka2Pre: isArabic ? 'الركعة الثانية: الفاتحة، ثم' : "Second raka'ah: Al-Fatiha, then",
    raka2Surah: isArabic ? 'سورة الإخلاص (١١٢)' : 'Al-Ikhlas (112)',
    zamzamText: isArabic
      ? 'ثم اشرب من ماء زمزم. استقبل القبلة وادعُ الله. هذا من السنة النبوية.'
      : 'Then drink from Zamzam. Face the Ka\'bah and make dua. This is Sunnah.',
    proceedToSai: isArabic ? 'متابعة إلى السعي →' : "PROCEED TO SAʿI →",

    stage4Number: isArabic ? 'المرحلة ٤' : 'Stage 4',
    stage4Title: isArabic ? 'السعي' : 'Saʿi',
    stage4Subtitle: isArabic
      ? 'سبعة أشواط بين الصفا والمروة. الشوط = اتجاه واحد. ابدأ من الصفا.'
      : 'Seven rounds between Safa and Marwa. One round = one direction. Begin at Safa.',
    atSafaTitle: isArabic ? 'عند الصفا' : 'At Safa',
    safaPre: isArabic ? 'استقبل القبلة. ارفع يديك. قل ' : "Face the Ka'bah. Raise your hands. Say ",
    safaPost: isArabic ? '. ادعُ الله. ثم ردّد هذا ' : '. Make personal dua. Then recite this ',
    safaThreeTimes: isArabic ? 'ثلاث مرات' : 'three times',
    beginSai: isArabic ? 'ابدأ السعي' : "BEGIN SAʿI",
    roundCounterLabel: isArabic ? 'الشوط' : 'ROUND',
    roundLabels: isArabic
      ? ['الصفا ← المروة', 'المروة ← الصفا', 'الصفا ← المروة', 'المروة ← الصفا',
         'الصفا ← المروة', 'المروة ← الصفا', 'الصفا ← المروة']
      : ['Safa → Marwa', 'Marwa → Safa', 'Safa → Marwa', 'Marwa → Safa',
         'Safa → Marwa', 'Marwa → Safa', 'Safa → Marwa'],
    endpointLabels: isArabic
      ? ['وصلتَ إلى المروة.', 'عدتَ إلى الصفا.', 'وصلتَ إلى المروة.', 'عدتَ إلى الصفا.',
         'وصلتَ إلى المروة.', 'عدتَ إلى الصفا.', 'وصلتَ إلى المروة — اكتمل السعي.']
      : ['You have reached Marwa.', 'You have returned to Safa.', 'You have reached Marwa.', 'You have returned to Safa.',
         'You have reached Marwa.', 'You have returned to Safa.', 'You have reached Marwa — Saʿi is complete.'],
    atCurrentEndpoint: isArabic ? 'عند نقطتك الحالية' : 'AT YOUR CURRENT ENDPOINT',
    endpointDhikrBody: isArabic ? ' استقبل القبلة وردّد (×٣): ' : ' Face the Ka\'bah and recite (×3):',
    completeRoundButton: (x: number) => isArabic ? `إتمام الشوط ${n(x)}` : `COMPLETE ROUND ${x}`,
    saiWuduNote: isArabic
      ? "يجوز السعي على غير طهارة، غير أن الطهارة مستحبة إذ قد ترغب في صلاة نوافل."
      : "Being in a state of Wudu' is not required for Sa'i, but is recommended as you may wish to pray optional prayers.",
    saiCompleteMessage: isArabic ? 'اكتمل السعي — تقبّل الله.' : "Saʿi complete — may Allah accept it.",
    saiTimesTitle: isArabic ? 'أوقات السعي' : "Saʿi times",
    roundLabel: (i: number) => isArabic ? `الشوط ${n(i + 1)}` : `Round ${i + 1}`,
    proceedToTahleel: isArabic ? 'متابعة إلى التحلّل →' : 'PROCEED TO TAHLEEL →',
    saiAdhkarNote: isArabic
      ? 'يمكنك تلاوة القرآن الكريم، أو الدعاء، أو قول أي ذكر تشاء وأنت تسعى.'
      : "You may recite Quran, make personal du'a, or say any dhikr you wish while completing each round.",
    saiJoggingNote: isArabic
      ? 'ابحث عن الأضواء الخضراء على سقف المسعى. يُستحب للرجال الهرولة بينها في كل شوط. هذه سنة نبوية فقد أمر النبي ﷺ أصحابه بالإسراع هنا إظهارًا للقوة.'
      : "Look for the green lights on top of the Mas'aa — men are encouraged to jog between them in every round. This is Sunnah: the Prophet ﷺ instructed the Companions to hasten here to show their strength.",

    stage5Number: isArabic ? 'المرحلة ٥' : 'Stage 5',
    stage5Title: isArabic ? 'التحلّل' : 'Tahleel',
    stage5Subtitle: isArabic
      ? 'المرحلة الأخيرة — قصّ الشعر — هكذا يتم التحلل من الإحرام.'
      : 'The final act — cutting the hair — marks the end of Ihram.',
    hairCuttingTitle: isArabic ? 'قصّ الشعر' : 'Hair cutting',
    menLabel: isArabic ? 'رجال' : 'Men',
    menText: isArabic
      ? 'الحدّ الأدنى هو قصّ مقدار رأس الأصبع من أنحاء الرأس كله, والأفضل حلق الرأس كله.'
      : 'The minimum is to cut a fingertip\'s length of hair from all parts of the head. The preferable act is to shave all the hair off (Halq). This is more virtuous than trimming (Taqseer).',
    womenLabel: isArabic ? 'نساء' : 'Women',
    womenText: isArabic
      ? 'اجمعي خصلةً من الشعر واقطعي منها بمقدار رأس الأصبع, ولا يجوز الحلق.'
      : "Gather a lock of hair and cut a fingertip's length from its end. Do not shave.",
    ihramLiftedNote: isArabic
      ? 'بعد القصّ، يُرفع الإحرام وتعود جميع المحظورات مباحة.'
      : 'After cutting, Ihram is lifted. All restrictions are now removed.',
    congratsSubtitle: isArabic ? 'تقبّل الله عمرتك.' : 'May Allah accept your Umrah.',
    congratsBody: isArabic
      ? 'لقد أتممتَ عمرتك. جعلها الله سببًا للمغفرة والرحمة والقُرب منه.'
      : 'You have completed your Umrah. May it be a source of forgiveness, mercy, and nearness to Allah.',
    summaryTitle: isArabic ? 'الملخّص' : 'Summary',
    tawafLabel: isArabic ? 'الطواف' : 'Tawaf',
    saiLabel: isArabic ? 'السعي' : 'Saʿi',
    totalUmrahLabel: isArabic ? 'إجمالي العمرة' : 'Total Umrah',
    tawafLapBreakdown: isArabic ? 'الطواف — تفاصيل الأشواط' : 'Tawaf — lap breakdown',
    saiRoundBreakdown: isArabic ? 'السعي — تفاصيل الأشواط' : "Saʿi — round breakdown",
    shareSummary: isArabic ? 'مشاركة الملخّص' : 'SHARE SUMMARY',
    startOverButton: isArabic ? 'البدء من جديد' : 'START OVER',
    startOverTitle: isArabic ? 'البدء من جديد؟' : 'Start over?',
    startOverMessage: isArabic
      ? 'سيُمسح كل تقدّم وبيانات التوقيت.'
      : 'This will clear all progress and timing data.',
    resetButton: isArabic ? 'إعادة الضبط' : 'Reset',
    cancelButton: isArabic ? 'إلغاء' : 'Cancel',

    averageLabel: isArabic ? 'المتوسط' : 'Average',
    totalLabel: isArabic ? 'المجموع' : 'Total',

    historyTitle: isArabic ? 'السجل' : 'History',
    noUmrahsTitle: isArabic ? 'لا توجد عمرات مسجّلة بعد.' : 'No Umrahs recorded yet.',
    noUmrahsBody: isArabic
      ? 'أكمل عمرة باستخدام الدليل لرؤية سجلّك هنا.'
      : 'Complete an Umrah using the guide to see your history here.',
    totalPill: isArabic ? 'المجموع' : 'Total',
    deleteEntry: isArabic ? 'حذف' : 'Delete',
    deleteTitle: isArabic ? 'حذف هذه العمرة؟' : 'Delete this entry?',
    deleteMessage: isArabic ? 'لا يمكن التراجع عن هذا الإجراء.' : 'This cannot be undone.',
    deleteConfirm: isArabic ? 'حذف' : 'Delete',
    cancelButton2: isArabic ? 'إلغاء' : 'Cancel',

    backButton: isArabic ? '← المرحلة السابقة' : '← Previous section',

    adhkarNavTitle: isArabic ? 'الأذكار' : 'Adhkar',
    adhkarSubtitle: isArabic
      ? 'أذكار مأثورة من جوامع الدعاء يمكن ترديدها خلال الطواف والسعي'
      : "Supplications to recite during Tawaf and Sa'i",

    shareCopied: isArabic ? 'تم النسخ إلى الحافظة' : 'Copied to clipboard',
  }
}

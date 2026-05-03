import Foundation

struct Dua {
    let arabic: String
    let transliteration: String
    let meaning: String
    var source: String? = nil
}

let niyyah = Dua(
    arabic: "لَبَّيْكَ عُمْرَةً، فَإِنْ حَبَسَنِي حَابِسٌ فَمَحِلِّي حَيْثُ حَبَسْتَنِي",
    transliteration: "Labbayka 'Umratan, fa in ḥabasanī ḥābisun fa maḥillī ḥaythu ḥabastaní.",
    meaning: "Here I am for Umrah. If I am prevented by any obstacle, then my release is wherever You hold me back."
)

let talbiyah = Dua(
    arabic: "لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لَا شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لَا شَرِيكَ لَكَ",
    transliteration: "Labbayka Llāhumma labbayk, labbayka lā sharīka laka labbayk, inna l-ḥamda wa-n-ni'mata laka wa-l-mulk, lā sharīka lak.",
    meaning: "Here I am, O Allah, here I am. Here I am — You have no partner — here I am. Verily all praise, grace and sovereignty belong to You. You have no partner.",
    source: "Bukhari & Muslim"
)

let enteringMosque = Dua(
    arabic: "بِسْمِ اللهِ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِ اللهِ، اللَّهُمَّ اغْفِرْ لِي ذُنُوبِي، وَافْتَحْ لِي أَبْوَابَ رَحْمَتِكَ، أَعُوذُ بِاللهِ الْعَظِيمِ، وَبِوَجْهِهِ الْكَرِيمِ، وَسُلْطَانِهِ الْقَدِيمِ، مِنَ الشَّيْطَانِ الرَّجِيمِ",
    transliteration: "Bismillāhi, wa-ṣ-ṣalātu wa-s-salāmu 'alā rasūlillāh. Allāhumma ighfir lī dhunūbī wa-ftaḥ lī abwāba raḥmatik. A'ūdhu billāhi l-'aẓīmi, wa bi-wajhihi l-karīmi, wa sulṭānihi l-qadīmi, mina sh-shayṭāni r-rajīm.",
    meaning: "In the name of Allah. May prayers and peace be upon the Messenger of Allah. O Allah, forgive my sins and open the doors of Your mercy for me. I seek refuge in Allah the Magnificent, His noble countenance, and His eternal sovereignty, from the accursed devil."
)

let blackStoneDua = Dua(
    arabic: "بِسْمِ اللهِ وَاللهُ أَكْبَرُ، اللَّهُمَّ إِيمَاناً بِكَ، وَتَصْدِيقاً بِكِتَابِكَ، وَوَفَاءً بِعَهْدِكَ، وَاتِّبَاعاً لِسُنَّةِ نَبِيِّكَ مُحَمَّدٍ ﷺ",
    transliteration: "Bismillāhi wallāhu akbar. Allāhumma īmānan bika, wa taṣdīqan bi-kitābika, wa wafā'an bi-'ahdika, wa-ttibā'an li-sunnati nabiyyika Muḥammadin ṣallallāhu 'alayhi wa sallam.",
    meaning: "In the name of Allah, and Allah is the Greatest. O Allah, out of faith in You, belief in Your Book, fulfillment of Your covenant, and in following the Sunnah of Your Prophet Muhammad ﷺ."
)

let maqamIbrahimAyah = Dua(
    arabic: "وَاتَّخِذُوا مِن مَّقَامِ إِبْرَاهِيمَ مُصَلًّى",
    transliteration: "Wattakhidhū min maqāmi Ibrāhīma muṣallā.",
    meaning: "And take from the station of Ibrahim a place of prayer.",
    source: "Quran 2:125"
)

let safaAyah = Dua(
    arabic: "إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللَّهِ ۖ فَمَنْ حَجَّ الْبَيْتَ أَوِ اعْتَمَرَ فَلَا جُنَاحَ عَلَيْهِ أَن يَطَّوَّفَ بِهِمَا",
    transliteration: "Inna ṣ-Ṣafā wa-l-Marwata min sha'ā'iri-llāh. Fa-man ḥajja l-bayta awi 'tamara fa-lā junāḥa 'alayhi an yaṭṭawwafa bihimā.",
    meaning: "Indeed, al-Safa and al-Marwa are among the symbols of Allah. So whoever performs Hajj to the House or performs Umrah — there is no blame upon him for walking between them.",
    source: "Quran 2:158"
)

let safaDhikr = Dua(
    arabic: "لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، لَا إِلَهَ إِلَّا اللهُ أَنْجَزَ وَعْدَهُ، وَنَصَرَ عَبْدَهُ، وَهَزَمَ الْأَحْزَابَ وَحْدَهُ",
    transliteration: "Lā ilāha illallāhu waḥdahu lā sharīka lah, lahu l-mulku wa lahu l-ḥamdu wa huwa 'alā kulli shay'in qadīr. Lā ilāha illallāh, anjaza wa'dah, wa naṣara 'abdah, wa hazama l-aḥzāba waḥdah.",
    meaning: "There is no god but Allah alone, with no partner. To Him belongs all sovereignty and all praise, and He has power over all things. There is no god but Allah — He fulfilled His promise, gave victory to His servant, and defeated the confederates alone.",
    source: "Muslim"
)

let greenLightsDua = Dua(
    arabic: "رَبِّ اغْفِرْ وَارْحَمْ وَتَجَاوَزْ عَمَّا تَعْلَمْ إِنَّكَ تَعْلَمُ مَا لَا نَعْلَمْ إِنَّكَ أَنْتَ اللهُ الْأَعَزُّ الْأَكْرَمُ",
    transliteration: "Rabbi-ghfir warḥam wa tajāwaz 'ammā ta'lam, innaka ta'lamu mā lā na'lam, innaka anta-llāhu l-a'azzu l-akram.",
    meaning: "O my Lord! Forgive us, and have mercy upon us, and pardon our sins that You only know. Indeed, You know what we do not know. Indeed, You are Allah, the Most Honoured and Noble."
)

let yemeniCornerDua = Dua(
    arabic: "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
    transliteration: "Rabbanā ātinā fi d-dunyā ḥasanatan wa fi l-ākhirati ḥasanatan wa qinā 'adhāba n-nār.",
    meaning: "Our Lord, give us good in this world and good in the Hereafter, and protect us from the punishment of the Fire.",
    source: "Quran 2:201"
)

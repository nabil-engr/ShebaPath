-- ==============================================================================
-- ShebaPath SEO & Multi-Query Ranking Enhancements (2025/2026)
-- Target: 1st Page Google Ranking for High-Volume Bangla, Banglish & English Queries
-- Safe to re-run: Updates bd_guides and bd_blog_posts with rich keywords and summaries
-- ==============================================================================

-- 1. E-PASSPORT GUIDE SEO
UPDATE bd_guides
SET 
    keywords = 'kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport, passport bananor dhap, e-passport bananor dhap, steps for applying passport, passport e apply er jonno ki ki lagbe, passport korte koto taka lage, passport fees bd 2026, passport renew korar niyom, urgent passport kivabe banabo, passport police verification process, epassport appointment kivabe nibo, passport status check bd, পাসপোর্ট করার নিয়ম, ই-পাসপোর্ট আবেদন করার নিয়ম, পাসপোর্ট করতে কি কি লাগে, পাসপোর্ট তৈরির প্রক্রিয়া, পাসপোর্ট বানানোর সহজ উপায়, নতুন পাসপোর্ট করার নিয়ম ২০২৬, ই পাসপোর্ট ফি জমা দেওয়ার নিয়ম, পাসপোর্ট ডেলিভারি চেক, পুলিশ ভেরিফিকেশন নিয়ম, how to apply for epassport in bangladesh, bangladesh passport online application steps, epassport fee structure, passport renewal bangladesh, documents needed for passport bd, emergency passport delivery bangladesh',
    meta_description = 'Complete e-Passport online application and renewal guide for Bangladesh (2026). Fee tables, required documents, biometric enrollment, and police verification.',
    summary = 'Step-by-step complete walkthrough for Bangladeshi e-Passport online application and renewal. Learn about required documents (NID or Birth Certificate), 2026 fee table, appointment booking, biometric capture, and police verification.'
WHERE slug IN ('bangladesh-epassport-application-guide', 'passport');

-- 2. DRIVING LICENCE GUIDE SEO
UPDATE bd_guides
SET 
    keywords = 'kivabe driving licence korbo, brta driving licence, learner licence korar niyom, driving test kivabe hoy, bike licence banate koto taka lage, smart card driving licence delivery check, bsp brta online registration, বিআরটিএ ড্রাইভিং লাইসেন্স করার নিয়ম, লার্নার লাইসেন্স আবেদন, স্মার্ট কার্ড ড্রাইভিং লাইসেন্স পাওয়ার ধাপ, ড্রাইভিং টেস্ট পরীক্ষার নিয়ম, মোটরসাইকেল লাইসেন্স ফি, how to get driving licence in bangladesh, brta learner driving licence online, driving test procedure bangladesh, brta smart card fees, bsp portal account open, driving medical certificate form',
    meta_description = 'Comprehensive step-by-step guide to applying for a Learner and Smart Card Driving Licence through BRTA Service Portal (BSP).',
    summary = 'Comprehensive step-by-step guide to applying for a Learner and Smart Card Driving Licence through the BRTA Service Portal (BSP), test procedure, biometric submission, and status tracking.'
WHERE slug IN ('driving-licence-bangladesh-guide', 'driving-licence');

-- 3. NATIONAL ID (NID) CORRECTION SEO
UPDATE bd_guides
SET 
    keywords = 'kivabe nid card shongshodhon korbo, new voter howar niyom, smart nid card kivabe pabo, nid wallet verification kivabe kore, nid hariye gele ki korbo, voter id card correction process bangladesh, nid card download online, ভোটার আইডি কার্ড সংশোধন করার নিয়ম, নতুন ভোটার হওয়ার নিয়ম, স্মার্ট কার্ড তোলার নিয়ম, এনআইডি ওয়ালেট দিয়ে ছবি ভেরিফিকেশন, হারিয়ে যাওয়া আইডি কার্ড তোলার নিয়ম, জন্ম তারিখ সংশোধন, অনলাইন এনআইডি ডাউনলোড, online nid card correction bd, smart nid card download, nid wallet facial verification steps, lost nid reissue procedure, nid correction fee bkash',
    meta_description = 'Instructions on correcting name, date of birth, address, or parent information on your Bangladesh National ID (NID) using Election Commission portal.',
    summary = 'Instructions on correcting name, date of birth, address, or parent information on your Bangladesh National ID (NID) using the Election Commission online portal.'
WHERE slug IN ('nid-correction-smart-card-reissue', 'national-id');

-- 4. BIRTH REGISTRATION (BDRIS) SEO
UPDATE bd_guides
SET 
    keywords = 'kivabe jonmo nibondhon korbo, online birth certificate apply bd, jonmo nibondhon shongshodhon korar niyom, 17 digit birth registration download, birth certificate e bhul thakle ki korbo, jonmo nibondhon english korar niyom, অনলাইনে জন্ম নিবন্ধন আবেদন করার নিয়ম, ১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন, জন্ম নিবন্ধন সংশোধন, জন্ম নিবন্ধন ইংরেজি করার নিয়ম, জন্ম নিবন্ধন ফি, bangladesh birth certificate online application, bdris digital birth registration, correct birth certificate online, union parishad birth certificate process, 17 digit birth certificate verification',
    meta_description = 'Official process to register a new birth or apply for a bilingual 17-digit digital birth registration certificate through the Bangladesh BDRIS portal.',
    summary = 'Official process to register a new birth or apply for a bilingual 17-digit digital birth registration certificate through the Bangladesh BDRIS portal.'
WHERE slug IN ('online-birth-registration-bdris', 'birth-certificate');

-- 5. LAND MUTATION (E-NAMJARI) SEO
UPDATE bd_guides
SET 
    keywords = 'e-namjari land mutation, kivabe jomir namjari korbo, land mutation online bd, mutation land gov bd, dcr download kivabe korbo, porcha khatian ber korar niyom, jomir namjari korte koto taka lage, ac land office hearing, ই-নামজারি আবেদন করার নিয়ম, জমির নামজারি করার সহজ উপায়, ডিসিআর ও খতিয়ান ডাউনলোড, নামজারি ফি কত, বায়া দলিল ও খতিয়ান যাচাই, সহকারী কমিশনার ভূমি অফিস, land mutation fee bangladesh, edcr download online, online land transfer bd',
    meta_description = 'The complete digital workflow for transferring and recording land title records (Mutation / Porcha / DCR) via the Ministry of Land e-Mutation portal.',
    summary = 'The complete digital workflow for transferring and recording land title records (Mutation / Porcha / DCR) via the Ministry of Land e-Mutation portal.'
WHERE slug IN ('e-namjari-land-mutation-online', 'land-mutation');

-- 6. E-TRADE LICENSE SEO
UPDATE bd_guides
SET 
    keywords = 'etrade license bd, kivabe trade licence korbo, dncc etrade license apply, dscc trade license renew, trade license korte ki ki lagbe, trade license fees in bangladesh, business registration bangladesh, ট্রেড লাইসেন্স করার নিয়ম, নতুন ট্রেড লাইসেন্স আবেদন, ট্রেড লাইসেন্স নবায়ন ফি, ঢাকা উত্তর ও দক্ষিণ সিটি কর্পোরেশন ট্রেড লাইসেন্স, অনলাইন ট্রেড লাইসেন্স ডাউনলোড, how to get trade license in bangladesh, municipal trade license online, company trade license requirements',
    meta_description = 'Guide to applying for a new business e-Trade License or renewing an existing license online through City Corporation and BIDA OSS portals.',
    summary = 'Guide to applying for a new business e-Trade License or renewing an existing license online through the City Corporation and BIDA OSS portals.'
WHERE slug IN ('e-trade-license-bangladesh-online', 'trade-licence', 'trade-licence-renewal');

-- 7. INCOME TAX E-RETURN (ETAXNBR) SEO
UPDATE bd_guides
SET 
    keywords = 'nbr ereturn online, kivabe income tax return debo, etaxnbr gov bd, online tax return bd, zero return kivabe submit kore, tax certificate download, psr certificate bangladesh, income tax slab 2026, অনলাইনে আয়কর রিটার্ন দাখিল, শূন্য রিটার্ন দাখিল করার নিয়ম, ই-রিটার্ন ট্যাক্স সার্টিফিকেট ডাউনলোড, পিএসআর কি, করমুক্ত আয়ের সীমা, how to file income tax return online bangladesh, etaxnbr registration with nid, zero tax return online',
    meta_description = 'A detailed walkthrough on filing individual income tax returns, salary declarations, wealth statements, and generating tax certificates via NBR e-Tax system.',
    summary = 'A detailed walkthrough on filing individual income tax returns, salary declarations, wealth statements, and generating tax certificates via the NBR e-Tax system.'
WHERE slug IN ('nbr-online-income-tax-return-filing', 'income-tax-e-return');

-- 8. POLICE CLEARANCE CERTIFICATE (PCC) SEO
UPDATE bd_guides
SET 
    keywords = 'police clearance certificate bangladesh, pcc online apply, kivabe police clearance korbo, pcc police gov bd, police clearance fee 500 taka, police verification for abroad, বিদেশে যাওয়ার পুলিশ ক্লিয়ারেন্স করার নিয়ম, অনলাইনে পুলিশ ক্লিয়ারেন্স আবেদন, পিটিসি সার্টিফিকেট, পুলিশ ভেরিফিকেশন চেক, how to apply for police clearance online bd, pcc status check bangladesh',
    meta_description = 'Guide to applying online for a Police Clearance Certificate, commonly needed for visas, overseas jobs, and immigration.',
    summary = 'Guide to applying online for a Police Clearance Certificate, commonly needed for visas, overseas jobs, and immigration.'
WHERE slug = 'police-clearance-certificate';

-- 9. MARRIAGE REGISTRATION (KABIN NAMA) SEO
UPDATE bd_guides
SET 
    keywords = 'marriage registration bangladesh, kabin nama toirir niyom, kazi office marriage fee, bibaho nibondhon, nikah nama registration, marriage certificate bangladesh, বিবাহ নিবন্ধন করার নিয়ম, কাবিননামা তোলার নিয়ম, কাজী অফিস বিয়ের ফি, হিন্দু বিবাহ নিবন্ধন, স্পেশাল ম্যারেজ অ্যাক্ট, legal marriage registration process bangladesh',
    meta_description = 'Step-by-step guide to legally registering a marriage in Bangladesh through a licensed Kazi office.',
    summary = 'Step-by-step guide to legally registering a marriage in Bangladesh through a licensed Kazi office.'
WHERE slug = 'marriage-registration';

-- 10. BLOG POSTS SEO ENHANCEMENTS
UPDATE bd_blog_posts
SET 
    tags = '["e-Passport", "Police Verification", "DIP", "Immigration", "Travel", "পাসপোর্ট নিয়ম", "ভেরিফিকেশন"]'::jsonb
WHERE slug = 'bangladesh-epassport-rules-police-verification-guide';

UPDATE bd_blog_posts
SET 
    tags = '["e-Passport", "Status Tracking", "Personalization", "DIP", "পাসপোর্ট ট্র্যাকিং", "ডেলিভারি চেক"]'::jsonb
WHERE slug = 'epassport-delivery-status-tracking-codes-explained';

UPDATE bd_blog_posts
SET 
    tags = '["e-Passport", "Application Mistakes", "Avoid Rejection", "পাসপোর্ট ভুল সংশোধন"]'::jsonb
WHERE slug = 'common-mistakes-epassport-application';

UPDATE bd_blog_posts
SET 
    tags = '["Income Tax", "PSR", "NBR", "Tax Return", "পিএসআর সার্টিফিকেট", "ট্যাক্স রিটার্ন"]'::jsonb
WHERE slug = 'proof-of-submission-of-tax-return-psr-mandatory-services';

UPDATE bd_blog_posts
SET 
    tags = '["Land Property", "Land Fraud", "e-Namjari", "Khatian", "জমির দলিল", "নামজারি সতর্কতা"]'::jsonb
WHERE slug = 'how-to-verify-land-ownership-before-buying-bangladesh';

UPDATE bd_blog_posts
SET 
    tags = '["BRTA", "Driving Test", "Driving Licence", "Zigzag Track", "ড্রাইভিং টেস্ট পাস"]'::jsonb
WHERE slug = 'brta-driving-test-preparation-practical-exam-tips';

UPDATE bd_blog_posts
SET 
    tags = '["NID Card", "Birth Certificate", "BDRIS", "Name Correction", "এনআইডি ও জন্ম নিবন্ধন মিল"]'::jsonb
WHERE slug = 'resolving-nid-birth-certificate-name-mismatches';


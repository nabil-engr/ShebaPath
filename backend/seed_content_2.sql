-- ==============================================================================
-- ShebaPath SEO & Multi-Query Ranking Enhancements (2025/2026)
-- Target: 1st Page Google Ranking for High-Volume Bangla, Banglish & English Queries
-- Safe to re-run: Updates bd_guides and bd_blog_posts with rich keywords and summaries
-- ==============================================================================

-- 1. E-PASSPORT GUIDE SEO (Target: kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport bananor dhap, passport e apply er jonno ki ki lagbe)
UPDATE bd_guides
SET 
    keywords = 'kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport, passport bananor dhap, e-passport bananor dhap, steps for applying passport, passport e apply er jonno ki ki lagbe, passport korte koto taka lage, passport fees bd 2026, passport renew korar niyom, urgent passport kivabe banabo, passport police verification process, epassport appointment kivabe nibo, passport status check bd, পাসপোর্ট করার নিয়ম, ই-পাসপোর্ট আবেদন করার নিয়ম, পাসপোর্ট করতে কি কি লাগে, পাসপোর্ট তৈরির প্রক্রিয়া, পাসপোর্ট বানানোর সহজ উপায়, নতুন পাসপোর্ট করার নিয়ম ২০২৬, ই পাসপোর্ট ফি জমা দেওয়ার নিয়ম, পাসপোর্ট ডেলিভারি চেক, পুলিশ ভেরিফিকেশন নিয়ম, how to apply for epassport in bangladesh, bangladesh passport online application steps, epassport fee structure, passport renewal bangladesh, documents needed for passport bd, emergency passport delivery bangladesh',
    meta_description = 'ই-পাসপোর্ট আবেদন ও রিনিউ করার সহজ নিয়ম ২০২৬ (e-Passport Apply & Renewal Guide). পাসপোর্ট করতে কি কি লাগে, কত টাকা ফি, পুলিশ ভেরিফিকেশন ও ডেলিভারি স্ট্যাটাস চেক সংক্রান্ত সকল তথ্য।',
    summary = 'Step-by-step complete guide for Bangladeshi e-Passport application & renewal (ই-পাসপোর্ট তৈরির সম্পূর্ণ প্রক্রিয়া). Learn about required documents (এনআইডি বা জন্ম নিবন্ধন), 2026 fee table, online appointment booking, biometric capture, and police verification.'
WHERE slug IN ('bangladesh-epassport-application-guide', 'passport');

-- 2. DRIVING LICENCE GUIDE SEO (Target: kivabe driving licence korbo, brta driving licence, learner licence, driving test)
UPDATE bd_guides
SET 
    keywords = 'kivabe driving licence korbo, brta driving licence, learner licence korar niyom, driving test kivabe hoy, bike licence banate koto taka lage, smart card driving licence delivery check, bsp brta online registration, বিআরটিএ ড্রাইভিং লাইসেন্স করার নিয়ম, লার্নার লাইসেন্স আবেদন, স্মার্ট কার্ড ড্রাইভিং লাইসেন্স পাওয়ার ধাপ, ড্রাইভিং টেস্ট পরীক্ষার নিয়ম, মোটরসাইকেল লাইসেন্স ফি, how to get driving licence in bangladesh, brta learner driving licence online, driving test procedure bangladesh, brta smart card fees, bsp portal account open, driving medical certificate form',
    meta_description = 'বিআরটিএ ড্রাইভিং লাইসেন্স ও লার্নার আবেদন করার সঠিক নিয়ম ২০২৬ (BRTA Driving Licence Guide). মেডিকেল সার্টিফিকেট, পরীক্ষার ধাপ, ফি ও স্মার্ট কার্ড পাওয়ার উপায়।',
    summary = 'Complete guide for BRTA Driving Licence in Bangladesh (বিআরটিএ ড্রাইভিং লাইসেন্স ও লার্নার আবেদন প্রক্রিয়া). Learn how to create BSP account, fill Medical-1 form, pass written/viva/field tests, and get your digital smart card.'
WHERE slug IN ('driving-licence-bangladesh-guide', 'driving-licence');

-- 3. NATIONAL ID (NID) CORRECTION SEO (Target: kivabe nid card shongshodhon korbo, nid correction, smart card, nid wallet)
UPDATE bd_guides
SET 
    keywords = 'kivabe nid card shongshodhon korbo, new voter howar niyom, smart nid card kivabe pabo, nid wallet verification kivabe kore, nid hariye gele ki korbo, voter id card correction process bangladesh, nid card download online, ভোটার আইডি কার্ড সংশোধন করার নিয়ম, নতুন ভোটার হওয়ার নিয়ম, স্মার্ট কার্ড তোলার নিয়ম, এনআইডি ওয়ালেট দিয়ে ছবি ভেরিফিকেশন, হারিয়ে যাওয়া আইডি কার্ড তোলার নিয়ম, জন্ম তারিখ সংশোধন, অনলাইন এনআইডি ডাউনলোড, online nid card correction bd, smart nid card download, nid wallet facial verification steps, lost nid reissue procedure, nid correction fee bkash',
    meta_description = 'জাতীয় পরিচয়পত্র (NID) সংশোধন ও স্মার্ট কার্ড রি-ইস্যু আবেদন করার নিয়ম ২০২৬ (Online NID Correction). নাম, বয়স, পিতা-মাতার নাম পরিবর্তন ও NID Wallet ফেস ভেরিফিকেশন পদ্ধতি।',
    summary = 'Step-by-step instructions on correcting information on your National ID (এনআইডি সংশোধন ও রি-ইস্যু) or getting a replacement smart card through Election Commission portal (services.nidw.gov.bd) and NID Wallet app.'
WHERE slug IN ('nid-correction-smart-card-reissue', 'national-id');

-- 4. BIRTH REGISTRATION (BDRIS) SEO (Target: kivabe jonmo nibondhon korbo, online birth certificate apply, 17 digit birth registration)
UPDATE bd_guides
SET 
    keywords = 'kivabe jonmo nibondhon korbo, online birth certificate apply bd, jonmo nibondhon shongshodhon korar niyom, 17 digit birth registration download, birth certificate e bhul thakle ki korbo, jonmo nibondhon english korar niyom, অনলাইনে জন্ম নিবন্ধন আবেদন করার নিয়ম, ১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন, জন্ম নিবন্ধন সংশোধন, জন্ম নিবন্ধন ইংরেজি করার নিয়ম, জন্ম নিবন্ধন ফি, bangladesh birth certificate online application, bdris digital birth registration, correct birth certificate online, union parishad birth certificate process, 17 digit birth certificate verification',
    meta_description = 'অনলাইনে নতুন জন্ম নিবন্ধন আবেদন ও সংশোধন করার নিয়ম ২০২৬ (BDRIS Birth Registration Guide). ১৭ ডিজিটের ডিজিটাল সার্টিফিকেট, ইংরেজি ভার্সন ও প্রয়োজনীয় কাগজপত্র।',
    summary = 'Official procedure for applying for a new birth certificate or updating existing records to the bilingual 17-digit digital certificate on BDRIS (bdris.gov.bd) with fee breakdown and council office submission steps.'
WHERE slug IN ('online-birth-registration-bdris', 'birth-certificate');

-- 5. LAND MUTATION (E-NAMJARI) SEO (Target: e-namjari, land mutation bd, dcr download, porcha khatian)
UPDATE bd_guides
SET 
    keywords = 'e-namjari land mutation, kivabe jomir namjari korbo, land mutation online bd, mutation land gov bd, dcr download kivabe korbo, porcha khatian ber korar niyom, jomir namjari korte koto taka lage, ac land office hearing, ই-নামজারি আবেদন করার নিয়ম, জমির নামজারি করার সহজ উপায়, ডিসিআর ও খতিয়ান ডাউনলোড, নামজারি ফি কত, বায়া দলিল ও খতিয়ান যাচাই, সহকারী কমিশনার ভূমি অফিস, land mutation fee bangladesh, edcr download online, online land transfer bd',
    meta_description = 'অনলাইনে জমির ই-নামজারি (মিউটেশন) আবেদন ও ফি পরিশোধের নিয়ম ২০২৬ (e-Namjari Land Mutation Guide). মোট সরকারি ফি ১,১৭০ টাকা, প্রয়োজনীয় কাগজপত্র ও ডিসিআর ডাউনলোডের নিয়ম।',
    summary = 'Comprehensive guide to applying for e-Mutation (ই-নামজারি) online via mutation.land.gov.bd. Breakdown of official fees (৳1,170), required title deeds, hearing process, and QR-code verified digital DCR collection.'
WHERE slug IN ('e-namjari-land-mutation-online', 'land-mutation');

-- 6. E-TRADE LICENSE SEO (Target: trade license bd, etrade license, business registration)
UPDATE bd_guides
SET 
    keywords = 'etrade license bd, kivabe trade licence korbo, dncc etrade license apply, dscc trade license renew, trade license korte ki ki lagbe, trade license fees in bangladesh, business registration bangladesh, ট্রেড লাইসেন্স করার নিয়ম, নতুন ট্রেড লাইসেন্স আবেদন, ট্রেড লাইসেন্স নবায়ন ফি, ঢাকা উত্তর ও দক্ষিণ সিটি কর্পোরেশন ট্রেড লাইসেন্স, অনলাইন ট্রেড লাইসেন্স ডাউনলোড, how to get trade license in bangladesh, municipal trade license online, company trade license requirements',
    meta_description = 'অনলাইনে ই-ট্রেড লাইসেন্স আবেদন ও নবায়নের সহজ নিয়ম ২০২৬ (e-Trade License Guide). সিটি কর্পোরেশন ও পৌরসভায় নতুন ব্যবসা নিবন্ধন, প্রয়োজনীয় ডকুমেন্টস ও ফি তালিকা।',
    summary = 'How to apply for a new business e-Trade License or renew an existing license online through City Corporation and municipal portals with document checklists and fee calculators.'
WHERE slug IN ('e-trade-license-bangladesh-online', 'trade-licence', 'trade-licence-renewal');

-- 7. INCOME TAX E-RETURN (ETAXNBR) SEO
UPDATE bd_guides
SET 
    keywords = 'nbr ereturn online, kivabe income tax return debo, etaxnbr gov bd, online tax return bd, zero return kivabe submit kore, tax certificate download, psr certificate bangladesh, income tax slab 2026, অনলাইনে আয়কর রিটার্ন দাখিল, শূন্য রিটার্ন দাখিল করার নিয়ম, ই-রিটার্ন ট্যাক্স সার্টিফিকেট ডাউনলোড, পিএসআর কি, করমুক্ত আয়ের সীমা, how to file income tax return online bangladesh, etaxnbr registration with nid, zero tax return online',
    meta_description = 'অনলাইনে ইনকাম ট্যাক্স রিটার্ন (e-Return) দাখিল ও শূন্য রিটার্ন সাবমিট করার নিয়ম ২০২৬ (NBR e-Return Guide). তাৎক্ষণিক ট্যাক্স সার্টিফিকেট ও পিএসআর পাওয়ার উপায়।',
    summary = 'Detailed walkthrough on filing individual income tax returns, wealth declarations, and instant tax certificate downloads via NBR e-Tax portal (etaxnbr.gov.bd).'
WHERE slug IN ('nbr-online-income-tax-return-filing', 'income-tax-e-return');

-- 8. POLICE CLEARANCE CERTIFICATE (PCC) SEO
UPDATE bd_guides
SET 
    keywords = 'police clearance certificate bangladesh, pcc online apply, kivabe police clearance korbo, pcc police gov bd, police clearance fee 500 taka, police verification for abroad, বিদেশে যাওয়ার পুলিশ ক্লিয়ারেন্স করার নিয়ম, অনলাইনে পুলিশ ক্লিয়ারেন্স আবেদন, পিটিসি সার্টিফিকেট, পুলিশ ভেরিফিকেশন চেক, how to apply for police clearance online bd, pcc status check bangladesh',
    meta_description = 'অনলাইনে পুলিশ ক্লিয়ারেন্স সার্টিফিকেট (PCC) আবেদন ও ট্র্যাকিং করার সঠিক নিয়ম ২০২৬ (Police Clearance Guide). ৫০০ টাকা সরকারি ফি ও প্রয়োজনীয় পাসপোর্ট-এনআইডি ডকুমেন্টস।',
    summary = 'Step-by-step guide to applying online for a Police Clearance Certificate (PCC) via pcc.police.gov.bd for foreign travel, immigration, work permits, and overseas scholarships.'
WHERE slug = 'police-clearance-certificate';

-- 9. MARRIAGE REGISTRATION (KABIN NAMA) SEO
UPDATE bd_guides
SET 
    keywords = 'marriage registration bangladesh, kabin nama toirir niyom, kazi office marriage fee, bibaho nibondhon, nikah nama registration, marriage certificate bangladesh, বিবাহ নিবন্ধন করার নিয়ম, কাবিননামা তোলার নিয়ম, কাজী অফিস বিয়ের ফি, হিন্দু বিবাহ নিবন্ধন, স্পেশাল ম্যারেজ অ্যাক্ট, legal marriage registration process bangladesh',
    meta_description = 'বাংলাদেশে বিবাহ নিবন্ধন (কাবিননামা / ম্যারেজ সার্টিফিকেট) করার আইনি নিয়ম ও ফি ২০২৬ (Marriage Registration Guide). কাজী অফিসের সরকারি ফি ও প্রয়োজনীয় কাগজপত্র।',
    summary = 'Legal guidelines for registering a marriage and obtaining certified Kabin Nama or Marriage Certificates across licensed Kazi and Special Marriage Registrar offices in Bangladesh.'
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


-- New ShebaPath guides — Marriage Registration, Police Clearance Certificate, e-Return (Income Tax)
-- Safe to re-run (upserts by slug). Uses the current relational schema (category_id, tags via guide_tags).

INSERT INTO bd_guides (slug, category_id, title, summary, steps, requirements, fees, processing_time, office, keywords, meta_description, is_featured, last_verified)
VALUES
(
    'marriage-registration',
    (SELECT id FROM categories WHERE slug = 'civil-registration'),
    'How to Register Your Marriage (Kabin Nama / Marriage Certificate)',
    'Step-by-step guide to legally registering a marriage in Bangladesh through a licensed Kazi office.',
    '["Contact a licensed Nikah Registrar (Kazi) in your area for a Muslim marriage, or the relevant Registrar for Hindu/Christian/Special Marriage Act registration", "Collect and fill out the Kabinnama (Form No. 160) with the Mahr (dower) amount clearly stated", "Bring both parties and at least two witnesses to sign in front of the registrar", "Submit NID copies of both parties and witnesses", "Pay the government registration fee (based on the Mahr amount)", "Collect the registered Kabinnama / marriage certificate, usually within a few days"]',
    '["NID of both parties and witnesses", "Passport-size photos", "Mahr (dower) amount to declare", "For Special Marriage Act: a 30-day public notice period with no objections"]',
    'Muslim marriages: roughly ৳14 per ৳1,000 of Mahr value for the first ৳1–5 lakh, lower rates above that; Hindu/Special Marriage fees vary by registrar — confirm before registering',
    '1–3 working days after documents and fee are submitted',
    'Local Kazi (Nikah Registrar) Office, or the relevant Marriage Registrar for other faiths',
    'marriage registration bangladesh, kabin nama toirir niyom, kazi office marriage fee, bibaho nibondhon, nikah nama registration, marriage certificate bangladesh, বিবাহ নিবন্ধন করার নিয়ম, কাবিননামা তোলার নিয়ম, কাজী অফিস বিয়ের ফি, হিন্দু বিবাহ নিবন্ধন, স্পেশাল ম্যারেজ অ্যাক্ট, legal marriage registration process bangladesh',
    'বাংলাদেশে বিবাহ নিবন্ধন (কাবিননামা / ম্যারেজ সার্টিফিকেট) করার আইনি নিয়ম ও ফি ২০২৬ (Marriage Registration Guide). কাজী অফিসের সরকারি ফি ও প্রয়োজনীয় কাগজপত্র।',
    false,
    now()
),
(
    'police-clearance-certificate',
    (SELECT id FROM categories WHERE slug = 'travel'),
    'How to Get a Police Clearance Certificate (PCC)',
    'Guide to applying online for a Police Clearance Certificate, commonly needed for visas, overseas jobs, and immigration.',
    '["Create an account on the Bangladesh Police online PCC portal (pcc.police.gov.bd)", "Fill in the application form with your personal details, passport number, and the purpose of the certificate", "Upload scanned copies of your passport, NID, a recent photo, and proof of address", "Pay the government fee (৳500) online through the portal", "Wait for local police verification at your present or permanent address", "Download or collect your certificate once approved"]',
    '["Valid passport", "NID", "Recent passport-size photo", "Proof of present/permanent address (utility bill, etc.)", "Purpose of the certificate (visa, job, study, immigration)"]',
    '৳500 (flat government fee) — be cautious of agents charging extra beyond the official portal fee',
    'Typically 7–15 working days, sometimes up to 2–3 weeks if extra verification is needed',
    'Bangladesh Police — fully online application at pcc.police.gov.bd, verified via local police station',
    'police clearance certificate bangladesh, pcc online apply, kivabe police clearance korbo, pcc police gov bd, police clearance fee 500 taka, police verification for abroad, বিদেশে যাওয়ার পুলিশ ক্লিয়ারেন্স করার নিয়ম, অনলাইনে পুলিশ ক্লিয়ারেন্স আবেদন, পিটিসি সার্টিফিকেট, পুলিশ ভেরিফিকেশন চেক, how to apply for police clearance online bd, pcc status check bangladesh',
    'অনলাইনে পুলিশ ক্লিয়ারেন্স সার্টিফিকেট (PCC) আবেদন ও ট্র্যাকিং করার সঠিক নিয়ম ২০২৬ (Police Clearance Guide). ৫০০ টাকা সরকারি ফি ও প্রয়োজনীয় পাসপোর্ট-এনআইডি ডকুমেন্টস।',
    false,
    now()
),
(
    'income-tax-e-return',
    (SELECT id FROM categories WHERE slug = 'tax'),
    'How to File Your Income Tax e-Return',
    'Step-by-step guide to submitting your annual income tax return online through the NBR e-Tax portal.',
    '["Register or log in at the NBR e-Tax portal (etaxnbr.gov.bd) using your TIN", "Select the correct assessment year and return type (regular return, or zero return if your income is below the tax-free threshold)", "Enter your income details — salary, other income sources, and any tax already deducted at source (TDS)", "Enter your investments and eligible rebate details; the portal calculates your rebate and tax automatically", "Declare your schedule of assets and liabilities as of 30 June", "Review the auto-calculated tax, pay any amount due via bank/card/mobile banking, and submit", "Download your acknowledgement receipt and income tax certificate"]',
    '["Valid TIN (e-TIN)", "Salary certificate / income details", "Bank statements", "Investment receipts (for rebate claims)", "Registered mobile number linked to NID (or email registration for expatriates)"]',
    'Filing itself is free; any tax due is calculated automatically based on income slabs and paid through the portal''s payment gateway',
    'Usually well under 30 minutes online for straightforward returns; the annual filing deadline is typically late November',
    'National Board of Revenue (NBR) — fully online at etaxnbr.gov.bd',
    'e-return, income tax bangladesh, etaxnbr, nbr tax filing',
    'How to file your income tax e-Return online in Bangladesh through the NBR e-Tax portal.',
    false,
    now()
)
ON CONFLICT (slug) DO UPDATE SET
    category_id = EXCLUDED.category_id,
    title = EXCLUDED.title,
    summary = EXCLUDED.summary,
    steps = EXCLUDED.steps,
    requirements = EXCLUDED.requirements,
    fees = EXCLUDED.fees,
    processing_time = EXCLUDED.processing_time,
    office = EXCLUDED.office,
    keywords = EXCLUDED.keywords,
    meta_description = EXCLUDED.meta_description,
    last_verified = now();

-- Tags
INSERT INTO tags (name, slug) VALUES
    ('marriage', 'marriage'), ('pcc', 'pcc'), ('visa', 'visa'), ('e-return', 'e-return')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO guide_tags (guide_id, tag_id)
SELECT g.id, t.id FROM bd_guides g, tags t
WHERE (g.slug = 'marriage-registration' AND t.slug = 'marriage')
   OR (g.slug = 'police-clearance-certificate' AND t.slug IN ('pcc', 'visa', 'immigration'))
   OR (g.slug = 'income-tax-e-return' AND t.slug IN ('e-return', 'tin'))
ON CONFLICT DO NOTHING;


-- ==============================================================================
-- 2025/2026 UPDATED GUIDES & BLOGS ACCORDING TO CURRENT BANGLADESH REGULATIONS
-- ==============================================================================

-- 1. Ensure Required Categories Exist
INSERT INTO categories (name, slug, description) VALUES
    ('Transport & Vehicles', 'transport', 'Driving licence, vehicle registration, fitness certificate, and BRTA services'),
    ('Passport & Travel', 'travel', 'e-Passport, visa, police clearance, and overseas travel procedures'),
    ('Identity & Civil Registration', 'civil-registration', 'Smart NID card, online birth & death certificate, and marriage registration'),
    ('Tax & Finance', 'tax', 'e-TIN, online income tax return (e-Return), and wealth statement filing'),
    ('Business & Commerce', 'business', 'Trade license (e-Trade License), RJSC company registration, and utility setups'),
    ('Land & Property', 'land-property', 'e-Namjari (Mutation), Land Development Tax (e-Khajna), and digital Khatiyan')
ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description;

-- 2. Ensure Required Tags Exist
INSERT INTO tags (name, slug) VALUES
    ('Driving Licence', 'driving-licence'),
    ('BRTA', 'brta'),
    ('Smart Card', 'smart-card'),
    ('e-Passport', 'epassport'),
    ('Immigration', 'immigration'),
    ('NID Card', 'nid-card'),
    ('Voter ID', 'voter-id'),
    ('Birth Certificate', 'birth-certificate'),
    ('BDRIS', 'bdris'),
    ('Income Tax', 'income-tax'),
    ('NBR', 'nbr'),
    ('TIN', 'tin'),
    ('Trade License', 'trade-license'),
    ('DNCC', 'dncc'),
    ('DSCC', 'dscc'),
    ('e-Namjari', 'e-namjari'),
    ('Mutation', 'mutation'),
    ('Land Tax', 'land-tax'),
    ('Kabin Nama', 'kabin-nama')
ON CONFLICT (slug) DO NOTHING;

-- 3. Guides
INSERT INTO bd_guides (slug, category_id, title, summary, steps, requirements, fees, processing_time, office, keywords, meta_description, is_featured, is_published, last_verified)
VALUES
(
    'driving-licence-bangladesh-guide',
    (SELECT id FROM categories WHERE slug = 'transport'),
    'BRTA Smart Driving Licence Application & Renewal Guide (2025/2026)',
    'Comprehensive step-by-step guide to applying for a Learner and Smart Card Driving Licence through the BRTA Service Portal (BSP), test procedure, biometric submission, and status tracking.',
    '[
        "Create an account on the BRTA Service Portal (bsp.brta.gov.bd) using your mobile number and NID.",
        "Apply for the Learner Driving Licence online by submitting medical certificate (Form Medical-1) and required personal details.",
        "Pay the learner application and exam fee online through bKash, Nagad, Rocket, or designated bank gateways.",
        "Download and print the digital Learner Licence with the assigned test venue, date, and time.",
        "Attend the written, oral, and practical field driving test at your designated BRTA test circle on the scheduled date.",
        "After passing, apply for the Smart Card Driving Licence on the BSP portal and pay the card and biometric fees.",
        "Visit your regional BRTA circle office for biometric capture (digital photo, fingerprints, and iris scan).",
        "Track postal delivery or smart card printing status on BSP and receive the physical licence via Bangladesh Post or circle counter."
    ]'::jsonb,
    '[
        "Age requirement: Minimum 18 years for non-professional, minimum 20 years for professional licence.",
        "Original National ID (NID) card and clear digital copy.",
        "Medical Fitness Certificate from a registered MBBS doctor (duly signed and sealed on BRTA prescribed format).",
        "Recent passport-size color photographs (white background).",
        "Educational qualification certificate (minimum Class 8 / JSC / JDC pass certificate).",
        "Proof of current address (utility bill / rent deed) if different from NID permanent address."
    ]'::jsonb,
    'Learner licence: ৳345 (single category: bike or car) / ৳518 (dual: bike + car). Full Smart Card: Non-Professional ৳4,557 (10-year validity); Professional ৳2,832 (5-year validity). Biometric & postal charges included.',
    'Learner issued instantly online. Test usually scheduled after 2–3 months. Smart card delivery within 30–60 days after biometric enrollment.',
    'Bangladesh Road Transport Authority (BRTA) Circle Office (as per present or permanent address)',
    'kivabe driving licence korbo, brta driving licence, learner licence korar niyom, driving test kivabe hoy, bike licence banate koto taka lage, smart card driving licence delivery check, bsp brta online registration, বিআরটিএ ড্রাইভিং লাইসেন্স করার নিয়ম, লার্নার লাইসেন্স আবেদন, স্মার্ট কার্ড ড্রাইভিং লাইসেন্স পাওয়ার ধাপ, ড্রাইভিং টেস্ট পরীক্ষার নিয়ম, মোটরসাইকেল লাইসেন্স ফি, how to get driving licence in bangladesh, brta learner driving licence online, driving test procedure bangladesh, brta smart card fees, bsp portal account open, driving medical certificate form',
    'বিআরটিএ ড্রাইভিং লাইসেন্স ও লার্নার আবেদন করার সঠিক নিয়ম ২০২৬ (BRTA Driving Licence Guide). মেডিকেল সার্টিফিকেট, পরীক্ষার ধাপ, ফি ও স্মার্ট কার্ড পাওয়ার উপায়।',
    true,
    true,
    CURRENT_DATE
),
(
    'bangladesh-epassport-application-guide',
    (SELECT id FROM categories WHERE slug = 'travel'),
    'Complete e-Passport Online Application & Renewal Procedure (2025/2026)',
    'A complete guide to applying for a new or renewed Bangladeshi e-Passport online, including fee payment, appointment booking, biometric enrollment, and police verification rules.',
    '[
        "Visit the official portal epassport.gov.bd and check jurisdiction for your regional passport office.",
        "Create an account with your active email address and mobile number.",
        "Fill out the online application form accurately matching your NID or verified digital Birth Certificate.",
        "Select passport validity (5 years or 10 years) and page capacity (48 pages or 64 pages).",
        "Pay the government passport fee online via A-Challan / Ekpay / bKash / Nagad / cards or through partner banks.",
        "Book an appointment date for biometric data enrollment (photo, 10 fingerprints, iris scan, and electronic signature).",
        "Print the application summary slip and payment receipt and visit the Passport Office on your scheduled appointment date.",
        "Complete biometric enrollment and retain the delivery slip. Track status online until SMS arrives for passport collection."
    ]'::jsonb,
    '[
        "Original National ID (NID) for applicants aged 18+ (verified 17-digit or 10-digit smart NID).",
        "Digital 17-digit English Birth Registration Certificate (BRC) verified on BDRIS for applicants under 18 or without NID.",
        "Printed Application Summary and Payment Confirmation Slip / A-Challan receipt.",
        "Previous original passport and photocopy (for renewals/reissues).",
        "GO (Government Order) or NOC for government employees; Student ID or Trade License/NOC for specific profession proofs."
    ]'::jsonb,
    '48 Pages (5 Years): Regular ৳4,025 | Express ৳6,325 | Super Express ৳8,625. 48 Pages (10 Years): Regular ৳5,750 | Express ৳8,050 | Super Express ৳10,350. 64 Pages (10 Years): Regular ৳8,050 | Express ৳10,350 | Super Express ৳13,800. (All fees include 15% VAT).',
    'Regular: 15–21 working days; Express: 7–10 working days; Super Express: 2–3 working days (subject to police clearance where applicable).',
    'Department of Immigration & Passports (DIP) — Regional Passport Office (RPO)',
    'kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport, passport bananor dhap, e-passport bananor dhap, steps for applying passport, passport e apply er jonno ki ki lagbe, passport korte koto taka lage, passport fees bd 2026, passport renew korar niyom, urgent passport kivabe banabo, passport police verification process, epassport appointment kivabe nibo, passport status check bd, পাসপোর্ট করার নিয়ম, ই-পাসপোর্ট আবেদন করার নিয়ম, পাসপোর্ট করতে কি কি লাগে, পাসপোর্ট তৈরির প্রক্রিয়া, পাসপোর্ট বানানোর সহজ উপায়, নতুন পাসপোর্ট করার নিয়ম ২০২৬, ই পাসপোর্ট ফি জমা দেওয়ার নিয়ম, পাসপোর্ট ডেলিভারি চেক, পুলিশ ভেরিফিকেশন নিয়ম, how to apply for epassport in bangladesh, bangladesh passport online application steps, epassport fee structure, passport renewal bangladesh, documents needed for passport bd, emergency passport delivery bangladesh',
    'ই-পাসপোর্ট আবেদন ও রিনিউ করার সহজ নিয়ম ২০২৬ (e-Passport Apply & Renewal Guide). পাসপোর্ট করতে কি কি লাগে, কত টাকা ফি, পুলিশ ভেরিফিকেশন ও ডেলিভারি স্ট্যাটাস চেক সংক্রান্ত সকল তথ্য।',
    true,
    true,
    CURRENT_DATE
),
(
    'nid-correction-smart-card-reissue',
    (SELECT id FROM categories WHERE slug = 'civil-registration'),
    'How to Correct NID Information & Apply for Smart NID Card Online',
    'Instructions on correcting name, date of birth, address, or parent information on your Bangladesh National ID (NID) using the Election Commission online portal.',
    '[
        "Visit the Bangladesh Election Commission NID wing portal at services.nidw.gov.bd.",
        "Register or log in using your NID number/form number, date of birth, and facial verification via the NID Wallet mobile app.",
        "Navigate to the Profile section and click the Edit button to select the specific fields you need to amend.",
        "Pay the government correction or reissue fee via bKash, Rocket, Nagad, or OK Wallet under the NID service code.",
        "Upload scanned supporting documents (educational board certificates, digital birth registration, marriage deed, etc.).",
        "Submit the application and download the submitted application slip for reference.",
        "Monitor tracking progress online (Category Ka, Kha, Ga, or Gha approval stages).",
        "Once approved, download the updated digital copy with watermark or collect the physical Smart Card when notified."
    ]'::jsonb,
    '[
        "Registered account with NID Wallet biometric mobile verification.",
        "For Name / Date of Birth: SSC/equivalent educational board certificate, verified 17-digit digital birth certificate.",
        "For Parents Name: Parents NID copies, sibling NIDs, or warishan certificate.",
        "For Marital Status / Spouse: Nikahnama (marriage deed), divorce deed, or spouse NID.",
        "For Lost Card Reissue: General Diary (GD) number from local police station and police GD copy."
    ]'::jsonb,
    'Correction Fee: 1st time ৳230 (৳200 + 15% VAT); 2nd time ৳345; 3rd time onwards ৳575. Reissue for lost/damaged card: Regular ৳230; Urgent ৳345.',
    'Simple corrections: 7–15 working days; Age/Education/Parent corrections: 20–45 working days depending on committee review level.',
    'Bangladesh Election Commission — Upazila / Thana Election Office',
    'kivabe nid card shongshodhon korbo, new voter howar niyom, smart nid card kivabe pabo, nid wallet verification kivabe kore, nid hariye gele ki korbo, voter id card correction process bangladesh, nid card download online, ভোটার আইডি কার্ড সংশোধন করার নিয়ম, নতুন ভোটার হওয়ার নিয়ম, স্মার্ট কার্ড তোলার নিয়ম, এনআইডি ওয়ালেট দিয়ে ছবি ভেরিফিকেশন, হারিয়ে যাওয়া আইডি কার্ড তোলার নিয়ম, জন্ম তারিখ সংশোধন, অনলাইন এনআইডি ডাউনলোড, online nid card correction bd, smart nid card download, nid wallet facial verification steps, lost nid reissue procedure, nid correction fee bkash',
    'জাতীয় পরিচয়পত্র (NID) সংশোধন ও স্মার্ট কার্ড রি-ইস্যু আবেদন করার নিয়ম ২০২৬ (Online NID Correction). নাম, বয়স, পিতা-মাতার নাম পরিবর্তন ও NID Wallet ফেস ভেরিফিকেশন পদ্ধতি।',
    true,
    true,
    CURRENT_DATE
),
(
    'online-birth-registration-bdris',
    (SELECT id FROM categories WHERE slug = 'civil-registration'),
    'Online Birth Registration & 17-Digit Digital Certificate (BDRIS)',
    'Official process to register a new birth or apply for a bilingual 17-digit digital birth registration certificate through the Bangladesh BDRIS portal.',
    '[
        "Navigate to bdris.gov.bd and select ''Application for Birth Registration''.",
        "Select your registering office location (Union Parishad, Pourashava, City Corporation Ward, or Bangladesh Embassy abroad).",
        "Enter child details in both Bengali and English (Name, Gender, Date of Birth, Place of Birth).",
        "Provide parents 17-digit digital birth certificate numbers or NID numbers as required.",
        "Upload mandatory attachments: EPI immunization card, hospital discharge summary, and holding tax / residence proof.",
        "Submit the online form and note the Application ID. Print the multi-page application form.",
        "Submit the printed application along with physical document copies to the concerned local registrar office within 15 days.",
        "Collect the certified 17-digit bilingual Birth Registration Certificate upon SMS confirmation."
    ]'::jsonb,
    '[
        "Hospital birth certificate or EPI (Expanded Programme on Immunization) vaccination card showing exact birth date.",
        "Parents verified 17-digit digital birth registration certificates (mandatory for minors).",
        "Parents NID copies.",
        "Proof of address: Land holding tax receipt, gas/electricity utility bill, or councilor/chairman residential certificate."
    ]'::jsonb,
    'Free within 45 days of birth. ৳25 between 46 days to 5 years. ৳50 for applicants over 5 years. English version issuance fee: ৳50. Correction fee: ৳100.',
    'Typically 3 to 7 working days following physical document submission at the council/ward office.',
    'Union Parishad / Municipality (Pourashava) / City Corporation Ward Councilor Office',
    'kivabe jonmo nibondhon korbo, online birth certificate apply bd, jonmo nibondhon shongshodhon korar niyom, 17 digit birth registration download, birth certificate e bhul thakle ki korbo, jonmo nibondhon english korar niyom, অনলাইনে জন্ম নিবন্ধন আবেদন করার নিয়ম, ১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন, জন্ম নিবন্ধন সংশোধন, জন্ম নিবন্ধন ইংরেজি করার নিয়ম, জন্ম নিবন্ধন ফি, bangladesh birth certificate online application, bdris digital birth registration, correct birth certificate online, union parishad birth certificate process, 17 digit birth certificate verification',
    'অনলাইনে নতুন জন্ম নিবন্ধন আবেদন ও সংশোধন করার নিয়ম ২০২৬ (BDRIS Birth Registration Guide). ১৭ ডিজিটের ডিজিটাল সার্টিফিকেট, ইংরেজি ভার্সন ও প্রয়োজনীয় কাগজপত্র।',
    false,
    true,
    CURRENT_DATE
),
(
    'nbr-online-income-tax-return-filing',
    (SELECT id FROM categories WHERE slug = 'tax'),
    'How to File Online Income Tax Return on NBR e-Return (etaxnbr.gov.bd)',
    'A detailed walkthrough on filing individual income tax returns, salary declarations, wealth statements, and generating tax certificates via the NBR e-Tax system.',
    '[
        "Visit the official NBR e-Return portal at etaxnbr.gov.bd and click ''Sign Up / Register''.",
        "Provide your 12-digit e-TIN and your biometric SIM number registered with your NID to complete OTP registration.",
        "Log in and navigate to ''Return Submission'' -> Select Assessment Year and Return Scheme (Universal Self).",
        "Input salary income, house property income, interest/dividends, or business income as per your annual bank statement.",
        "Input tax-rebate eligible investments: DPS, Life Insurance, Provident Fund, or approved government treasury bonds.",
        "Complete Statement of Assets, Liabilities, and Expenses (Form IT-10B) if total wealth exceeds threshold (৳40 Lakhs or owning a car/flat).",
        "Review the auto-computed net taxable income, rebate deduction, and minimum tax calculation.",
        "Pay remaining tax due (if any) via A-Challan, cards, or mobile banking directly through the portal payment gateway.",
        "Submit the return, download the official Return Acknowledgement Receipt, and instantly print your Tax Certificate."
    ]'::jsonb,
    '[
        "12-digit e-TIN (Taxpayer Identification Number).",
        "Biometric mobile SIM registered against applicant NID.",
        "Salary certificate from employer covering July 1 to June 30 of income year.",
        "Bank account statements for all operational accounts for the financial year.",
        "Investment certificates (DPS statement, life insurance premium receipts, savings certificates).",
        "Details of assets: Land/flat purchase deeds, vehicle registration details, loan certificates."
    ]'::jsonb,
    'Filing on the NBR portal is 100% free. Applicable income tax must be paid based on standard tax brackets (minimum tax ৳3,000 to ৳5,000 depending on city location if taxable income exceeds exemption threshold).',
    'Instant acknowledgement receipt and downloadable Tax Certificate immediately upon online submission.',
    'National Board of Revenue (NBR) — Online e-Return Wing / Taxes Circle',
    'nbr ereturn online, kivabe income tax return debo, etaxnbr gov bd, online tax return bd, zero return kivabe submit kore, tax certificate download, psr certificate bangladesh, income tax slab 2026, অনলাইনে আয়কর রিটার্ন দাখিল, শূন্য রিটার্ন দাখিল করার নিয়ম, ই-রিটার্ন ট্যাক্স সার্টিফিকেট ডাউনলোড, পিএসআর কি, করমুক্ত আয়ের সীমা, how to file income tax return online bangladesh, etaxnbr registration with nid, zero tax return online',
    'অনলাইনে ইনকাম ট্যাক্স রিটার্ন (e-Return) দাখিল ও শূন্য রিটার্ন সাবমিট করার নিয়ম ২০২৬ (NBR e-Return Guide). তাৎক্ষণিক ট্যাক্স সার্টিফিকেট ও পিএসআর পাওয়ার উপায়।',
    true,
    true,
    CURRENT_DATE
),
(
    'e-namjari-land-mutation-online',
    (SELECT id FROM categories WHERE slug = 'land-property'),
    'e-Namjari Online Land Mutation Application & Fee Payment Process',
    'The complete digital workflow for transferring and recording land title records (Mutation / Porcha / DCR) via the Ministry of Land e-Mutation portal.',
    '[
        "Visit mutation.land.gov.bd and click on ''Apply for e-Mutation (ই-নামজারি আবেদন)''.",
        "Enter applicant NID and date of birth for instant Election Commission identity verification.",
        "Select the land location: District, Upazila, and Mouza, and enter the Deed number, Registry Office, and Registry date.",
        "Input seller/transferor details and enter Khatian number, Plot (Daag) number, and land quantity in decimals.",
        "Upload required scanned documents: Registered deed, previous via deeds, current Land Development Tax (Khajna) receipt, and site sketch.",
        "Pay the initial application fee (Court fee ৳20 + Notice issuance fee ৳50 = ৳70) via mobile banking (bKash/Nagad).",
        "Track case updates via SMS; attend hearing if notified by the Assistant Commissioner (Land) or Union Land Officer.",
        "Upon approval, pay the DCR fee (Record correction ৳1,000 + Khatian fee ৳100 = ৳1,100) online within the stipulated timeframe.",
        "Download and print the QR-code-verified digital DCR and new Mutation Khatian."
    ]'::jsonb,
    '[
        "Scanned copy of the Registered Sale/Gift/Exchange Deed.",
        "Successive title deeds (Via deeds / বায়া দলিল) establishing property lineage.",
        "Up-to-date Land Development Tax (LD Tax / অনলাইন ভূমি উন্নয়ন কর) receipt.",
        "Copy of CS, SA, RS, or City Survey Khatian.",
        "Warishan Certificate (issued by UP Chairman/Councilor) if claiming inheritance property.",
        "Applicant NID and passport-size photo."
    ]'::jsonb,
    'Total official government fee: ৳1,170 (Application court fee ৳20, Notice fee ৳50, Record correction fee ৳1,000, Khatian copy fee ৳100). No cash payments permitted at land offices.',
    '28 working days standard service delivery timeline from date of initial online fee submission.',
    'Office of the Assistant Commissioner (Land) / Upazila Revenue Circle',
    'e-namjari land mutation, kivabe jomir namjari korbo, land mutation online bd, mutation land gov bd, dcr download kivabe korbo, porcha khatian ber korar niyom, jomir namjari korte koto taka lage, ac land office hearing, ই-নামজারি আবেদন করার নিয়ম, জমির নামজারি করার সহজ উপায়, ডিসিআর ও খতিয়ান ডাউনলোড, নামজারি ফি কত, বায়া দলিল ও খতিয়ান যাচাই, সহকারী কমিশনার ভূমি অফিস, land mutation fee bangladesh, edcr download online, online land transfer bd',
    'অনলাইনে জমির ই-নামজারি (মিউটেশন) আবেদন ও ফি পরিশোধের নিয়ম ২০২৬ (e-Namjari Land Mutation Guide). মোট সরকারি ফি ১,১৭০ টাকা, প্রয়োজনীয় কাগজপত্র ও ডিসিআর ডাউনলোডের নিয়ম।',
    false,
    true,
    CURRENT_DATE
),
(
    'e-trade-license-bangladesh-online',
    (SELECT id FROM categories WHERE slug = 'business'),
    'How to Get an e-Trade License Online (DNCC, DSCC & Municipalities)',
    'Guide to applying for a new business e-Trade License or renewing an existing license online through the City Corporation and BIDA OSS portals.',
    '[
        "Access the e-Trade License portal for your jurisdiction (e.g. etradelicense.dncc.gov.bd for DNCC or bida.gov.bd OSS).",
        "Register your profile with mobile number, email, and NID verification.",
        "Select your business category, nature of trade (Commercial, Manufacturing, IT/Services), and exact commercial address.",
        "Upload required business documents: tenancy agreement, premises utility bill, NID, and passport photo.",
        "For limited companies, upload Certificate of Incorporation, Memorandum and Articles of Association (MoA/AoA).",
        "Submit the application for automatic verification or field supervisor assessment.",
        "Receive SMS notification of assessed trade license fee, signboard tax (usually 30%), and source tax.",
        "Pay the total fee online through integrated internet banking or mobile financial services (bKash/Nagad).",
        "Instantly download the digitally signed QR-code e-Trade License certificate."
    ]'::jsonb,
    '[
        "National ID (NID) of entrepreneur / proprietor / managing director.",
        "Passport size photograph of the applicant.",
        "Commercial premises rental deed / tenancy agreement or property ownership tax receipt.",
        "12-digit e-TIN certificate in the name of the proprietor or business entity.",
        "For industrial/chemical/restaurant trades: Fire Safety License, Environmental Clearance, or BSTI certificate as applicable.",
        "For companies: Certificate of Incorporation, Form XII, MoA & AoA."
    ]'::jsonb,
    'Varies by business category and location: General commercial/small trade: ৳2,000–৳5,000; Large enterprises/consultancy: ৳10,000–৳30,000+. Includes 30% Signboard Tax and 15% VAT plus statutory source tax.',
    'Instant to 3 working days for standard commercial e-Trade licenses; 7–15 days if factory or fire inspection is mandatory.',
    'City Corporation Zonal Office / Pourashava / Union Parishad office',
    'etrade license bd, kivabe trade licence korbo, dncc etrade license apply, dscc trade license renew, trade license korte ki ki lagbe, trade license fees in bangladesh, business registration bangladesh, ট্রেড লাইসেন্স করার নিয়ম, নতুন ট্রেড লাইসেন্স আবেদন, ট্রেড লাইসেন্স নবায়ন ফি, ঢাকা উত্তর ও দক্ষিণ সিটি কর্পোরেশন ট্রেড লাইসেন্স, অনলাইন ট্রেড লাইসেন্স ডাউনলোড, how to get trade license in bangladesh, municipal trade license online, company trade license requirements',
    'অনলাইনে ই-ট্রেড লাইসেন্স আবেদন ও নবায়নের সহজ নিয়ম ২০২৬ (e-Trade License Guide). সিটি কর্পোরেশন ও পৌরসভায় নতুন ব্যবসা নিবন্ধন, প্রয়োজনীয় ডকুমেন্টস ও ফি তালিকা।',
    false,
    true,
    CURRENT_DATE
),
(
    'online-land-development-tax-khajna',
    (SELECT id FROM categories WHERE slug = 'land-property'),
    'How to Pay Online Land Development Tax (e-Khajna) via ldtax.gov.bd',
    'Step-by-step guide to holding registration, ledger creation, and digital payment of annual Land Development Tax (Khajna) to get automated Dakhila receipts.',
    '[
        "Go to the Ministry of Land LD Tax portal at ldtax.gov.bd and click ''Citizen Registration (নাগরিক নিবন্ধন)''.",
        "Input your active mobile phone number and 10 or 17 digit NID number with birth date to complete SMS OTP verification.",
        "Add your land holding details: Select Division, District, Upazila, Mouza, and enter Khatian number and Holding number.",
        "Upload scanned copy of your latest Mutation Khatian and previous tax payment dakhila.",
        "Wait for the Union Land Assistant Officer (Tehsildar) to verify and approve the digital holding ledger.",
        "Once approved, review the auto-calculated annual tax and any accumulated arrear (বকেয়া) interest.",
        "Click ''Pay Online'' and pay using bKash, Nagad, Rocket, Upay, or internet banking.",
        "Instantly download the digitally signed QR-code Dakhila (রশিদ) for your official property records."
    ]'::jsonb,
    '[
        "Applicant NID number and mobile number registered against own NID.",
        "Latest Mutation (Namjari) Khatian and DCR copy.",
        "Previous land tax payment receipt (Dakhila) or registered deed copy.",
        "Accurate plot (Daag) number and land area in decimals."
    ]'::jsonb,
    'Calculated based on land classification (agricultural vs commercial/residential) and municipal zone. Agricultural land up to 25 bighas is exempt from basic tax (nominal holding maintenance fee applies). Commercial/residential rates range from ৳5 to ৳300+ per decimal depending on city corporation tier.',
    'Holding approval takes 2–5 working days; payment and Dakhila generation is instantaneous.',
    'Ministry of Land — Online LD Tax Portal / Union Land Office (Tehsil Office)',
    'ldtax gov bd, online khajna payment, kivabe jomir khajna debo, land tax receipt dakhila download, e-khajna bangladesh, bhumi unnayan kor, jomir dakhila ber korar niyom, holding number ber korar niyom, অনলাইনে জমির খাজনা পরিশোধ, ভূমি উন্নয়ন কর দেওয়ার নিয়ম, দাখিলা ডাউনলোড, অনলাইনে খাজনা কত টাকা, how to pay land development tax online bangladesh, ldtax citizen registration',
    'অনলাইনে জমির ভূমি উন্নয়ন কর (e-Khajna) প্রদান ও দাখিলা ডাউনলোডের নিয়ম ২০২৬ (ldtax.gov.bd Guide). হোল্ডিং নিবন্ধন, বকেয়া যাচাই ও কিউআর দাখিলা রশিদ।',
    false,
    true,
    CURRENT_DATE
)
ON CONFLICT (slug) DO UPDATE SET
    category_id = EXCLUDED.category_id,
    title = EXCLUDED.title,
    summary = EXCLUDED.summary,
    steps = EXCLUDED.steps,
    requirements = EXCLUDED.requirements,
    fees = EXCLUDED.fees,
    processing_time = EXCLUDED.processing_time,
    office = EXCLUDED.office,
    keywords = EXCLUDED.keywords,
    meta_description = EXCLUDED.meta_description,
    is_featured = EXCLUDED.is_featured,
    is_published = EXCLUDED.is_published,
    last_verified = CURRENT_DATE;

-- Guide Tags Linking
INSERT INTO guide_tags (guide_id, tag_id)
SELECT g.id, t.id FROM bd_guides g, tags t
WHERE (g.slug = 'driving-licence-bangladesh-guide' AND t.slug IN ('driving-licence', 'brta', 'smart-card'))
   OR (g.slug = 'bangladesh-epassport-application-guide' AND t.slug IN ('epassport', 'immigration'))
   OR (g.slug = 'nid-correction-smart-card-reissue' AND t.slug IN ('nid-card', 'voter-id', 'smart-card'))
   OR (g.slug = 'online-birth-registration-bdris' AND t.slug IN ('birth-certificate', 'bdris'))
   OR (g.slug = 'nbr-online-income-tax-return-filing' AND t.slug IN ('income-tax', 'e-return', 'nbr', 'tin'))
   OR (g.slug = 'e-namjari-land-mutation-online' AND t.slug IN ('e-namjari', 'mutation'))
   OR (g.slug = 'e-trade-license-bangladesh-online' AND t.slug IN ('trade-license', 'dncc', 'dscc'))
   OR (g.slug = 'online-land-development-tax-khajna' AND t.slug IN ('land-tax', 'e-namjari'))
ON CONFLICT DO NOTHING;


-- ==============================================================================
-- 4. BLOG POSTS
-- ==============================================================================

INSERT INTO bd_blog_posts (slug, title, excerpt, content, cover_image_url, tags, published_at)
VALUES
(
    'bangladesh-epassport-rules-police-verification-guide',
    'Understanding Bangladesh e-Passport Rules: When Is Police Verification Required?',
    'A breakdown of recent Department of Immigration & Passports rules on police verification, biometric enrollment tips, and expediting delivery.',
    E'Applying for a Bangladeshi e-Passport has become significantly more streamlined with the nationwide rollout of the digital portal (epassport.gov.bd). However, one of the most common points of confusion is police verification.\n\n### When is Police Verification Required?\n\n1. **First-Time Adult Applicants**: If you have never held a passport before, an automated Special Branch (SB) police verification will be generated for your present and permanent address.\n2. **Changes in Vital Information**: If your renewal involves alterations to your name, parents\' names, or permanent address that differs from your previous MRP or e-Passport, re-verification is usually mandated.\n3. **When Is It Waived?**: For straight renewal (re-issue) of an existing passport where there are no changes to personal bio-data and your NID records match, police verification is typically waived in the system.\n\n### Key Tips to Prevent Rejection or Delay\n\n- **Exact Name Match**: Ensure the spelling of your name and your parents\' names matches your NID down to every single character.\n- **Appointment Scheduling**: Do not visit without confirmed appointment slots. Most major regional offices (Agargaon, Uttara, Jatrabari) enforce strict appointment check-in queues.\n- **Payment Proof**: Keep a printed copy of the A-Challan or digital transaction receipt. If paying via mobile banking, ensure the transaction is completed under the exact Application ID.',
    null,
    '["e-Passport", "Immigration", "Travel", "Passport Office"]'::jsonb,
    now()
),
(
    'mandatory-online-tax-return-filing-bangladesh',
    'Mandatory Online e-Return Filing in Bangladesh: What Every Taxpayer Must Know',
    'The National Board of Revenue (NBR) has made online tax filing mandatory for key sectors. Here is what you need to know about compliance, deadlines, and zero returns.',
    E'The National Board of Revenue (NBR) is rapidly transitioning toward paperless tax administration. The digital e-Return platform (etaxnbr.gov.bd) has eliminated queues at tax circles and made filing accessible from any computer or smartphone.\n\n### Who Must File an Income Tax Return?\n\nUnder current income tax laws, having a Taxpayer Identification Number (e-TIN) generally requires filing an annual return, particularly if:\n- Your gross annual income exceeds the tax-free ceiling (৳3,50,000 for male individuals, ৳4,00,000 for women and senior citizens above 65).\n- You own a motor vehicle (car, SUV, microbus).\n- You own commercial space or a flat in a city corporation area.\n- You participate in tenders, hold a trade license, or practice as a certified doctor, engineer, or lawyer.\n\n### What is a Zero Return (শূন্য রিটার্ন)?\n\nIf your taxable income is below the exemption threshold, you are still legally required to submit a return if you hold a TIN for proof of submission (PSR) purposes. On the e-Tax portal, filing a zero return takes less than 10 minutes.\n\n### Why Proof of Submission of Return (PSR) is Essential\n\nPSR is now mandatory for over 40 essential services in Bangladesh, including:\n1. Obtaining or renewing a trade license.\n2. Opening or continuing bank loans exceeding ৳5 Lakhs.\n3. Purchasing savings certificates (Sanchayapatra) over ৳5 Lakhs.\n4. Registration of land or property deeds in municipal and city corporation areas.\n5. Gas and electricity utility connections for commercial premises.\n\nFiling early on the e-Return portal prevents last-minute server congestion and penalties.',
    null,
    '["Income Tax", "NBR", "e-Return", "Finance", "TIN"]'::jsonb,
    now()
),
(
    'preventing-land-fraud-with-e-namjari-and-digital-khajna',
    'Preventing Land Disputes: Why e-Namjari and Digital Khajna Are Essential',
    'How the Ministry of Land digital reforms help property owners secure their ownership records and avoid duplicate registrations or unauthorized transfers.',
    E'Land-related litigation has historically accounted for a vast portion of civil disputes in Bangladesh. The complete digitalization of land services through e-Namjari (e-Mutation) and e-Khajna (Land Development Tax) has brought unprecedented transparency.\n\n### The Risks of Not Completing Mutation (নামজারি না করার ঝুঁকি)\n\nMany property buyers assume that merely executing and registering a sale deed at the Sub-Registry Office completes the transfer. This is a critical misconception:\n- A deed conveys intent of sale, but your name does not enter the government revenue register (Record of Rights) until **Mutation** is approved.\n- If the previous owner dies, their legal heirs might attempt to mutate the land if the old record remains unchanged.\n- Without mutation in your name, you cannot legally sell, mortgage, or develop the land with RAJUK, CDA, or local authorities.\n\n### What e-Namjari Has Changed\n\n1. **No Cash Dealings**: All fees (৳1,170 total) are paid directly through government payment gateways (bKash, Nagad, cards). Paying any agent or office employee extra cash is completely illegal.\n2. **Digital QR Code Khatian**: The new DCR and Khatian contain cryptographic QR codes that allow immediate verification of genuineness by scanning with any smartphone camera.\n3. **Real-Time SMS Alerts**: As your mutation file moves through the Assistant Commissioner (Land) office, automated status messages keep you informed at each milestone.\n\nAlways ensure that your holding is registered on ldtax.gov.bd and your annual land tax dakhila is kept fully up to date.',
    null,
    '["Land & Property", "e-Namjari", "Mutation", "Land Law", "e-Khajna"]'::jsonb,
    now()
),
(
    'brta-driving-test-preparation-practical-exam-tips',
    'How to Pass the BRTA Driving Test on Your First Attempt: Practical Exam Tips',
    'A practical breakdown of the written traffic sign exam, zigzag obstacle course, and hill climbing tests at BRTA circle testing grounds.',
    E'Securing a BRTA Smart Card Driving Licence requires successfully passing three sequential examinations on testing day: the Written Test, the Oral (Viva) Test, and the Practical Driving Test.\n\n### 1. The Written Test (লিখিত পরীক্ষা)\n\nThe written paper covers basic road laws, traffic signal meanings, and road priority rules:\n- Study mandatory (circular red/blue), cautionary (triangular), and informatory (rectangular) road signs.\n- Understand speed limits in urban versus highway corridors.\n- Master the rules of overtaking on the right and yielding to roundabouts.\n\n### 2. The Viva Voce (মৌখিক পরীক্ষা)\n\nInspectors will test your familiarity with mechanical basics:\n- Checking radiator coolant level, engine oil dipstick, and brake fluid reservoir.\n- Dashboard warning indicators (check engine, battery charging warning, oil pressure light).\n- Tire pressure inspection and tread depth safety.\n\n### 3. The Practical Field Test (ব্যবহারিক পরীক্ষা)\n\n- **Zigzag Track (জিকজ্যাক ট্র্যাক)**: Maneuvering between poles without touching or stalling the engine.\n- **Reverse Parking & T-Parking**: Reversing into a marked box using side mirrors without dislodging safety cones.\n- **Ramp / Incline Stop and Go (Hill Test)**: Stopping on a steep slope using the handbrake and pulling forward smoothly without rolling backward.\n\nWear closed footwear, wear your seatbelt or helmet before starting the engine, and maintain smooth clutch-brake coordination to pass smoothly.',
    null,
    '["BRTA", "Driving Licence", "Road Safety", "Vehicle"]'::jsonb,
    now()
),
(
    'resolving-nid-birth-certificate-name-mismatches',
    'How to Resolve Name and Date of Birth Mismatches Between NID and Birth Certificate',
    'Practical strategies for aligning your National ID, digital birth certificate, and educational certificates for smooth passport and visa processing.',
    E'Mismatches between official identity documents are among the leading causes of rejected visa applications, stalled bank accounts, and passport delays in Bangladesh.\n\n### Which Document Serves as the Primary Source of Truth?\n\n- If you completed Secondary School Certificate (SSC) or higher, government departments (including Election Commission and Passport Office) treat the **educational board certificate** as the golden reference for your name and date of birth.\n- For individuals without formal schooling certificates, the verified **17-digit digital Birth Registration Certificate (BDRIS)** serves as the primary anchor.\n\n### Should You Correct NID First or Birth Certificate First?\n\n1. **If your Birth Certificate is correct and matches your SSC**, apply for NID correction online at services.nidw.gov.bd attaching your SSC certificate and digital birth certificate.\n2. **If your Birth Certificate has a spelling mistake**, submit an online correction application on bdris.gov.bd first, because your Union Parishad or City Corporation registrar can verify and approve it within days.\n\n### Don''t Forget the Parents'' Names\n\nWhen correcting your NID or getting an e-Passport, your parents\' names must match their own respective NID cards. If a parent is deceased, a death certificate alongside their historical voter list or legacy NID is accepted by the scrutiny committee.\n\nTaking time to systematically unify your documents saves months of distress during foreign immigration or job onboarding.',
    null,
    '["NID Card", "Birth Certificate", "BDRIS", "Identity", "Legal"]'::jsonb,
    now()
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    excerpt = EXCLUDED.excerpt,
    content = EXCLUDED.content,
    cover_image_url = EXCLUDED.cover_image_url,
    tags = EXCLUDED.tags;

-- ==============================================================================
-- 5. ADDITIONAL 2026 GUIDES (Vehicle Fitness, RJSC, Sanchayapatra, Land Registry)
-- ==============================================================================

INSERT INTO tags (name, slug) VALUES
    ('Tax Token', 'tax-token'),
    ('Vehicle Fitness', 'vehicle-fitness'),
    ('RJSC', 'rjsc'),
    ('Company Registration', 'company-registration'),
    ('Sanchayapatra', 'sanchayapatra'),
    ('National Savings', 'national-savings'),
    ('Sub-Registry', 'sub-registry'),
    ('Land Deed', 'land-deed')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO bd_guides (slug, category_id, title, summary, steps, requirements, fees, processing_time, office, keywords, meta_description, is_featured, is_published, last_verified)
VALUES
(
    'brta-vehicle-fitness-tax-token-renewal',
    (SELECT id FROM categories WHERE slug = 'transport'),
    'BRTA Motor Vehicle Fitness & Tax Token Online Renewal (2026)',
    'How to book vehicle fitness inspection appointments and pay annual advance income tax (AIT) and tax token fees online through BRTA BSP.',
    '[
        "Log in to the BRTA Service Portal (bsp.brta.gov.bd) and link your vehicle registration number.",
        "Check outstanding fines, route permits, or road tax dues before initiating renewal.",
        "Select ''Vehicle Fitness Appointment'' and choose your regional BRTA circle / Vehicle Inspection Centre (VIC) date slot.",
        "Pay the government fitness fee, annual road tax, and Advance Income Tax (AIT) online via bKash, cards, or partner banks.",
        "Download and print the computer-generated Tax Token with payment QR-code immediately.",
        "Drive the vehicle to the appointed BRTA test lane for mechanical inspection (brake test, emission, lights, chassis stamp verification).",
        "Upon inspector approval, receive your digital Fitness Certificate with validity updated in the central registry."
    ]'::jsonb,
    '[
        "Original Vehicle Registration Certificate (Smart Card / Blue Book).",
        "Previous Fitness Certificate and Tax Token receipts.",
        "Proof of annual Advance Income Tax (AIT) or updated e-TIN / e-Return submission acknowledgement.",
        "For commercial vehicles: Valid Route Permit and digital speed governor compliance certificate."
    ]'::jsonb,
    'Varies by vehicle engine capacity: Motorbike Tax Token: ৳2,300 (2 years) / ৳11,500 (10 years). Private car (up to 1500cc): Fitness ৳828 + Tax Token ৳25,000 AIT + Road tax ৳2,875 annually. Late surcharge applies per month of delay.',
    'Tax token issued instantly online; Fitness certificate issued same day after lane inspection passes.',
    'BRTA Circle Inspection Centre (VIC) / Metro Circle Office',
    'brta tax token, vehicle fitness certificate, bsp tax payment, ait car tax, motor fitness appointment',
    'Learn how to renew BRTA vehicle fitness and tax token online in Bangladesh. Fee tables by engine cc, appointment booking, and inspection checklists.',
    false,
    true,
    CURRENT_DATE
),
(
    'rjsc-private-limited-company-registration',
    (SELECT id FROM categories WHERE slug = 'business'),
    'How to Register a Private Limited Company Online via RJSC (2026)',
    'Comprehensive walkthrough for company Name Clearance, MoA/AoA preparation, digital signature, and Certificate of Incorporation from RJSC Bangladesh.',
    '[
        "Visit the Registrar of Joint Stock Companies and Firms portal (roc.gov.bd) and create a user account.",
        "Apply for ''Name Clearance'' for your proposed company name and pay the ৳230 fee online; approval typically takes 24 hours.",
        "Draft the Memorandum of Association (MoA) and Articles of Association (AoA) outlining shareholder objectives and capital clauses.",
        "Fill out online digital incorporation forms: Form I (Declaration), Form VI (Notice of Situation), Form IX (Consent of Directors), and Form XII (Particulars of Directors).",
        "Pay government registration stamp duty and filing fees via online A-Challan / credit card based on authorized share capital.",
        "RJSC scrutinizes submitted documents; clarify queries if requested by the Assistant Registrar.",
        "Download the digitally signed Certificate of Incorporation, Form XII, and certified MoA/AoA."
    ]'::jsonb,
    '[
        "Minimum 2 and maximum 50 shareholders/directors (for Private Limited).",
        "Valid NID and 12-digit e-TIN for all Bangladeshi resident directors; valid passports for foreign directors.",
        "Approved Name Clearance Certificate from RJSC.",
        "Drafted MoA and AoA signed by all subscribing directors.",
        "Registered office address proof (commercial tenancy agreement)."
    ]'::jsonb,
    'Name Clearance: ৳230. Government incorporation fee depends on authorized capital: roughly ৳15,000–৳25,000 for ৳10 Lakhs authorized capital (including stamp duties, filing fees, and certified copy charges).',
    'Typically 3 to 7 working days following fee payment and formal document submission.',
    'Registrar of Joint Stock Companies and Firms (RJSC) — Dhaka/Chattogram/Rajshahi/Khulna',
    'rjsc company registration, name clearance bd, roc gov bd, private limited incorporation, moa aoa bangladesh',
    'Step-by-step guide to incorporating a Private Limited Company in Bangladesh online via RJSC. Name clearance, registration fees, and legal checklists.',
    false,
    true,
    CURRENT_DATE
),
(
    'national-savings-certificates-sanchayapatra-guide',
    (SELECT id FROM categories WHERE slug = 'tax'),
    'How to Buy National Savings Certificates (Sanchayapatra) Online & Bank Rules',
    'Rules, interest rates, investment ceilings, and mandatory documents for Family Savings, 3-Month Profit, and Pensioner Sanchayapatra in Bangladesh.',
    '[
        "Select your suitable scheme: Poribar Sanchayapatra (women only), 3-Month Profit Basis, Pensioner, or 5-Year Bangladesh Sanchayapatra.",
        "Obtain the official purchase form from Bangladesh Bank counters, National Savings Bureaus, or designated commercial bank branches.",
        "Provide applicant NID, e-TIN certificate, and proof of income tax return submission (PSR) if investing over ৳5 Lakhs.",
        "Provide applicant operational bank account routing number and bank MICR cheque for the investment amount.",
        "Provide nominee(s) NID, 2 passport photographs, and designated share percentage.",
        "Submit the application; bank validates National ID via central NSD online database.",
        "Receive Sanchayapatra script or electronic receipt; monthly or quarterly profit is credited directly to your bank account via BEFTN."
    ]'::jsonb,
    '[
        "Applicant Smart NID card and recent photographs.",
        "12-digit e-TIN and Proof of Submission of Return (PSR) acknowledgment slip (compulsory above ৳5 Lakhs).",
        "MICR cheque drawn on applicant personal bank account (cash purchases above ৳50,000 prohibited).",
        "Nominee NID copy and 2 passport-size photographs.",
        "For Pensioner scheme: Certified retirement clearance and PPO documents."
    ]'::jsonb,
    'No application or processing fees. Tax at source (TDS): 5% deducted from profit for investments up to ৳5 Lakhs; 10% TDS deducted for investments above ৳5 Lakhs.',
    'Same-day issuance or 1–2 working days depending on cheque clearance via automated clearing house (BACPS).',
    'Department of National Savings, Bangladesh Bank, Post Offices, and Scheduled Commercial Banks',
    'sanchayapatra bangladesh, poribar sanchayapatra, savings certificate interest rate, national savings directorate',
    'Complete guide to buying Bangladeshi Sanchayapatra. Investment limits, required tax return documents (PSR), latest interest rates, and profit payment process.',
    false,
    true,
    CURRENT_DATE
),
(
    'land-deed-registration-sub-registry-guide',
    (SELECT id FROM categories WHERE slug = 'land-property'),
    'Land Sale Deed Registration (Dalil) Process & Government Tax Rates (2026)',
    'Important steps, registry stamp duty, local government taxes, and Sub-Registry office procedures for buying and registering real estate property in Bangladesh.',
    '[
        "Perform title verification: Inspect RS/City Survey Khatian, CS/SA lineage, updated LD Tax (Khajna), and non-encumbrance certificate (NEC) at the Sub-Registry office.",
        "Have an authorized deed writer (দলিল লেখক) draft the sale deed (Bikroy Kabala) accurately specifying Mouza rate and plot boundaries.",
        "Calculate and pay statutory government registration fees, stamp duty, capital gains tax, and local council tax via e-Challan.",
        "Both buyer and seller (along with two witnesses and an identifier) appear in person before the Sub-Registrar.",
        "Complete biometric thumbprint and live photo registration in the Sub-Registry automated system.",
        "Sub-Registrar inspects original deeds, verifies seller legal title, and executes official registration.",
        "Receive the certified Receipt (Rashid / ৫২ ধারা রশিদ) and collect the original registered deed when notified."
    ]'::jsonb,
    '[
        "Original title deeds of seller and chain (Via) deeds.",
        "Latest Mutation Khatian (e-Namjari) in seller name with updated Land Tax (Khajna) receipt.",
        "NID cards of buyer, seller, witnesses, and deed identifier.",
        "e-TIN and Proof of Submission of Return (PSR) of seller and buyer.",
        "Official e-Challan payment slips for registration fee, stamp duty, and local taxes."
    ]'::jsonb,
    'Inside City Corporation: Registration Fee 1%, Stamp Duty 1.5%, Local Govt Tax 2–3%, Source Tax (Gain Tax) 8–10% of deed value or Mouza rate (whichever is higher). Outside City areas: Total taxes generally range around 8–9% of deed value.',
    'Deed execution done on the same day; delivery of original certified registered deed takes 3 to 6 months.',
    'Directorate of Registration — District / Upazila Sub-Registry Office',
    'land registry bd, dalil registration, sub registry office fee, stamp duty bangladesh, bikroy kabala deed',
    'Learn how to register a land or flat sale deed in Bangladesh. Complete breakdown of 2026 stamp duty, gain tax rates, document verification, and Sub-Registry steps.',
    false,
    true,
    CURRENT_DATE
)
ON CONFLICT (slug) DO UPDATE SET
    category_id = EXCLUDED.category_id,
    title = EXCLUDED.title,
    summary = EXCLUDED.summary,
    steps = EXCLUDED.steps,
    requirements = EXCLUDED.requirements,
    fees = EXCLUDED.fees,
    processing_time = EXCLUDED.processing_time,
    office = EXCLUDED.office,
    keywords = EXCLUDED.keywords,
    meta_description = EXCLUDED.meta_description,
    is_featured = EXCLUDED.is_featured,
    is_published = EXCLUDED.is_published,
    last_verified = CURRENT_DATE;

INSERT INTO guide_tags (guide_id, tag_id)
SELECT g.id, t.id FROM bd_guides g, tags t
WHERE (g.slug = 'brta-vehicle-fitness-tax-token-renewal' AND t.slug IN ('tax-token', 'vehicle-fitness', 'brta'))
   OR (g.slug = 'rjsc-private-limited-company-registration' AND t.slug IN ('rjsc', 'company-registration', 'trade-license'))
   OR (g.slug = 'national-savings-certificates-sanchayapatra-guide' AND t.slug IN ('sanchayapatra', 'national-savings', 'tin'))
   OR (g.slug = 'land-deed-registration-sub-registry-guide' AND t.slug IN ('sub-registry', 'land-deed', 'mutation'))
ON CONFLICT DO NOTHING;

-- ==============================================================================
-- 6. ADDITIONAL BLOG POSTS
-- ==============================================================================

INSERT INTO bd_blog_posts (slug, title, excerpt, content, cover_image_url, tags, published_at)
VALUES
(
    'proof-of-submission-of-tax-return-psr-mandatory-services',
    'What Is PSR (Proof of Submission of Return) and Why Do You Need It in Bangladesh?',
    'Understanding the mandatory 40+ public and private services in Bangladesh that now require tax return submission proof.',
    E'The government of Bangladesh has significantly broadened the requirement for Proof of Submission of Return (PSR) under the Income Tax Act.\n\n### What Exactly Is PSR?\n\nPSR is the formal acknowledgment receipt generated upon filing your annual income tax return (either through the online etaxnbr.gov.bd platform or physical tax circles). Having just a 12-digit TIN is no longer enough.\n\n### Top Services Requiring Mandatory PSR\n\n1. **Banking & Credit**: Applying for a bank loan or credit card exceeding ৳5,00,000.\n2. **Property Transactions**: Registering land, flats, or deeds within City Corporation, Pourashava, or Cantonment board limits.\n3. **Trade Licensing**: Obtaining or renewing any municipal or Union Parishad trade license.\n4. **Vehicle Ownership**: Purchasing, registering, or renewing fitness/tax tokens of any motor car, SUV, or microbus.\n5. **National Savings Certificates**: Purchasing Sanchayapatra or opening postal savings accounts exceeding ৳5,00,000.\n6. **Utility Connections**: Getting new commercial electricity or gas connections.\n\nKeeping your online e-Return certificate downloaded on your phone ensures zero disruption when visiting financial or government institutions.',
    null,
    '["Income Tax", "NBR", "PSR", "Tax Compliance", "Banking"]'::jsonb,
    now()
),
(
    'how-to-verify-land-ownership-before-buying-bangladesh',
    '7 Critical Documents You Must Verify Before Buying Any Land in Bangladesh',
    'A practical legal checklist to avoid property fraud, disputed titles, and forged Khatiyan records before executing a land sale deed.',
    E'Buying property in Bangladesh is a major financial milestone, but fraud caused by counterfeit deeds and manipulated records remains a risk. Protect your investment by systematically demanding these 7 documents:\n\n### 1. CS, SA, RS, and City Survey Khatiyan\nTrace the land lineage from the original Cadastral Survey (CS) to State Acquisition (SA), Revisional Survey (RS), and current City Survey (where applicable). Ensure there is an unbroken chain of title.\n\n### 2. Successive Via Deeds (বায়া দলিল)\nEvery registered sale deed through which the property transferred ownership over the last 30 years must be inspected.\n\n### 3. Updated e-Namjari Mutation Khatian & DCR\nThe seller must possess an approved Mutation Khatian in their own name. Never buy land based only on a previous generation''s deed without mutation.\n\n### 4. Digital Land Development Tax (e-Khajna) Dakhila\nCheck on ldtax.gov.bd that all annual taxes are cleared up to the current Bengali calendar year.\n\n### 5. Non-Encumbrance Certificate (NEC / ১২ ধারা নির্দায় সার্টিফিকেট)\nObtain an NEC from the local Sub-Registry office proving the property is not mortgaged to a bank or pledged elsewhere.\n\n### 6. Master Plan & Zoning Approval\nVerify with RAJUK, CDA, KDA, or local master plans that the land is not designated for canals, flood flow zones, or government road widening acquisitions.\n\n### 7. Physical Demarcation & Possession\nEnsure physical possession matches the plot boundaries indicated on the Mouza sheet.',
    null,
    '["Land & Property", "Land Law", "Due Diligence", "e-Namjari"]'::jsonb,
    now()
),
(
    'epassport-delivery-status-tracking-codes-explained',
    'e-Passport Application Status Codes Explained: From Enrolment to Ready for Issuance',
    'A decoder for every status message on epassport.gov.bd so you know exactly where your passport is in the production pipeline.',
    E'After finishing your biometric appointment at the regional passport office, tracking your application online at epassport.gov.bd helps you understand its exact progress. Here is what the official system status codes mean:\n\n- **Submitted**: Your online application is registered in the central system awaiting biometric capture.\n- **Enrolment in Progress**: You attended the office, and your photo, fingerprints, and iris data have been captured.\n- **Pending Police Verification**: Your application has been sent to the Special Branch (SB) or local police for background verification.\n- **Police Verification in Progress**: An investigating officer has been assigned to verify your home address and record.\n- **Pending Approval**: The Assistant Director (AD) or Deputy Director at the Passport Office is reviewing your verified dossier.\n- **Sent for Personalization**: The application was approved and sent to the central automated printing press in Dhaka.\n- **Personalized**: Your smart e-Passport chip has been encoded and physically printed.\n- **Shipped**: The passport is in transit from the central printing press to your local regional office.\n- **Ready for Issuance**: Your passport has arrived at your regional passport office counter. You can now visit with your delivery slip to collect it!\n\nWhen visiting for collection, bring your original delivery slip and original NID/Birth Certificate.',
    null,
    '["e-Passport", "Travel", "DIP", "Tracking"]'::jsonb,
    now()
)
ON CONFLICT (slug) DO UPDATE SET
    title = EXCLUDED.title,
    excerpt = EXCLUDED.excerpt,
    content = EXCLUDED.content,
    cover_image_url = EXCLUDED.cover_image_url,
    tags = EXCLUDED.tags;



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
    'marriage registration, kabin nama, nikah registration, marriage certificate bangladesh',
    'How to register a marriage in Bangladesh and get your Kabin Nama / marriage certificate.',
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
    'police clearance certificate, pcc bangladesh, pcc police gov bd',
    'How to apply online for a Police Clearance Certificate (PCC) in Bangladesh, with fees and processing time.',
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
    'brta driving licence, bsp portal, smart card licence bd, driving test bangladesh, brta fee 2026',
    'Up-to-date guide for getting a BRTA Smart Card Driving Licence in Bangladesh. Step-by-step BSP online registration, medical certificate, test rules, and fee details.',
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
    'epassport bd, bangladesh passport renewal, epassport fee 2026, dip gov bd, passport appointment',
    'Step-by-step guide to Bangladeshi e-Passport application and renewal. Updated fee slabs, biometric enrollment tips, and police verification guidelines.',
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
    'nid correction online, nid wallet app, smart nid card reissue, nidw gov bd, voter id change bd',
    'Learn how to correct information on your Bangladesh NID card or reissue a lost Smart Card online. Details on required documents, NID Wallet app, and fee structure.',
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
    'birth certificate bd, bdris gov bd, 17 digit birth registration, digital jonmo nibondhon, english birth certificate',
    'How to register a birth or obtain a 17-digit bilingual birth certificate in Bangladesh through BDRIS. Complete document checklist and latest government rules.',
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
    'nbr ereturn, online tax return bd, etaxnbr gov bd, income tax slab 2026, tax certificate download',
    'Step-by-step guide to filing your annual income tax return online in Bangladesh via NBR etaxnbr.gov.bd. Tax calculations, deductions, and instant certificate download.',
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
    'e-namjari, land mutation bd, mutation land gov bd, dcr download, porcha khatian, ac land office',
    'Complete guide to e-Namjari online land mutation in Bangladesh. Learn the exact fee structure (৳1,170), step-by-step application, and QR-code DCR download.',
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
    'etrade license, trade license bd, dncc etrade, dscc trade license, business registration bangladesh',
    'Complete guide on getting an e-Trade License online in Bangladesh. Required documents for proprietorships and companies, fee breakdown, and renewal details.',
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
    'ldtax gov bd, online khajna payment, land tax receipt dakhila, e-khajna bangladesh, bhumi unnayan kor',
    'Learn how to pay Bangladesh Land Development Tax (e-Khajna) online at ldtax.gov.bd. Register holding, calculate arrears, and download QR-code digital tax dakhila.',
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


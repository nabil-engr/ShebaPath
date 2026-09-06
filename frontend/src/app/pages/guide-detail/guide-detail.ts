import { Component, inject, OnInit, signal } from '@angular/core';
import { DatePipe, DOCUMENT } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { switchMap } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';
import { GuidesService } from '../../core/services/guides.service';
import { PdfExportService } from '../../core/services/pdf-export.service';
import { AuthService } from '../../core/services/auth.service';
import { BookmarkService } from '../../core/services/bookmark.service';
import { GuideDetail, GuideFaq } from '../../core/models/models';
import { ShareButtonComponent } from '../../Shared/share-button/share-button';
import { TagChipsComponent } from '../../Shared/tag-chips/tag-chips';
import { TranslateSyncService } from '../../core/services/translate-sync.service';
import { GuideSummary } from '../../core/models/models';
import { SeoService } from '../../core/services/seo.service';

const GUIDE_FAQS: Record<string, GuideFaq[]> = {
  'bangladesh-epassport-application-guide': [
    {
      question: 'How do I apply for an e-Passport online? (Kivabe e-passport korbo?)',
      answer: 'To apply for an e-Passport, register an account on epassport.gov.bd. Fill in the online form matching your National ID (NID) or 17-digit digital birth certificate, pay the prescribed passport fee online or via bank challan, schedule an appointment, and visit your regional passport office for biometric photo and fingerprint capture.'
    },
    {
      question: 'What documents are required for an e-Passport application? (Passport korte ki ki lagbe?)',
      answer: 'For adults (18+), original Smart NID card, printed Application Summary, and fee payment receipt (A-Challan) are required. For minors under 18, online verified 17-digit birth certificate and parents\' NID copies are required. For passport renewal, bring your previous original passport.'
    },
    {
      question: 'What is the government fee for an e-Passport in Bangladesh? (Passport fee koto?)',
      answer: 'For a 48-page 5-year passport, the regular fee is ৳4,025 and express fee is ৳6,325. For 48 pages 10-year validity, regular fee is ৳5,750 and express is ৳8,050. For 64 pages 10-year validity, regular fee is ৳8,050 and express is ৳10,350 (all fees include 15% VAT).'
    },
    {
      question: 'Is police verification mandatory for passport applications? (Police verification process)',
      answer: 'Police verification is mandatory at permanent and present addresses for first-time applicants. For routine re-issues or renewals where name and personal information remain unchanged, police verification is usually waived.'
    },
    {
      question: 'How quickly can I get an emergency passport? (Super express passport delivery)',
      answer: 'Under the Super Express delivery option, passports are issued within 2 to 3 working days. Express delivery takes 7 to 10 working days, while Regular delivery typically takes 15 to 21 working days.'
    },
    {
      question: 'How can I check my e-Passport delivery status online? (Passport tracking bd)',
      answer: 'Visit epassport.gov.bd and click Check Status. Enter your Application ID or Online Registration Number (OIN) and date of birth to track the real-time processing and delivery status of your passport.'
    }
  ],
  'passport': [
    {
      question: 'How do I apply for an e-Passport online? (Kivabe e-passport korbo?)',
      answer: 'To apply for an e-Passport, register an account on epassport.gov.bd. Fill in the online form matching your National ID (NID) or 17-digit digital birth certificate, pay the prescribed passport fee online or via bank challan, schedule an appointment, and visit your regional passport office for biometric photo and fingerprint capture.'
    },
    {
      question: 'What documents are required for an e-Passport application? (Passport korte ki ki lagbe?)',
      answer: 'For adults (18+), original Smart NID card, printed Application Summary, and fee payment receipt (A-Challan) are required. For minors under 18, online verified 17-digit birth certificate and parents\' NID copies are required. For passport renewal, bring your previous original passport.'
    },
    {
      question: 'What is the government fee for an e-Passport in Bangladesh? (Passport fee koto?)',
      answer: 'For a 48-page 5-year passport, the regular fee is ৳4,025 and express fee is ৳6,325. For 48 pages 10-year validity, regular fee is ৳5,750 and express is ৳8,050. For 64 pages 10-year validity, regular fee is ৳8,050 and express is ৳10,350 (including 15% VAT).'
    },
    {
      question: 'Is police verification mandatory for passport applications? (Police verification process)',
      answer: 'Police verification is mandatory for first-time applicants. For standard renewals without any data changes, police verification is usually waived.'
    }
  ],
  'driving-licence-bangladesh-guide': [
    {
      question: 'How do I apply for a BRTA driving licence? (Kivabe driving licence korbo?)',
      answer: 'First register an account on the BRTA Service Portal (bsp.brta.gov.bd). Upload your medical certificate (Form Medical-1) and apply for a Learner Driving Licence with online fee payment. Next, appear for the written, oral, and practical field test on your assigned date, submit biometrics, and receive your Smart Card Driving Licence.'
    },
    {
      question: 'What documents are required for a driving licence in Bangladesh?',
      answer: 'Educational certificate (minimum Grade 8 / JSC pass), medical fitness certificate signed by a registered physician, original NID card, passport-size photos, and a police verification clearance certificate for professional category licences.'
    },
    {
      question: 'What are the government fees for a BRTA driving licence? (BRTA fees)',
      answer: 'Learner licence fee is ৳345 for single category (bike or car) or ৳518 for both. Non-professional smart card licence (10-year validity) is ৳4,557 and professional licence (5-year validity) is ৳2,832 including postal and 15% VAT.'
    },
    {
      question: 'How is the BRTA driving exam and field test conducted? (Driving test rules bd)',
      answer: 'On test day, candidates take a written test on traffic signs and road safety, followed by an oral viva on vehicle mechanics, and finally a practical field driving test including zigzag obstacle tracks, reverse parking, and gradient slope tests.'
    }
  ],
  'driving-licence': [
    {
      question: 'How do I apply for a BRTA driving licence? (Kivabe driving licence korbo?)',
      answer: 'Register on the BRTA Service Portal (bsp.brta.gov.bd), upload your medical certificate, apply for a Learner Driving Licence online, pass the written, oral, and field tests, and provide biometrics for your smart card.'
    },
    {
      question: 'What documents are required for a driving licence in Bangladesh?',
      answer: 'Minimum Grade 8 / JSC certificate, medical fitness certificate signed by a registered doctor, original NID card, and passport-size photographs.'
    },
    {
      question: 'What are the government fees for a BRTA driving licence? (BRTA fees)',
      answer: 'Learner fee is ৳345 (single category) or ৳518 (bike + car). Non-professional licence is ৳4,557 and professional licence is ৳2,832.'
    }
  ],
  'nid-correction-smart-card-reissue': [
    {
      question: 'How do I correct errors on my National ID (NID) online? (NID shongshodhon)',
      answer: 'Visit services.nidw.gov.bd, create an account using your NID number and date of birth, and complete biometric face verification via the official NID Wallet mobile app. Edit the required fields in your profile, pay the government fee via mobile banking, upload documentary proof, and submit the application.'
    },
    {
      question: 'What documents are needed to correct name and date of birth on NID?',
      answer: 'SSC/educational certificate, 17-digit digital birth registration certificate, passport, or driving licence. For correcting parents\' names, certified copies of parents\' NID or inheritance certificates are required.'
    },
    {
      question: 'What is the government fee for NID correction? (NID correction fees)',
      answer: 'First correction fee is ৳230 (৳200 + 15% VAT), second correction is ৳345, and subsequent corrections are ৳575. Reissuing a lost card costs ৳230 for regular delivery and ৳345 for urgent delivery.'
    }
  ],
  'national-id': [
    {
      question: 'How do I correct errors on my National ID (NID) online? (NID shongshodhon)',
      answer: 'Visit services.nidw.gov.bd, create an account using your NID number, verify your face using the NID Wallet mobile app, modify your profile details, pay the fee, and upload proof documents.'
    },
    {
      question: 'What documents are needed to correct name and date of birth on NID?',
      answer: 'SSC/board educational certificate, 17-digit digital birth registration certificate, passport, or driving licence.'
    },
    {
      question: 'What is the government fee for NID correction? (NID correction fees)',
      answer: 'First correction fee is ৳230 (৳200 + 15% VAT), second correction is ৳345, and subsequent corrections are ৳575.'
    }
  ],
  'online-birth-registration-bdris': [
    {
      question: 'How do I apply for a new birth registration online? (Online birth certificate)',
      answer: 'Go to bdris.gov.bd and select Application for New Birth Registration. Choose your Union Parishad or City Corporation Zone, fill in the applicant and parental details in both Bengali and English, upload the EPI vaccination card or hospital discharge certificate, and submit the printed application within 15 days to your local office.'
    },
    {
      question: 'What is the official fee for birth registration in Bangladesh?',
      answer: 'Registration is completely free within 45 days of birth. From 46 days to 5 years of age, the fee is ৳25. For applicants over 5 years old, the fee is ৳50. English version copy fee is ৳50 and correction fee is ৳100.'
    },
    {
      question: 'Why is a 17-digit digital birth registration certificate required?',
      answer: 'A 17-digit online digital birth registration certificate is mandatory for e-Passport applications, school admissions, obtaining a National ID card, marriage registration, and official citizen services across Bangladesh.'
    }
  ],
  'birth-certificate': [
    {
      question: 'How do I apply for a new birth registration online? (Online birth certificate)',
      answer: 'Visit bdris.gov.bd, select Application for New Birth Registration, fill in details in Bengali and English, upload vaccination/hospital proof, and submit the printed copy to your local Union Parishad or City Corporation office.'
    },
    {
      question: 'What is the official fee for birth registration in Bangladesh?',
      answer: 'Completely free within 45 days of birth. ৳25 for ages 46 days to 5 years, and ৳50 for applicants over 5 years old.'
    }
  ],
  'e-namjari-land-mutation-online': [
    {
      question: 'How do I apply for online land mutation (e-Namjari)? (Land mutation process)',
      answer: 'Visit mutation.land.gov.bd and log in using your NID. Enter land mouza, khatian, and dag numbers, and upload the original purchase deed, via deed, and latest land development tax (Khajna) payment receipt. Pay the initial court fee and notice fee (৳70) through mobile banking.'
    },
    {
      question: 'What is the total government fee for e-Namjari land mutation in Bangladesh?',
      answer: 'The total official government fee is ৳1,170 (Court fee ৳20, Notice service fee ৳50, Record correction fee ৳1,000, and Khatian fee ৳100). All fees are payable strictly online without any cash handling.'
    }
  ],
  'e-trade-license-bangladesh-online': [
    {
      question: 'How do I get an e-Trade License online? (Online trade license apply process)',
      answer: 'Log into your relevant City Corporation (e.g., etradelicense.dncc.gov.bd) or Municipality portal. Select business category and location, upload rental agreement, e-TIN certificate, and NID card, and pay the assessed fees online to instantly download the QR-code verified digital trade license.'
    },
    {
      question: 'What documents are required to obtain a trade license in Bangladesh?',
      answer: 'Entrepreneur\'s National ID (NID), passport-size photographs, commercial premises rental deed or holding tax receipt, and an e-TIN certificate.'
    }
  ],
  'nbr-online-income-tax-return-filing': [
    {
      question: 'How do I submit an online income tax return (e-Return)? (etaxnbr filing)',
      answer: 'Visit etaxnbr.gov.bd and register using your 12-digit e-TIN and biometric SIM. Enter your annual salary, business or investment income, and statement of assets. The system computes tax liabilities automatically. If tax is due, pay online to immediately download your tax acknowledgment receipt and certificate.'
    },
    {
      question: 'What is a Zero Tax Return (Zero Return) and why should I file it?',
      answer: 'If your annual income falls below the taxable threshold (৳3.5 lakh for men, ৳4 lakh for women), no tax is payable, but filing an online return is mandatory to obtain a Proof of Submission of Return (PSR) certificate. Filing a zero return online takes only 5 to 10 minutes.'
    }
  ]
};

@Component({
  selector: 'app-guide-detail',
  standalone: true,
  imports: [RouterLink, DatePipe, ShareButtonComponent, TagChipsComponent],
  templateUrl: './guide-detail.html',
  styleUrl: './guide-detail.scss',
})
export class GuideDetailPage implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly guidesService = inject(GuidesService);
  private readonly pdfExport = inject(PdfExportService);
  private readonly document = inject(DOCUMENT);
  protected readonly auth = inject(AuthService);
  protected readonly bookmarks = inject(BookmarkService);
  private readonly translateSync = inject(TranslateSyncService);
  private readonly seo = inject(SeoService);

  readonly guide = signal<GuideDetail | null>(null);
  readonly notFound = signal(false);
  readonly loadError = signal(false);
  readonly loading = signal(true);
  readonly savingBookmark = signal(false);
  readonly relatedGuides = signal<GuideSummary[]>([]);
  readonly faqs = signal<GuideFaq[]>([]);

  get pageUrl(): string {
    return this.document.location.href;
  }

  ngOnInit(): void {
    this.route.paramMap
      .pipe(switchMap((params) => this.guidesService.get(params.get('slug')!)))
      .subscribe({
        next: (guide) => {
          const guideFaqs = guide.faqs && guide.faqs.length > 0 ? guide.faqs : (GUIDE_FAQS[guide.slug] || []);
          this.faqs.set(guideFaqs);
          guide.faqs = guideFaqs;
          this.guide.set(guide);
          this.loading.set(false);
          this.seo.applyGuide(guide);
          this.translateSync.resync();
          this.guidesService.related(guide.slug).subscribe((g) => this.relatedGuides.set(g));
        },
        error: (error: HttpErrorResponse) => {
          const notFound = error.status === 404;
          this.notFound.set(notFound);
          this.loadError.set(!notFound);
          this.loading.set(false);
          this.seo.markUnavailable('Guide', notFound);
        },
      });

    if (this.auth.isAuthenticated() && !this.bookmarks.loaded()) {
      this.bookmarks.loadAll().subscribe();
    }
  }

  reload(): void {
    this.document.location.reload();
  }

  toggleBookmark(): void {
    const guide = this.guide();
    if (!guide || this.savingBookmark()) return;
    this.savingBookmark.set(true);
    this.bookmarks.toggle(guide.slug).subscribe({
      complete: () => this.savingBookmark.set(false),
      error: () => this.savingBookmark.set(false),
    });
  }

  downloadPdf(): void {
    if (typeof window !== 'undefined') {
      window.print();
    }
  }
}

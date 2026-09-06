import { DOCUMENT } from '@angular/common';
import { inject, Injectable } from '@angular/core';
import { Meta, Title } from '@angular/platform-browser';
import { BlogDetail, GuideDetail } from '../models/models';

const SITE_NAME = 'ShebaPath';
const DEFAULT_DESCRIPTION =
  'Independent, easy-to-follow guides for common Bangladesh government services. Not an official government website.';

const FALLBACK_GUIDE_KEYWORDS: Record<string, string> = {
  'passport': 'kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport, passport bananor dhap, e-passport bananor dhap, steps for applying passport, passport e apply er jonno ki ki lagbe, passport korte koto taka lage, passport fees bd 2026, passport renew korar niyom, urgent passport kivabe banabo, passport police verification process, epassport appointment kivabe nibo, passport status check bd, পাসপোর্ট করার নিয়ম, ই-পাসপোর্ট আবেদন করার নিয়ম, পাসপোর্ট করতে কি কি লাগে, পাসপোর্ট তৈরির প্রক্রিয়া, পাসপোর্ট বানানোর সহজ উপায়, নতুন পাসপোর্ট করার নিয়ম ২০২৬, ই পাসপোর্ট ফি জমা দেওয়ার নিয়ম, পাসপোর্ট ডেলিভারি চেক, পুলিশ ভেরিফিকেশন নিয়ম, how to apply for epassport in bangladesh, bangladesh passport online application steps, epassport fee structure, passport renewal bangladesh, documents needed for passport bd, emergency passport delivery bangladesh',
  'bangladesh-epassport-application-guide': 'kivabe passport korbo, bangladesh e passport process, passport toirir prokria, e-passport, passport bananor dhap, e-passport bananor dhap, steps for applying passport, passport e apply er jonno ki ki lagbe, passport korte koto taka lage, passport fees bd 2026, passport renew korar niyom, urgent passport kivabe banabo, passport police verification process, epassport appointment kivabe nibo, passport status check bd, পাসপোর্ট করার নিয়ম, ই-পাসপোর্ট আবেদন করার নিয়ম, পাসপোর্ট করতে কি কি লাগে, পাসপোর্ট তৈরির প্রক্রিয়া, পাসপোর্ট বানানোর সহজ উপায়, নতুন পাসপোর্ট করার নিয়ম ২০২৬, ই পাসপোর্ট ফি জমা দেওয়ার নিয়ম, পাসপোর্ট ডেলিভারি চেক, পুলিশ ভেরিফিকেশন নিয়ম, how to apply for epassport in bangladesh, bangladesh passport online application steps, epassport fee structure, passport renewal bangladesh, documents needed for passport bd, emergency passport delivery bangladesh',
  'driving-licence': 'kivabe driving licence korbo, brta driving licence, learner licence korar niyom, driving test kivabe hoy, bike licence banate koto taka lage, smart card driving licence delivery check, bsp brta online registration, বিআরটিএ ড্রাইভিং লাইসেন্স করার নিয়ম, লার্নার লাইসেন্স আবেদন, স্মার্ট কার্ড ড্রাইভিং লাইসেন্স পাওয়ার ধাপ, ড্রাইভিং টেস্ট পরীক্ষার নিয়ম, মোটরসাইকেল লাইসেন্স ফি, how to get driving licence in bangladesh, brta learner driving licence online, driving test procedure bangladesh, brta smart card fees, bsp portal account open, driving medical certificate form',
  'driving-licence-bangladesh-guide': 'kivabe driving licence korbo, brta driving licence, learner licence korar niyom, driving test kivabe hoy, bike licence banate koto taka lage, smart card driving licence delivery check, bsp brta online registration, বিআরটিএ ড্রাইভিং লাইসেন্স করার নিয়ম, লার্নার লাইসেন্স আবেদন, স্মার্ট কার্ড ড্রাইভিং লাইসেন্স পাওয়ার ধাপ, ড্রাইভিং টেস্ট পরীক্ষার নিয়ম, মোটরসাইকেল লাইসেন্স ফি, how to get driving licence in bangladesh, brta learner driving licence online, driving test procedure bangladesh, brta smart card fees, bsp portal account open, driving medical certificate form',
  'national-id': 'kivabe nid card shongshodhon korbo, new voter howar niyom, smart nid card kivabe pabo, nid wallet verification kivabe kore, nid hariye gele ki korbo, voter id card correction process bangladesh, nid card download online, ভোটার আইডি কার্ড সংশোধন করার নিয়ম, নতুন ভোটার হওয়ার নিয়ম, স্মার্ট কার্ড তোলার নিয়ম, এনআইডি ওয়ালেট দিয়ে ছবি ভেরিফিকেশন, হারিয়ে যাওয়া আইডি কার্ড তোলার নিয়ম, জন্ম তারিখ সংশোধন, অনলাইন এনআইডি ডাউনলোড, online nid card correction bd, smart nid card download, nid wallet facial verification steps, lost nid reissue procedure, nid correction fee bkash',
  'nid-correction-smart-card-reissue': 'kivabe nid card shongshodhon korbo, new voter howar niyom, smart nid card kivabe pabo, nid wallet verification kivabe kore, nid hariye gele ki korbo, voter id card correction process bangladesh, nid card download online, ভোটার আইডি কার্ড সংশোধন করার নিয়ম, নতুন ভোটার হওয়ার নিয়ম, স্মার্ট কার্ড তোলার নিয়ম, এনআইডি ওয়ালেট দিয়ে ছবি ভেরিফিকেশন, হারিয়ে যাওয়া আইডি কার্ড তোলার নিয়ম, জন্ম তারিখ সংশোধন, অনলাইন এনআইডি ডাউনলোড, online nid card correction bd, smart nid card download, nid wallet facial verification steps, lost nid reissue procedure, nid correction fee bkash',
  'birth-certificate': 'kivabe jonmo nibondhon korbo, online birth certificate apply bd, jonmo nibondhon shongshodhon korar niyom, 17 digit birth registration download, birth certificate e bhul thakle ki korbo, jonmo nibondhon english korar niyom, অনলাইনে জন্ম নিবন্ধন আবেদন করার নিয়ম, ১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন, জন্ম নিবন্ধন সংশোধন, জন্ম নিবন্ধন ইংরেজি করার নিয়ম, জন্ম নিবন্ধন ফি, bangladesh birth certificate online application, bdris digital birth registration, correct birth certificate online, union parishad birth certificate process, 17 digit birth certificate verification',
  'online-birth-registration-bdris': 'kivabe jonmo nibondhon korbo, online birth certificate apply bd, jonmo nibondhon shongshodhon korar niyom, 17 digit birth registration download, birth certificate e bhul thakle ki korbo, jonmo nibondhon english korar niyom, অনলাইনে জন্ম নিবন্ধন আবেদন করার নিয়ম, ১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন, জন্ম নিবন্ধন সংশোধন, জন্ম নিবন্ধন ইংরেজি করার নিয়ম, জন্ম নিবন্ধন ফি, bangladesh birth certificate online application, bdris digital birth registration, correct birth certificate online, union parishad birth certificate process, 17 digit birth certificate verification',
  'trade-licence': 'etrade license bd, kivabe trade licence korbo, dncc etrade license apply, dscc trade license renew, trade license korte ki ki lagbe, trade license fees in bangladesh, business registration bangladesh, ট্রেড লাইসেন্স করার নিয়ম, নতুন ট্রেড লাইসেন্স আবেদন, ট্রেড লাইসেন্স নবায়ন ফি, ঢাকা উত্তর ও দক্ষিণ সিটি কর্পোরেশন ট্রেড লাইসেন্স, অনলাইন ট্রেড লাইসেন্স ডাউনলোড, how to get trade license in bangladesh, municipal trade license online, company trade license requirements',
  'e-trade-license-bangladesh-online': 'etrade license bd, kivabe trade licence korbo, dncc etrade license apply, dscc trade license renew, trade license korte ki ki lagbe, trade license fees in bangladesh, business registration bangladesh, ট্রেড লাইসেন্স করার নিয়ম, নতুন ট্রেড লাইসেন্স আবেদন, ট্রেড লাইসেন্স নবায়ন ফি, ঢাকা উত্তর ও দক্ষিণ সিটি কর্পোরেশন ট্রেড লাইসেন্স, অনলাইন ট্রেড লাইসেন্স ডাউনলোড, how to get trade license in bangladesh, municipal trade license online, company trade license requirements',
  'income-tax-e-return': 'nbr ereturn online, kivabe income tax return debo, etaxnbr gov bd, online tax return bd, zero return kivabe submit kore, tax certificate download, psr certificate bangladesh, income tax slab 2026, অনলাইনে আয়কর রিটার্ন দাখিল, শূন্য রিটার্ন দাখিল করার নিয়ম, ই-রিটার্ন ট্যাক্স সার্টিফিকেট ডাউনলোড, পিএসআর কি, করমুক্ত আয়ের সীমা, how to file income tax return online bangladesh, etaxnbr registration with nid, zero tax return online',
  'nbr-online-income-tax-return-filing': 'nbr ereturn online, kivabe income tax return debo, etaxnbr gov bd, online tax return bd, zero return kivabe submit kore, tax certificate download, psr certificate bangladesh, income tax slab 2026, অনলাইনে আয়কর রিটার্ন দাখিল, শূন্য রিটার্ন দাখিল করার নিয়ম, ই-রিটার্ন ট্যাক্স সার্টিফিকেট ডাউনলোড, পিএসআর কি, করমুক্ত আয়ের সীমা, how to file income tax return online bangladesh, etaxnbr registration with nid, zero tax return online',
  'police-clearance-certificate': 'police clearance certificate bangladesh, pcc online apply, kivabe police clearance korbo, pcc police gov bd, police clearance fee 500 taka, police verification for abroad, বিদেশে যাওয়ার পুলিশ ক্লিয়ারেন্স করার নিয়ম, অনলাইনে পুলিশ ক্লিয়ারেন্স আবেদন, পিটিসি সার্টিফিকেট, পুলিশ ভেরিফিকেশন চেক, how to apply for police clearance online bd, pcc status check bangladesh',
  'marriage-registration': 'marriage registration bangladesh, kabin nama toirir niyom, kazi office marriage fee, bibaho nibondhon, nikah nama registration, marriage certificate bangladesh, বিবাহ নিবন্ধন করার নিয়ম, কাবিননামা তোলার নিয়ম, কাজী অফিস বিয়ের ফি, হিন্দু বিবাহ নিবন্ধন, স্পেশাল ম্যারেজ অ্যাক্ট, legal marriage registration process bangladesh'
};

interface PageSeo {
  title: string;
  description: string;
  noIndex?: boolean;
}

@Injectable({ providedIn: 'root' })
export class SeoService {
  private readonly document = inject(DOCUMENT);
  private readonly meta = inject(Meta);
  private readonly title = inject(Title);

  applyRoute(url: string): void {
    const path = url.split(/[?#]/, 1)[0] || '/';
    this.setPage(this.routeSeo(path), path);
    this.meta.removeTag("name='keywords'");
    this.meta.removeTag("property='og:image'");
    this.meta.removeTag("name='twitter:image'");
    this.removeStructuredData();
  }

  applyGuide(guide: GuideDetail): void {
    const description = guide.metaDescription || guide.summary;
    const path = `/guides/${encodeURIComponent(guide.slug)}`;
    const pageUrl = this.canonicalUrl(path);
    this.setPage({ title: `${guide.title} — ${SITE_NAME}`, description }, path, 'article');

    const keywords = guide.keywords || FALLBACK_GUIDE_KEYWORDS[guide.slug] || guide.tags?.join(', ');
    if (keywords) this.meta.updateTag({ name: 'keywords', content: keywords });
    this.setImage(guide.featuredImage);

    // Multi-schema structured data: HowTo + FAQPage (if faqs present) + BreadcrumbList
    const graph: any[] = [
      {
        '@type': 'BreadcrumbList',
        itemListElement: [
          {
            '@type': 'ListItem',
            position: 1,
            name: 'Home',
            item: this.canonicalUrl('/'),
          },
          {
            '@type': 'ListItem',
            position: 2,
            name: 'Guides',
            item: this.canonicalUrl('/guides'),
          },
          {
            '@type': 'ListItem',
            position: 3,
            name: guide.title,
            item: pageUrl,
          },
        ],
      },
      {
        '@type': 'HowTo',
        name: guide.title,
        description,
        datePublished: guide.publishedAt,
        dateModified: guide.lastVerified,
        mainEntityOfPage: pageUrl,
        step: guide.steps.map((text, index) => ({
          '@type': 'HowToStep',
          position: index + 1,
          text,
        })),
        ...(guide.featuredImage ? { image: guide.featuredImage } : {}),
      },
    ];

    if (guide.faqs && guide.faqs.length > 0) {
      graph.push({
        '@type': 'FAQPage',
        mainEntity: guide.faqs.map((faq) => ({
          '@type': 'Question',
          name: faq.question,
          acceptedAnswer: {
            '@type': 'Answer',
            text: faq.answer,
          },
        })),
      });
    }

    this.setStructuredData({
      '@context': 'https://schema.org',
      '@graph': graph,
    });
  }

  applyBlog(post: BlogDetail): void {
    const path = `/blog/${encodeURIComponent(post.slug)}`;
    const pageUrl = this.canonicalUrl(path);
    this.setPage({ title: `${post.title} — ${SITE_NAME} Blog`, description: post.excerpt }, path, 'article');
    if (post.tags && post.tags.length > 0) {
      this.meta.updateTag({ name: 'keywords', content: post.tags.join(', ') });
    }
    this.setImage(post.coverImageUrl);

    const graph: any[] = [
      {
        '@type': 'BreadcrumbList',
        itemListElement: [
          {
            '@type': 'ListItem',
            position: 1,
            name: 'Home',
            item: this.canonicalUrl('/'),
          },
          {
            '@type': 'ListItem',
            position: 2,
            name: 'Blog',
            item: this.canonicalUrl('/blog'),
          },
          {
            '@type': 'ListItem',
            position: 3,
            name: post.title,
            item: pageUrl,
          },
        ],
      },
      {
        '@type': 'BlogPosting',
        headline: post.title,
        description: post.excerpt,
        datePublished: post.publishedAt,
        mainEntityOfPage: pageUrl,
        publisher: { '@type': 'Organization', name: SITE_NAME },
        ...(post.coverImageUrl ? { image: post.coverImageUrl } : {}),
      },
    ];

    this.setStructuredData({
      '@context': 'https://schema.org',
      '@graph': graph,
    });
  }

  markUnavailable(resource: 'Guide' | 'Post', notFound: boolean): void {
    this.title.setTitle(`${notFound ? `${resource} not found` : `Unable to load ${resource.toLowerCase()}`} — ${SITE_NAME}`);
    this.meta.updateTag({ name: 'robots', content: 'noindex, nofollow' });
    this.meta.removeTag("property='og:image'");
    this.meta.removeTag("name='twitter:image'");
    this.removeStructuredData();
  }

  private setPage(page: PageSeo, path: string, type = 'website'): void {
    const canonical = this.canonicalUrl(path);
    this.title.setTitle(page.title);
    this.meta.updateTag({ name: 'description', content: page.description });
    this.meta.updateTag({ name: 'robots', content: page.noIndex ? 'noindex, nofollow' : 'index, follow' });
    this.meta.updateTag({ property: 'og:site_name', content: SITE_NAME });
    this.meta.updateTag({ property: 'og:locale', content: 'en_BD' });
    this.meta.updateTag({ property: 'og:type', content: type });
    this.meta.updateTag({ property: 'og:title', content: page.title });
    this.meta.updateTag({ property: 'og:description', content: page.description });
    this.meta.updateTag({ property: 'og:url', content: canonical });
    this.meta.updateTag({ name: 'twitter:card', content: 'summary_large_image' });
    this.meta.updateTag({ name: 'twitter:title', content: page.title });
    this.meta.updateTag({ name: 'twitter:description', content: page.description });
    this.setCanonical(canonical);
  }

  private routeSeo(path: string): PageSeo {
    if (path === '/') {
      return { title: 'ShebaPath — Bangladesh Government Service Guides', description: DEFAULT_DESCRIPTION };
    }
    if (path === '/guides') {
      return {
        title: 'Bangladesh Government Service Guides — ShebaPath',
        description: 'Browse clear step-by-step guides for passports, NID, driving licences and other Bangladesh government services.',
      };
    }
    if (path === '/blog') {
      return {
        title: 'Tips and Updates — ShebaPath Blog',
        description: 'Practical tips and updates for navigating Bangladesh government services.',
      };
    }
    if (path === '/privacy') return { title: 'Privacy Policy — ShebaPath', description: 'Read the ShebaPath privacy policy.' };
    if (path === '/terms') return { title: 'Terms of Service — ShebaPath', description: 'Read the ShebaPath terms of service.' };

    const privatePage = /^\/(admin|account|login|register|forgot-password|reset-password)(\/|$)/.test(path);
    return {
      title: privatePage ? `Account — ${SITE_NAME}` : `Page — ${SITE_NAME}`,
      description: DEFAULT_DESCRIPTION,
      noIndex: privatePage || !/^\/(guides|blog)\//.test(path),
    };
  }

  private canonicalUrl(path: string): string {
    const relativePath = path.replace(/^\//, '');
    const url = new URL(relativePath || '.', this.document.baseURI).toString();
    return path === '/' ? url : url.replace(/\/$/, '');
  }

  private setCanonical(url: string): void {
    let link = this.document.head.querySelector<HTMLLinkElement>("link[rel='canonical']");
    if (!link) {
      link = this.document.createElement('link');
      link.rel = 'canonical';
      this.document.head.appendChild(link);
    }
    link.href = url;
  }

  private setImage(image: string | null | undefined): void {
    this.meta.removeTag("property='og:image'");
    this.meta.removeTag("name='twitter:image'");
    if (!image) return;
    this.meta.updateTag({ property: 'og:image', content: image });
    this.meta.updateTag({ name: 'twitter:image', content: image });
  }

  private setStructuredData(data: Record<string, unknown>): void {
    this.removeStructuredData();
    const script = this.document.createElement('script');
    script.id = 'structured-data';
    script.type = 'application/ld+json';
    script.text = JSON.stringify(data).replace(/</g, '\\u003c');
    this.document.head.appendChild(script);
  }

  private removeStructuredData(): void {
    this.document.getElementById('structured-data')?.remove();
  }
}

import { DOCUMENT } from '@angular/common';
import { inject, Injectable } from '@angular/core';
import { Meta, Title } from '@angular/platform-browser';
import { BlogDetail, GuideDetail } from '../models/models';

const SITE_NAME = 'ShebaPath';
const DEFAULT_DESCRIPTION =
  'Independent, easy-to-follow guides for common Bangladesh government services. Not an official government website.';

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

    const keywords = guide.keywords || guide.tags?.join(', ');
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

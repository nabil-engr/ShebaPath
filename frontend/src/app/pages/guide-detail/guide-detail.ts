import { Component, inject, OnInit, signal } from '@angular/core';
import { DatePipe, DOCUMENT } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { switchMap } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';
import { GuidesService } from '../../core/services/guides.service';
import { PdfExportService } from '../../core/services/pdf-export.service';
import { AuthService } from '../../core/services/auth.service';
import { BookmarkService } from '../../core/services/bookmark.service';
import { GuideDetail } from '../../core/models/models';
import { ShareButtonComponent } from '../../Shared/share-button/share-button';
import { TagChipsComponent } from '../../Shared/tag-chips/tag-chips';
import { TranslateSyncService } from '../../core/services/translate-sync.service';
import { GuideSummary } from '../../core/models/models';
import { SeoService } from '../../core/services/seo.service';

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

  get pageUrl(): string {
    return this.document.location.href;
  }

  ngOnInit(): void {
    this.route.paramMap
      .pipe(switchMap((params) => this.guidesService.get(params.get('slug')!)))
      .subscribe({
        next: (guide) => {
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

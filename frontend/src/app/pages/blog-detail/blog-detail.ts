import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { DatePipe, DOCUMENT } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { ShareButtonComponent } from '../../Shared/share-button/share-button';
import { TagChipsComponent } from '../../Shared/tag-chips/tag-chips';
import { switchMap } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';
import { BlogService } from '../../core/services/blog.service';
import { PdfExportService } from '../../core/services/pdf-export.service';
import { BlogDetail } from '../../core/models/models';
import { SeoService } from '../../core/services/seo.service';

@Component({
  selector: 'app-blog-detail',
  standalone: true,
  imports: [RouterLink, DatePipe, ShareButtonComponent, TagChipsComponent],
  templateUrl: './blog-detail.html',
  styleUrl: './blog-detail.scss',
})
export class BlogDetailPage implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly blogService = inject(BlogService);
  private readonly pdfExport = inject(PdfExportService);
  private readonly document = inject(DOCUMENT);
  private readonly seo = inject(SeoService);

  get pageUrl(): string {
    return this.document.location.href;
  }

  readonly post = signal<BlogDetail | null>(null);
  readonly notFound = signal(false);
  readonly loadError = signal(false);
  readonly loading = signal(true);

  readonly readingTime = computed(() => {
    const content = this.post()?.content ?? '';
    const words = content.trim().split(/\s+/).filter(Boolean).length;
    return Math.max(1, Math.round(words / 200));
  });

  ngOnInit(): void {
    this.route.paramMap
      .pipe(switchMap((params) => this.blogService.get(params.get('slug')!)))
      .subscribe({
        next: (post) => {
          this.post.set(post);
          this.loading.set(false);
          this.seo.applyBlog(post);
        },
        error: (error: HttpErrorResponse) => {
          const notFound = error.status === 404;
          this.notFound.set(notFound);
          this.loadError.set(!notFound);
          this.loading.set(false);
          this.seo.markUnavailable('Post', notFound);
        },
      });
  }

  reload(): void {
    this.document.location.reload();
  }

  downloadPdf(): void {
    if (typeof window !== 'undefined') {
      window.print();
    }
  }
}

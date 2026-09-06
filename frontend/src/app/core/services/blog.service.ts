import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { ApiBase } from './api-base';
import { BlogDetail, BlogSummary } from '../models/models';

function sanitizeText(str: string | null | undefined): string | null {
  if (!str) return str ?? null;
  return str
    .replace(/ó/g, '৳')
    .replace(/¬¾¯¼/g, '')
    .replace(/[¬®¯¿½¼]/g, '')
    .trim();
}

@Injectable({ providedIn: 'root' })
export class BlogService {
  private readonly http = inject(HttpClient);
  private readonly api = inject(ApiBase);

  list(): Observable<BlogSummary[]> {
    return this.http.get<BlogSummary[]>(this.api.endpoint('blog')).pipe(
      map(posts => posts.map(p => ({
        ...p,
        title: sanitizeText(p.title) ?? '',
        excerpt: sanitizeText(p.excerpt) ?? '',
      })))
    );
  }

  get(slug: string): Observable<BlogDetail> {
    return this.http.get<BlogDetail>(this.api.endpoint(`blog/${slug}`)).pipe(
      map(p => ({
        ...p,
        title: sanitizeText(p.title) ?? '',
        excerpt: sanitizeText(p.excerpt) ?? '',
        content: sanitizeText(p.content) ?? '',
      }))
    );
  }
}


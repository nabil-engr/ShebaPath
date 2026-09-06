import { HttpClient } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { ApiBase } from './api-base';
import { GuideDetail, GuideSummary } from '../models/models';

function sanitizeText(str: string | null | undefined): string | null {
  if (!str) return str ?? null;
  return str
    .replace(/ó/g, '৳')
    .replace(/¬¾¯¼/g, '')
    .replace(/[¬®¯¿½¼]/g, '')
    .trim();
}

function sanitizeArray(arr: string[] | null | undefined): string[] {
  if (!arr) return [];
  return arr.map(item => sanitizeText(item) ?? '');
}

@Injectable({ providedIn: 'root' })
export class GuidesService {
  private readonly http = inject(HttpClient);
  private readonly api = inject(ApiBase);

  list(): Observable<GuideSummary[]> {
    return this.http.get<GuideSummary[]>(this.api.endpoint('guides')).pipe(
      map(guides => guides.map(g => ({
        ...g,
        fees: sanitizeText(g.fees),
        summary: sanitizeText(g.summary) ?? '',
        processingTime: sanitizeText(g.processingTime),
        office: sanitizeText(g.office),
      })))
    );
  }

  get(slug: string): Observable<GuideDetail> {
    return this.http.get<GuideDetail>(this.api.endpoint(`guides/${slug}`)).pipe(
      map(g => ({
        ...g,
        fees: sanitizeText(g.fees),
        summary: sanitizeText(g.summary) ?? '',
        processingTime: sanitizeText(g.processingTime),
        office: sanitizeText(g.office),
        steps: sanitizeArray(g.steps),
        requirements: sanitizeArray(g.requirements),
      }))
    );
  }

  related(slug: string): Observable<GuideSummary[]> {
    return this.http.get<GuideSummary[]>(this.api.endpoint(`guides/${slug}/related`)).pipe(
      map(guides => guides.map(g => ({
        ...g,
        fees: sanitizeText(g.fees),
        summary: sanitizeText(g.summary) ?? '',
        processingTime: sanitizeText(g.processingTime),
        office: sanitizeText(g.office),
      })))
    );
  }
}

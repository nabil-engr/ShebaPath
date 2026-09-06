import { Injectable } from '@angular/core';
import type { jsPDF } from 'jspdf';
import { GuideDetail, BlogDetail } from '../models/models';

const BRAND_GREEN: [number, number, number] = [10, 107, 62];
const BRAND_DARK: [number, number, number] = [1, 50, 32];
const INK: [number, number, number] = [30, 33, 30];
const MUTED: [number, number, number] = [110, 116, 110];
const PAGE_WIDTH = 210;
const MARGIN = 18;
const CONTENT_WIDTH = PAGE_WIDTH - MARGIN * 2;

@Injectable({ providedIn: 'root' })
export class PdfExportService {
  async exportGuide(guide: GuideDetail): Promise<void> {
    if (typeof window !== 'undefined') {
      window.print();
    }
  }

  async exportBlogPost(post: BlogDetail): Promise<void> {
    return y + 8;
  }

  private drawParagraph(
    doc: jsPDF,
    text: string,
    y: number,
    opts?: { italic?: boolean; color?: [number, number, number] }
  ): number {
    doc.setFont('helvetica', opts?.italic ? 'italic' : 'normal');
    doc.setFontSize(10.5);
    doc.setTextColor(...(opts?.color ?? INK));
    const lines = doc.splitTextToSize(text, CONTENT_WIDTH);
    for (const line of lines) {
      y = this.ensureSpace(doc, y, 6);
      doc.text(line, MARGIN, y);
      y += 5.5;
    }
    return y;
  }

  private drawNumberedList(doc: jsPDF, items: string[], y: number): number {
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(10.5);
    doc.setTextColor(...INK);
    items.forEach((item, i) => {
      const marker = `${i + 1}.`;
      const lines = doc.splitTextToSize(item, CONTENT_WIDTH - 8);
      y = this.ensureSpace(doc, y, lines.length * 5.5 + 2);
      doc.setFont('helvetica', 'bold');
      doc.text(marker, MARGIN, y);
      doc.setFont('helvetica', 'normal');
      doc.text(lines, MARGIN + 7, y);
      y += lines.length * 5.5 + 2;
    });
    return y;
  }

  private drawBulletList(doc: jsPDF, items: string[], y: number): number {
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(10.5);
    doc.setTextColor(...INK);
    items.forEach((item) => {
      const lines = doc.splitTextToSize(item, CONTENT_WIDTH - 8);
      y = this.ensureSpace(doc, y, lines.length * 5.5 + 2);
      doc.setFillColor(...BRAND_GREEN);
      doc.circle(MARGIN + 1.5, y - 1.5, 1, 'F');
      doc.text(lines, MARGIN + 7, y);
      y += lines.length * 5.5 + 2;
    });
    return y;
  }

  private drawFactBox(doc: jsPDF, facts: [string, string | null][], y: number): number {
    const visible = facts.filter(([, v]) => !!v);
    if (visible.length === 0) return y;

    const rowHeight = 8;
    const boxHeight = visible.length * rowHeight + 6;
    y = this.ensureSpace(doc, y, boxHeight);

    doc.setFillColor(245, 248, 245);
    doc.roundedRect(MARGIN, y, CONTENT_WIDTH, boxHeight, 2, 2, 'F');

    let rowY = y + 8;
    for (const [label, value] of visible) {
      doc.setFont('helvetica', 'bold');
      doc.setFontSize(9.5);
      doc.setTextColor(...BRAND_GREEN);
      doc.text(label.toUpperCase(), MARGIN + 5, rowY);

      doc.setFont('helvetica', 'normal');
      doc.setFontSize(9.5);
      doc.setTextColor(...INK);
      const lines = doc.splitTextToSize(value ?? '', CONTENT_WIDTH - 55);
      doc.text(lines[0] ?? '', MARGIN + 48, rowY);
      rowY += rowHeight;
    }
    return y + boxHeight;
  }

  private drawFooter(doc: jsPDF): void {
    const pageCount = doc.getNumberOfPages();
    for (let i = 1; i <= pageCount; i++) {
      doc.setPage(i);
      doc.setDrawColor(...MUTED);
      doc.setLineWidth(0.2);
      doc.line(MARGIN, 285, PAGE_WIDTH - MARGIN, 285);
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(8);
      doc.setTextColor(...MUTED);
      doc.text(
        'ShebaPath is an independent guide, not an official government website. Always confirm with the relevant office.',
        MARGIN,
        290
      );
      doc.text(`Generated ${this.formatDate(new Date().toISOString())}`, PAGE_WIDTH - MARGIN, 290, {
        align: 'right',
      });
    }
  }

  private ensureSpace(doc: jsPDF, y: number, needed: number): number {
    if (y + needed > 278) {
      doc.addPage();
      return 20;
    }
    return y;
  }

  private formatDate(iso: string): string {
    return new Date(iso).toLocaleDateString('en-GB', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    });
  }
}

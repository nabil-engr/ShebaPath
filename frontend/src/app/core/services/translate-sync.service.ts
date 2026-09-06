import { Injectable } from '@angular/core';


/**
 * Google Translate only translates the DOM once, right after the page
 * loads. Any content that renders later (async API data, search-filtered
 * lists, etc.) gets added in plain English and never picked up. This
 * service nudges the hidden Google Translate <select> to re-run its pass
 * over the current DOM whenever we know new translatable content appeared.
 */

@Injectable({ providedIn: 'root'})
export class TranslateSyncService {
  resync(): void {
    const isBangla = document.cookie.includes('googtrans=/en/bn');
    if(!isBangla) return;

    const trigger = () => {
      const combo = document.querySelector<HTMLSelectElement>('select.goog-te-combo');
      if (combo) {
        combo.value = 'bn';
        combo.dispatchEvent(new Event('change'));
      }
    };

    // Trigger after Angular painted the template
    setTimeout(trigger, 100);
    setTimeout(trigger, 350);
  }
}

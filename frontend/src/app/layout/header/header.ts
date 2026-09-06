import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [RouterLink, RouterLinkActive],
  templateUrl: './header.html',
  styleUrl: './header.scss',
})
export class HeaderComponent {
  protected readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  protected get isBangla(): boolean {
    return document.cookie.includes('googtrans=/en/bn');
  }

  toogleLanguage(): void {
    if (this.isBangla) {
      // Clear across root, current subpath, and domain
      document.cookie = 'googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
      document.cookie = 'googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/bd-services;';
      document.cookie = 'googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/bd-services/;';
      document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/; domain=${window.location.hostname};`;
      document.cookie = 'googtrans=/en/en; path=/;';
      document.cookie = 'googtrans=/en/en; path=/bd-services/;';
    } else {
      document.cookie = 'googtrans=/en/bn; path=/;';
      document.cookie = 'googtrans=/en/bn; path=/bd-services/;';
    }
    window.location.reload();
  }


  logout(): void {
    this.auth.logout().subscribe(() => this.router.navigate(['/']));
  }
}

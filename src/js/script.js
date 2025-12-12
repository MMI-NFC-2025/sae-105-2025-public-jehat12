/* 
 * Festival Jumelages - Minimal Script
 * Fonctionnalités : Menu mobile, Filtres, Accordéons
 * Poids léger < 20kb
 */

document.addEventListener('DOMContentLoaded', () => {
    
    // --- Menu Mobile ---
    const burger = document.querySelector('.burger');
    const nav = document.querySelector('.nav-links');
    
    if (burger && nav) {
        burger.addEventListener('click', () => {
            nav.classList.toggle('active');
            burger.textContent = nav.classList.contains('active') ? '✕' : '☰';
            burger.setAttribute('aria-expanded', nav.classList.contains('active'));
        });
    }

    // --- Accordéons (FAQ) ---
    const accordions = document.querySelectorAll('.accordion-header');
    
    accordions.forEach(acc => {
        acc.addEventListener('click', () => {
            const item = acc.parentElement;
            const isActive = item.classList.contains('active');
            
            // Fermer tous les autres (optionnel, pour garder propre)
            document.querySelectorAll('.accordion-item').forEach(i => i.classList.remove('active'));

            if (!isActive) {
                item.classList.add('active');
            }
        });
    });

    // --- Filtres Programme ---
    const filterBtns = document.querySelectorAll('.filter-btn');
    const artistCards = document.querySelectorAll('.artist-card');

    if (filterBtns.length > 0) {
        filterBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                // Gestion de la classe active
                filterBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');

                const filterValue = btn.getAttribute('data-filter');

                artistCards.forEach(card => {
                    const day = card.getAttribute('data-day');
                    const scene = card.getAttribute('data-scene');
                    const genre = card.getAttribute('data-genre');

                    // Logique simple : si 'all' ou si une des data correspond
                    if (filterValue === 'all' || day === filterValue || scene === filterValue || genre === filterValue) {
                        card.style.display = 'block';
                        // Petite animation de réapparition
                        card.style.animation = 'fadeIn 0.5s ease';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
    }

    // --- Animation au scroll (Intersection Observer) ---
    const observerOptions = {
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-slide-up');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.card, .section-title, .hero-content').forEach(el => {
        el.style.opacity = '0'; // Initial state for JS users
        observer.observe(el);
    });
});

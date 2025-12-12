#!/bin/bash

# Script pour mettre à jour la barre de recherche sur toutes les pages

SEARCH_SNIPPET='<div class="logo">Jumelages</div>
        
        <!-- Bouton recherche -->
        <button class="search-icon" aria-label="Ouvrir la recherche" aria-expanded="false">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
            </svg>
        </button>
        
        <!-- Barre de recherche cachée -->
        <form class="search-bar" role="search">
            <input type="search" placeholder="Rechercher artiste, scène..." aria-label="Rechercher">
            <button type="button" class="search-close" aria-label="Fermer la recherche">✕</button>
        </form>'

for file in artistes.html scenes.html scene-detail.html programme.html a-propos.html infos.html contact.html artiste-*.html 404.html demo-effects.html; do
  if [ -f "$file" ]; then
    echo "Mise à jour de $file..."
    # Supprimer l'ancienne recherche
    sed -i '' '/<form class="search-bar"/,/<\/form>/d' "$file"
    # Remplacer le logo par logo + recherche
    sed -i '' "/<div class=\"logo\">Jumelages<\/div>/r /dev/stdin" "$file" <<< "$SEARCH_SNIPPET"
    sed -i '' '/<div class="logo">Jumelages<\/div>/d' "$file"
  fi
done

echo "✅ Mise à jour terminée!"

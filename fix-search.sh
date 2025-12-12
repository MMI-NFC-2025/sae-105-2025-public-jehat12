#!/bin/bash

cd /Users/jehatbakiray/Documents/GitHub/sae-105-2025-public-jehat12

for file in artistes.html scenes.html scene-detail.html programme.html a-propos.html infos.html contact.html artiste-*.html 404.html demo-effects.html; do
  if [ -f "$file" ]; then
    echo "Mise à jour: $file"
    
    # Copier depuis index.html le bon header
    # Supprimer l'ancien entre logo et burger, puis ajouter le nouveau
    sed -i '' '/<button class="search-/,/<\/button>/d' "$file"
    sed -i '' '/<form class="search-/,/<\/form>/d' "$file"
    sed -i '' '/<div class="search-/,/<\/div>/d' "$file"
    
    # Ajouter le bouton recherche après le logo
    sed -i '' 's|<div class="logo">Jumelages</div>|<div class="logo">Jumelages</div>\
        \
        <button class="search-toggle" aria-label="Rechercher" aria-expanded="false">\
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3">\
                <circle cx="11" cy="11" r="8"></circle>\
                <path d="m21 21-4.35-4.35"></path>\
            </svg>\
        </button>|' "$file"
    
    # Ajouter le dropdown après </header>
    if ! grep -q "search-dropdown" "$file"; then
      sed -i '' '/<\/header>/a\
    \
    <!-- Barre de recherche (cachée) -->\
    <div class="search-dropdown">\
        <input type="search" placeholder="Rechercher..." aria-label="Rechercher">\
    </div>
' "$file"
    fi
  fi
done

echo "✅ Terminé!"

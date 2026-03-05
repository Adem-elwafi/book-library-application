# 📚 Guide pour Ajouter des Livres à la Base de Données

## ✅ Solution Automatique (RECOMMANDÉ)

J'ai créé une classe `DataInitializer` qui ajoute automatiquement 10 livres au démarrage de l'application !

### Pour l'utiliser :

1. **Démarrez votre application depuis IntelliJ IDEA** :
   - Cliquez droit sur `BookLibraryApiApplication.java`
   - Sélectionnez "Run 'BookLibraryApiApplication'"
   
2. **Vérifiez la console** - vous devriez voir :
   ```
   🚀 Initialisation de la base de données avec des livres...
   ✅ 10 livres ajoutés avec succès!
   ```

3. **Testez l'API** :
   ```powershell
   # Voir tous les livres
   Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Get | Format-Table
   ```

## 🔧 Solutions Manuelles

### Option 1 : Script PowerShell Interactif

Utilisez le script `add-books.ps1` :

```powershell
.\add-books.ps1
```

Le script vous proposera :
1. Ajouter des livres exemples
2. Ajouter un livre personnalisé
3. Voir tous les livres
4. Tout faire (ajouter + voir)

### Option 2 : Commande PowerShell Simple

Pour ajouter UN livre :

```powershell
$book = @{
    title = "Le Petit Prince"
    author = "Antoine de Saint-Exupéry"
    isbn = "978-2070612758"
    publicationYear = 1943
    genre = "Fable"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Post -Body $book -ContentType "application/json; charset=utf-8"
```

### Option 3 : Curl (depuis Git Bash, PAS PowerShell)

⚠️ **IMPORTANT** : Le problème que vous aviez était l'encodage UTF-8 des caractères accentués dans curl depuis Git Bash.

Utilisez cette syntaxe SANS accents :

```bash
curl -X POST http://localhost:8081/api/books \
  -H "Content-Type: application/json" \
  -d '{"title": "Le Petit Prince", "author": "Antoine de Saint-Exupery", "isbn": "978-2070612758", "publicationYear": 1943, "genre": "Fable"}'
```

Ou avec des accents, utilisez l'option `--data-raw` :

```bash
curl -X POST http://localhost:8081/api/books \
  -H "Content-Type: application/json; charset=utf-8" \
  --data-raw '{"title": "Le Petit Prince", "author": "Antoine de Saint-Exupéry", "isbn": "978-2070612758", "publicationYear": 1943, "genre": "Fable"}'
```

## 📖 Commandes Utiles

### Voir tous les livres
```powershell
Invoke-RestMethod -Uri "http://localhost:8081/api/books" | Format-Table
```

### Chercher par titre
```powershell
Invoke-RestMethod -Uri "http://localhost:8081/api/books/search?title=Prince" | Format-Table
```

### Chercher par genre
```powershell
Invoke-RestMethod -Uri "http://localhost:8081/api/books/genre/Roman" | Format-Table
```

## 🐛 Le Problème que Vous Aviez

**Erreur** : `Invalid UTF-8 middle byte 0x72`

**Cause** : Git Bash (MINGW64) avec curl ne gère pas correctement l'encodage UTF-8 des caractères accentués français (é, è, à, etc.)

**Solutions** :
1. ✅ Utiliser PowerShell avec `Invoke-RestMethod` (recommandé pour Windows)
2. ✅ Utiliser le script `add-books.ps1` que j'ai créé
3. ✅ Utiliser la classe `DataInitializer` pour auto-remplir la base au démarrage
4. ⚠️ Éviter les accents dans curl depuis Git Bash, OU utiliser `--data-raw`

## 📁 Fichiers Créés

- `src/main/java/com/adem/book_library_api/config/DataInitializer.java` - Ajoute automatiquement 10 livres au démarrage
- `add-books.ps1` - Script PowerShell interactif pour ajouter des livres
- `books-data.json` - Données de test en JSON
- `GUIDE-AJOUT-LIVRES.md` - Ce guide

## 🎯 Recommandation

**Pour un développeur Laravel habitué aux seeders** : La classe `DataInitializer` est l'équivalent de vos seeders Laravel ! Elle s'exécute automatiquement au démarrage et remplit la base si elle est vide.

C'est la meilleure approche pour le développement. 🚀


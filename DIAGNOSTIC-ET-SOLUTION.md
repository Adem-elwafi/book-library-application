# 🔍 DIAGNOSTIC ET SOLUTION - Erreur 400 Bad Request

## 🐛 LE PROBLÈME

### Erreur rencontrée :
```
Invalid UTF-8 middle byte 0x72
```

### Commande qui échouait :
```bash
curl -X POST http://localhost:8081/api/books \
  -H "Content-Type: application/json" \
  -d '{"title": "Le Petit Prince", "author": "Antoine de Saint-Exupéry", ...}'
```

## 🎯 LA CAUSE

**Git Bash (MINGW64) + curl + caractères accentués = Problème d'encodage UTF-8**

Quand vous avez utilisé curl depuis Git Bash avec des caractères français accentués (é, è, à, ç), l'encodage UTF-8 n'a pas été correctement transmis à votre API Spring Boot.

Le byte `0x72` correspond au "r" dans "Exupéry", mais le byte précédent (l'accent é) était mal encodé.

### Pourquoi ça arrive ?

1. Git Bash utilise MINGW64 qui émule un environnement Unix sur Windows
2. L'encodage par défaut peut être différent (ISO-8859-1 ou autre)
3. Curl dans cet environnement ne force pas l'UTF-8
4. Spring Boot attend de l'UTF-8 valide pour le JSON

## ✅ LES SOLUTIONS

### Solution 1 : DataInitializer (AUTOMATIQUE) ⭐ RECOMMANDÉ

J'ai créé `DataInitializer.java` qui fonctionne comme un **seeder Laravel** :

```java
@Configuration
public class DataInitializer {
    @Bean
    CommandLineRunner initDatabase(BookRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                // Ajoute automatiquement 10 livres
                repository.save(new Book(...));
                // ...
            }
        };
    }
}
```

**Avantages** :
- ✅ Exécution automatique au démarrage
- ✅ Pas de problème d'encodage
- ✅ Idéal pour le développement
- ✅ Similaire aux seeders Laravel que vous connaissez

### Solution 2 : PowerShell avec Invoke-RestMethod

PowerShell gère parfaitement l'UTF-8 sur Windows :

```powershell
$livre = @{
    title = "Le Petit Prince"
    author = "Antoine de Saint-Exupéry"  # Les accents fonctionnent !
    isbn = "978-2070612758"
    publicationYear = 1943
    genre = "Fable"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/api/books" `
  -Method Post `
  -Body $livre `
  -ContentType "application/json; charset=utf-8"
```

**Avantages** :
- ✅ Gère parfaitement l'UTF-8
- ✅ Natif Windows
- ✅ Plus propre que curl

### Solution 3 : Script PowerShell (add-books.ps1)

J'ai créé un script interactif :

```powershell
.\add-books.ps1
```

**Avantages** :
- ✅ Menu interactif
- ✅ Ajoute plusieurs livres en une fois
- ✅ Affiche la liste après ajout

### Solution 4 : Curl avec --data-raw (si vous voulez absolument utiliser curl)

```bash
curl -X POST http://localhost:8081/api/books \
  -H "Content-Type: application/json; charset=utf-8" \
  --data-raw '{"title": "Le Petit Prince", "author": "Antoine de Saint-Exupéry", ...}'
```

L'option `--data-raw` préserve l'encodage.

## 📚 POUR UN DÉVELOPPEUR LARAVEL

### Comparaison Laravel ↔️ Spring Boot

| Laravel | Spring Boot |
|---------|------------|
| `php artisan migrate` | `spring.jpa.hibernate.ddl-auto=update` |
| `php artisan db:seed` | `CommandLineRunner` (DataInitializer) |
| `Route::post('/books')` | `@PostMapping` |
| `Book::create($request->all())` | `repository.save(book)` |
| Eloquent ORM | JPA/Hibernate |
| `composer require` | Maven `pom.xml` |

### Les équivalences :

```php
// Laravel Seeder
class BookSeeder extends Seeder {
    public function run() {
        Book::create(['title' => '...']);
    }
}
```

```java
// Spring Boot DataInitializer
@Bean
CommandLineRunner initDatabase(BookRepository repo) {
    return args -> {
        repo.save(new Book(...));
    };
}
```

## 🎓 CE QUE VOUS AVEZ APPRIS

1. **Encodage UTF-8** : Toujours important pour les APIs REST internationales
2. **PowerShell vs Bash** : Sur Windows, PowerShell gère mieux l'UTF-8
3. **DataInitializer** : L'équivalent Spring Boot des seeders Laravel
4. **Jackson** : La bibliothèque de désérialisation JSON de Spring Boot (équivalent de Symfony Serializer)
5. **Lombok** : Génère automatiquement getters/setters/constructeurs

## 🚀 PROCHAINES ÉTAPES

1. **Démarrez l'application depuis IntelliJ**
2. **Les 10 livres sont automatiquement ajoutés**
3. **Testez avec PowerShell** :
   ```powershell
   Invoke-RestMethod -Uri "http://localhost:8081/api/books" | Format-Table
   ```

## 📖 RESSOURCES UTILES

- `INSTRUCTIONS-RAPIDES.md` - Guide de démarrage rapide
- `GUIDE-AJOUT-LIVRES.md` - Guide complet avec toutes les options
- `add-books.ps1` - Script interactif PowerShell
- `books-data.json` - Données de test en JSON

---

**🎉 Problème résolu ! Votre API fonctionne, c'était juste un problème d'encodage avec curl depuis Git Bash.**


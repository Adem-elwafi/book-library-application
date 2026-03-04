# 📚 Book Library API - Spring Boot

## Le Problème et la Solution

### ❌ Le Problème Initial
**Erreur 400 Bad Request** lors de l'envoi de JSON avec `curl` depuis Git Bash/MINGW64.

### 🔍 Cause Racine
**Erreur d'encodage UTF-8**: `Invalid UTF-8 middle byte 0x72`
- Les caractères accentués (comme `é` dans "Saint-Exupéry") n'étaient pas correctement encodés
- Git Bash/MINGW64 utilise un encodage différent qui cause des problèmes avec `curl`

### ✅ Solutions Appliquées

#### 1. **Modifications du Code Java**

**Book.java** - 3 changements critiques:
```java
@Data                        // Au lieu de @Getter @Setter
@NoArgsConstructor          // Pour Jackson (désérialisation JSON)
@AllArgsConstructor
private Integer publicationYear;  // Integer au lieu de int (permet null)
```

**pom.xml** - Configuration Lombok:
```xml
<configuration>
    <excludes>
        <exclude>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </exclude>
    </excludes>
</configuration>
```

**application.properties** - Logs de débogage:
```properties
logging.level.org.springframework.web=DEBUG
server.error.include-message=always
server.error.include-stacktrace=always
```

#### 2. **Comment Tester l'API (Windows)**

##### Option 1: PowerShell (RECOMMANDÉ ✅)
```powershell
# GET tous les livres
Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Get

# POST un nouveau livre
$book = @{
    title = "1984"
    author = "George Orwell"
    isbn = "978-0451524935"
    publicationYear = 1949
    genre = "Dystopie"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Post -Body $book -ContentType "application/json; charset=utf-8"
```

##### Option 2: Script PowerShell Automatique
```powershell
.\test-api.ps1
```

##### Option 3: IntelliJ HTTP Client
Utilise le fichier `src/test_api.http` dans IntelliJ IDEA.

##### Option 4: Git Bash (avec fichier JSON)
```bash
# Éviter les accents dans les données JSON
curl -X POST http://localhost:8081/api/books \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @test-data.json
```

## 🚀 Démarrage Rapide

1. **Lancer l'application**:
   - Dans IntelliJ: Clic droit sur `BookLibraryApiApplication.java` → Run

2. **Tester l'API**:
   ```powershell
   .\test-api.ps1
   ```

3. **Accéder à la console H2** (base de données):
   - URL: http://localhost:8081/h2-console
   - JDBC URL: `jdbc:h2:mem:bookdb`
   - Username: `sa`
   - Password: (laisser vide)

## 📊 Endpoints API

| Méthode | URL | Description |
|---------|-----|-------------|
| GET | `/api/books` | Récupérer tous les livres |
| POST | `/api/books` | Créer un nouveau livre |

### Exemple de JSON pour POST:
```json
{
  "title": "Le Petit Prince",
  "author": "Antoine de Saint-Exupery",
  "isbn": "123456",
  "publicationYear": 1943,
  "genre": "Fable"
}
```

## 🎓 Différences Laravel vs Spring Boot

| Aspect | Laravel (PHP) | Spring Boot (Java) |
|--------|--------------|-------------------|
| **Désérialisation JSON** | Automatique avec Eloquent | Jackson (nécessite constructeur sans argument) |
| **Types nullables** | Natif en PHP | Utiliser `Integer` au lieu de `int` |
| **Encodage UTF-8** | Géré automatiquement | Doit être spécifié dans Content-Type |
| **Annotations** | Pas d'annotations | `@Entity`, `@RestController`, `@Service` |
| **Injection de dépendances** | Constructeur ou propriétés | Injection par constructeur (recommandé) |

## 🛠️ Technologies Utilisées

- **Spring Boot 3.5.11**
- **Java 21**
- **H2 Database** (base de données en mémoire)
- **Lombok** (réduction du code boilerplate)
- **Jackson** (sérialisation/désérialisation JSON)
- **Spring Data JPA** (ORM)

## 📝 Notes Importantes

1. ⚠️ **Éviter Git Bash pour tester les API avec accents** → Utiliser PowerShell
2. ✅ **Toujours spécifier `charset=utf-8`** dans le Content-Type
3. 🔧 **Lombok nécessite le plugin IntelliJ** (normalement déjà installé)
4. 💡 **H2 Database est en mémoire** → Les données sont perdues au redémarrage

## 🐛 Debugging

Si tu as des erreurs, vérifie les logs dans la console IntelliJ. Les logs détaillés sont activés pour t'aider à déboguer.

---

Créé par Adem - Projet d'apprentissage Spring Boot 🚀


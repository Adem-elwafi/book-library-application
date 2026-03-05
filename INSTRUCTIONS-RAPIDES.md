# 🚀 Instructions Rapides pour Ajouter des Livres

## ÉTAPE 1 : Démarrez l'application depuis IntelliJ IDEA

1. Ouvrez le projet dans IntelliJ IDEA
2. Trouvez `BookLibraryApiApplication.java`
3. Cliquez sur le bouton ▶️ Run (bouton vert) à côté de la classe
4. Attendez que le serveur démarre (vous verrez "Started BookLibraryApiApplication")

## ÉTAPE 2 : Les livres sont AUTOMATIQUEMENT ajoutés ! ✨

Grâce à la classe `DataInitializer.java` que j'ai créée, **10 livres sont automatiquement ajoutés** au démarrage !

Dans la console IntelliJ, vous verrez :
```
🚀 Initialisation de la base de données avec des livres...
✅ 10 livres ajoutés avec succès!
```

## ÉTAPE 3 : Vérifiez que ça fonctionne

Ouvrez PowerShell et tapez :

```powershell
# Voir tous les livres
Invoke-RestMethod -Uri "http://localhost:8081/api/books" | Format-Table

# OU pour un affichage plus joli
Invoke-RestMethod -Uri "http://localhost:8081/api/books" | Format-Table -Property id, title, author, publicationYear, genre
```

## 📝 Pour Ajouter MANUELLEMENT un Livre

Si vous voulez ajouter un livre en plus, utilisez cette commande PowerShell :

```powershell
$livre = @{
    title = "Votre Titre"
    author = "Nom Auteur"
    isbn = "978-1234567890"
    publicationYear = 2024
    genre = "Genre"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Post -Body $livre -ContentType "application/json; charset=utf-8"
```

## 🎯 EXEMPLE COMPLET

```powershell
# Ajouter "Notre-Dame de Paris"
$livre = @{
    title = "Notre-Dame de Paris"
    author = "Victor Hugo"
    isbn = "978-2253002864"
    publicationYear = 1831
    genre = "Roman"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8081/api/books" -Method Post -Body $livre -ContentType "application/json; charset=utf-8"

# Voir le résultat
Invoke-RestMethod -Uri "http://localhost:8081/api/books" | Format-Table
```

## 🐛 LE PROBLÈME QUE VOUS AVIEZ

**Erreur** : `Invalid UTF-8 middle byte 0x72`

**Cause** : Vous utilisiez `curl` depuis Git Bash qui ne gère pas bien les accents français (é, è, à)

**Solution** : Utilisez PowerShell avec `Invoke-RestMethod` qui gère parfaitement l'UTF-8 ! ✅

## OU utilisez le script automatique :

```powershell
.\add-books.ps1
```

---

**🎉 C'EST TOUT ! Démarrez juste l'application depuis IntelliJ et les livres seront là !**


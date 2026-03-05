# Script PowerShell pour ajouter des livres à l'API
# Utilisation du bon encodage pour les caractères français

Write-Host "📚 Script d'ajout de livres à l'API Book Library" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:8081/api/books"

# Fonction pour ajouter un livre
function Add-Book {
    param (
        [string]$Title,
        [string]$Author,
        [string]$Isbn,
        [int]$PublicationYear,
        [string]$Genre
    )

    $body = @{
        title = $Title
        author = $Author
        isbn = $Isbn
        publicationYear = $PublicationYear
        genre = $Genre
    } | ConvertTo-Json -Compress

    try {
        $response = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $body -ContentType "application/json; charset=utf-8"
        Write-Host "✅ Livre ajouté: $Title" -ForegroundColor Green
        return $response
    }
    catch {
        Write-Host "❌ Erreur lors de l'ajout de '$Title': $_" -ForegroundColor Red
        return $null
    }
}

# Fonction pour lister tous les livres
function Get-AllBooks {
    try {
        $response = Invoke-RestMethod -Uri $baseUrl -Method Get
        Write-Host "📖 Liste des livres dans la base:" -ForegroundColor Yellow
        $response | Format-Table -Property id, title, author, publicationYear, genre -AutoSize
        Write-Host "Total: $($response.Count) livre(s)" -ForegroundColor Yellow
    }
    catch {
        Write-Host "❌ Erreur lors de la récupération des livres: $_" -ForegroundColor Red
    }
}

# Menu interactif
Write-Host "Que voulez-vous faire?" -ForegroundColor Yellow
Write-Host "1. Ajouter des livres exemples"
Write-Host "2. Ajouter un livre personnalisé"
Write-Host "3. Voir tous les livres"
Write-Host "4. Tout faire (ajouter exemples + voir la liste)"
Write-Host ""

$choice = Read-Host "Votre choix (1-4)"

switch ($choice) {
    "1" {
        Write-Host "`nAjout de livres exemples..." -ForegroundColor Cyan

        Add-Book -Title "Le Petit Prince" -Author "Antoine de Saint-Exupéry" -Isbn "978-2070612758" -PublicationYear 1943 -Genre "Fable"
        Add-Book -Title "Notre-Dame de Paris" -Author "Victor Hugo" -Isbn "978-2253002864" -PublicationYear 1831 -Genre "Roman"
        Add-Book -Title "Les Trois Mousquetaires" -Author "Alexandre Dumas" -Isbn "978-2253098805" -PublicationYear 1844 -Genre "Aventure"
        Add-Book -Title "Le Rouge et le Noir" -Author "Stendhal" -Isbn "978-2253098201" -PublicationYear 1830 -Genre "Roman"
        Add-Book -Title "Madame Bovary" -Author "Gustave Flaubert" -Isbn "978-2253096337" -PublicationYear 1857 -Genre "Roman"

        Write-Host "`n✨ Ajout terminé!" -ForegroundColor Green
    }
    "2" {
        Write-Host "`nAjout d'un livre personnalisé" -ForegroundColor Cyan
        $title = Read-Host "Titre"
        $author = Read-Host "Auteur"
        $isbn = Read-Host "ISBN"
        $year = [int](Read-Host "Année de publication")
        $genre = Read-Host "Genre"

        Add-Book -Title $title -Author $author -Isbn $isbn -PublicationYear $year -Genre $genre
    }
    "3" {
        Get-AllBooks
    }
    "4" {
        Write-Host "`nAjout de livres exemples..." -ForegroundColor Cyan

        Add-Book -Title "Le Petit Prince" -Author "Antoine de Saint-Exupéry" -Isbn "978-2070612758" -PublicationYear 1943 -Genre "Fable"
        Add-Book -Title "Notre-Dame de Paris" -Author "Victor Hugo" -Isbn "978-2253002864" -PublicationYear 1831 -Genre "Roman"
        Add-Book -Title "Les Trois Mousquetaires" -Author "Alexandre Dumas" -Isbn "978-2253098805" -PublicationYear 1844 -Genre "Aventure"

        Write-Host ""
        Get-AllBooks
    }
    default {
        Write-Host "Choix invalide!" -ForegroundColor Red
    }
}

Write-Host "`n✨ Script terminé!" -ForegroundColor Cyan


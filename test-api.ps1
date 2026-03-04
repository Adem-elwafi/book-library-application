# Script PowerShell pour tester l'API Book Library
# Usage: .\test-api.ps1

$baseUrl = "http://localhost:8081/api/books"

Write-Host "=== Test de l'API Book Library ===" -ForegroundColor Cyan

# Test 1: GET tous les livres
Write-Host "`n1. GET /api/books - Recuperer tous les livres" -ForegroundColor Yellow
try {
    $books = Invoke-RestMethod -Uri $baseUrl -Method Get
    $books | Format-Table -AutoSize
    Write-Host "Success!" -ForegroundColor Green
} catch {
    Write-Host "Erreur: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: POST un nouveau livre
Write-Host "`n2. POST /api/books - Creer un nouveau livre" -ForegroundColor Yellow
$newBook = @{
    title = "1984"
    author = "George Orwell"
    isbn = "978-0451524935"
    publicationYear = 1949
    genre = "Dystopie"
} | ConvertTo-Json

try {
    $created = Invoke-RestMethod -Uri $baseUrl -Method Post -Body $newBook -ContentType "application/json; charset=utf-8"
    Write-Host "Livre cree avec ID: $($created.id)" -ForegroundColor Green
    $created | Format-List
} catch {
    Write-Host "Erreur: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 3: GET tous les livres apres ajout
Write-Host "`n3. GET /api/books - Verifier tous les livres" -ForegroundColor Yellow
try {
    $allBooks = Invoke-RestMethod -Uri $baseUrl -Method Get
    Write-Host "Nombre total de livres: $($allBooks.Count)" -ForegroundColor Green
    $allBooks | Format-Table -AutoSize
} catch {
    Write-Host "Erreur: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n=== Tests termines ===" -ForegroundColor Cyan


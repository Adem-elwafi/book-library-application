package com.adem.book_library_api.config;

import com.adem.book_library_api.model.Book;
import com.adem.book_library_api.repository.BookRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initDatabase(BookRepository repository) {
        return args -> {
            // Vérifier si la base est vide
            if (repository.count() == 0) {
                System.out.println("🚀 Initialisation de la base de données avec des livres...");

                repository.save(new Book(null, "Le Petit Prince", "Antoine de Saint-Exupéry", "978-2070612758", 1943, "Fable"));
                repository.save(new Book(null, "1984", "George Orwell", "978-0451524935", 1949, "Science Fiction"));
                repository.save(new Book(null, "L'Étranger", "Albert Camus", "978-2070360024", 1942, "Roman"));
                repository.save(new Book(null, "Harry Potter à l'école des sorciers", "J.K. Rowling", "978-2070584628", 1997, "Fantasy"));
                repository.save(new Book(null, "Le Seigneur des Anneaux", "J.R.R. Tolkien", "978-2266154345", 1954, "Fantasy"));
                repository.save(new Book(null, "Les Misérables", "Victor Hugo", "978-2253096337", 1862, "Roman"));
                repository.save(new Book(null, "Voyage au centre de la Terre", "Jules Verne", "978-2253006329", 1864, "Science Fiction"));
                repository.save(new Book(null, "Le Comte de Monte-Cristo", "Alexandre Dumas", "978-2253098805", 1844, "Roman"));
                repository.save(new Book(null, "Candide", "Voltaire", "978-2253003656", 1759, "Conte philosophique"));
                repository.save(new Book(null, "Germinal", "Émile Zola", "978-2253004226", 1885, "Roman"));

                System.out.println("✅ " + repository.count() + " livres ajoutés avec succès!");
            } else {
                System.out.println("ℹ️ La base contient déjà " + repository.count() + " livre(s)");
            }
        };
    }
}


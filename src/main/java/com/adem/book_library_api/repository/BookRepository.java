package com.adem.book_library_api.repository;

import com.adem.book_library_api.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    // Magie : Spring va implémenter les méthodes Save, FindAll, Delete automatiquement
}

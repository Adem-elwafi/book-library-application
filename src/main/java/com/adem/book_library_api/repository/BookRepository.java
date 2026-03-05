package com.adem.book_library_api.repository;

import com.adem.book_library_api.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List ;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    // Spring génère : SELECT * FROM book WHERE title LIKE %...%
    List<Book> findByTitleContainingIgnoreCase(String title);

    // Spring génère : SELECT * FROM book WHERE genre = ...
    List<Book> findByGenre(String genre);
}

package com.adem.book_library_api.service;

import com.adem.book_library_api.exception.ResourceNotFoundException;
import com.adem.book_library_api.model.Book;
import com.adem.book_library_api.repository.BookRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BookService {

    private final BookRepository bookRepository;

    // Injection par constructeur
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }
    public Book findById(Long id) {
        return bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Livre non trouvé avec l'id : " + id));
    }
    public List<Book> searchBooks(String title){
        return bookRepository.findByTitleContainingIgnoreCase(title);
    }
    public List<Book> getByGenre(String genre){
        return bookRepository.findByGenre(genre);
    }
    public List<Book> findAll() {
        return bookRepository.findAll(org.springframework.data.domain.Sort.by("title").ascending());
    }

    public Book updateBook(Long id, Book bookDetails) {
        // 1. On récupère le livre existant ou on jette une exception
        Book existingBook = findById(id);

        existingBook.setTitle(bookDetails.getTitle());
        existingBook.setAuthor(bookDetails.getAuthor());
        existingBook.setIsbn(bookDetails.getIsbn());
        existingBook.setPublicationYear(bookDetails.getPublicationYear());
        existingBook.setGenre(bookDetails.getGenre());

        // 3. On sauvegarde
        return bookRepository.save(existingBook);
    }
    public Book save(Book book) {
        return bookRepository.save(book);
    }
}
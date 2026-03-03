package com.adem.book_library_api.controller;

import com.adem.book_library_api.model.Book;
import com.adem.book_library_api.repository.BookRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookRepository bookRepository;

    // Injection par constructeur (L'équivalent du typage dans le constructeur Laravel)
    public BookController(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @GetMapping
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }
    @PostMapping
    public Book createBook(@RequestBody Book  book ){
        return bookRepository.save(book);
    }
}
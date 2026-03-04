package com.adem.book_library_api.controller;

import com.adem.book_library_api.model.Book;
import com.adem.book_library_api.service.BookService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public List<Book> getAll() {
        return bookService.findAll();
    }

    @PostMapping
    public Book create(@RequestBody Book book) {
        return bookService.save(book);
    }
}
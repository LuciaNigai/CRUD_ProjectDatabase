USE unifun_project;

DROP PROCEDURE IF EXISTS getBooks;
delimiter //

CREATE PROCEDURE getBooks()
begin
# fetting all books data from the database
select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
from books
left join authors using(author_id)
left join publishers using(publisher_id)
left join books_genres using(book_id)
left join genres using(genre_id)
group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;

end//
delimiter ;




USE unifun_project;

DROP PROCEDURE IF EXISTS getBook;
delimiter //

CREATE PROCEDURE getBook(in bookName varchar(250), in authorName varchar(250))
begin
# get the defined book
select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
from books
left join authors using(author_id)
left join publishers using(publisher_id)
left join books_genres using(book_id)
left join genres using(genre_id)
where books.book_name=bookName and books.author_id=(select author_id from authors where author=authorName)
group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;

end//
delimiter ;




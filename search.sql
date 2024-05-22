USE unifun_project;

DROP PROCEDURE IF EXISTS search;
delimiter //
# deprecated
# search at first was implemented through mysql, but later changed to work with session data 
CREATE PROCEDURE search(in p_search varchar(300),in p_option varchar(300))
begin 
set p_search=trim(p_search);
if p_option="book" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where books.book_name like concat('%', p_search, '%')
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
elseif p_option="author" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where authors.author like concat('%', p_search, '%')
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
elseif p_option="publisher" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where publishers.publisher like concat('%', p_search, '%')
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
elseif p_option="year" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where books.published=p_search
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
elseif p_option="genre" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where genres.genre like concat('%', p_search, '%')
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
elseif p_option="isbn" then
	select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
	from books
	left join authors using(author_id)
	left join publishers using(publisher_id)
	left join books_genres using(book_id)
	left join genres using(genre_id)
    where books.isbn=p_search
	group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;
end if;

end//
delimiter ;

-- call search("Gothic fiction","genre");

USE unifun_project;
DROP PROCEDURE if EXISTS addBook;

delimiter //
CREATE PROCEDURE addBook(in bookName varchar(255), 
in authorName varchar(255), 
in publisherName varchar(255),
in publishedYear varchar(4),
in genreNames varchar(500),
in isbnCode varchar(13)
)

BEGIN
# creating variables to temporary store the id's
declare v_book_id int;
declare v_publisher_id int;
declare v_author_id int;
declare v_genre_id int;


select book_id into v_book_id from books where books.book_name=bookName and author_id=
		(select author_id from authors where author=authorName) and publisher_id=(select publisher_id from publishers where publisher=publisherName) and published=publishedYear and isbn=isbnCode; 
if v_book_id is null then -- if book does not exist
	# inserting new book
	if (select  count(*) from books where isbn=isbnCode)=0 -- check if the book with that isbn already exists
    then
		select author_id into v_author_id from authors where author=authorName;
		if v_author_id is null then -- if author does not exist add new author 
			insert into authors (author) values(authorName);
			set v_author_id=last_insert_id();
		end if;
		select publisher_id into v_publisher_id from publishers where publisher=publisherName;
        if v_publisher_id is null then -- if publisher does not exist add new publisher
			insert into publishers(publisher) values(publisherName);
			set v_publisher_id=last_insert_id();
		end if;
     insert into books(isbn, book_name, author_id, publisher_id, published) -- adding new boook
     values(isbnCode, bookName, v_author_id, v_publisher_id, publishedYear);
     set v_book_id = last_insert_id();
	else -- if the book with that isbn already exists throw an error
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Book with that isbn already exists.';
    end if;
	# inserting genres and (book_genre) if needed 
	set @v_genres = genreNames;
	repeat  -- to get each genre separate
		set v_genre_id=null;
		set @delimiter_position = locate(',',@v_genres);
		IF @delimiter_position > 0 THEN 
		SET @v_genre = TRIM(SUBSTRING(@v_genres, 1, @delimiter_position - 1));
		SET @v_genres = TRIM(SUBSTRING(@v_genres, @delimiter_position + 1));
		ELSE
			SET @v_genre = TRIM(@v_genres);
			SET @v_genres = '';
		END IF;
        select genre_id into v_genre_id from genres where genre=@v_genre;
        if v_genre_id is null then -- if that genre doesn't already exist add new genre
			insert into genres(genre) values(@v_genre);
            set v_genre_id=last_insert_id();
			insert into books_genres values (v_book_id, v_genre_id); -- add that genre to the book
		ELSE -- else if it already exists add that genre to the book
			insert into books_genres values (v_book_id, v_genre_id);
        end if;
            
	until LENGTH(@v_genres)=0 end repeat;
    
else -- if boook already exists  
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Book already exists.';
end if;

END//
delimiter ;

 call addBook('The selfish giant','Oscar Wilde','Penguin','1998','Gothic Fiction,Pholosophical Fiction','9780141190004');
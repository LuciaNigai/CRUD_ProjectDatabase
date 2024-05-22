use unifun_project;
DROP PROCEDURE IF EXISTS editBook;
DELIMITER //
CREATE PROCEDURE editBook(in bookName varchar(255), 
in authorName varchar(255), 
in publisherName varchar(255),
in publishedYear varchar(4),
in genreNames varchar(500),
in isbnCode varchar(13),
in bookNameAfter varchar(255), 
in authorNameAfter varchar(255), 
in publisherNameAfter varchar(255),
in publishedYearAfter varchar(4),
in genreNamesAfter varchar(500),
in isbnCodeAfter varchar(13)
)
BEGIN
# declaring temp variables to store data
declare v_book_id int;
declare v_author_id int;
declare v_publisher_id int;
declare v_genre_id int;
declare v_new_genre int;

# updating book name
select book_id into v_book_id from books where book_name=bookName and author_id=(select author_id from authors where author=authorName);
select v_book_id;
if (bookName<>bookNameAfter) then
	update books
	set book_name=bookNameAfter
	where book_id=v_book_id;
end if;

# updating author name 
select author_id into v_author_id from authors where author=authorName;
select v_author_id;
if(authorName<>authorNameAfter) then
	update authors
    set author=authorNameAfter
    where author_id = v_author_id;
end if;

# updating publisher name
select publisher_id into v_publisher_id from publishers where publisher=publisherName;
select v_publisher_id;
if(publisherName<>publisherNameAfter) then
	update publishers
    set publisher=publisherNameAfter
    where publisher_id=v_publisher_id;
end if;

# updating published year
if(publishedYear<>publishedYearAfter) then
	update books
	set published=publishedYearAfter
	where book_id=v_book_id;
end if;

# updating genre names
	set @v_genres = genreNames;
    set @v_genres_after = genreNamesAfter;
	repeat
    # selecting genre from the string before
		set v_genre_id=null;
		set @delimiter_position = locate(',',@v_genres);
        IF @delimiter_position > 0 THEN 
		SET @v_genre = TRIM(SUBSTRING(@v_genres, 1, @delimiter_position - 1));
		SET @v_genres = TRIM(SUBSTRING(@v_genres, @delimiter_position + 1));
		ELSE
			SET @v_genre = TRIM(@v_genres);
			SET @v_genres = '';
		END IF;
	# selecting genre from string after
        set @delimiter_position_after = locate(',',@v_genres_after);
		IF @delimiter_position_after > 0 THEN 
			SET @v_genre_after = TRIM(SUBSTRING(@v_genres_after, 1, @delimiter_position_after - 1));
			SET @v_genres_after = TRIM(SUBSTRING(@v_genres_after, @delimiter_position_after + 1));
		ELSE
			SET @v_genre_after = TRIM(@v_genres_after);
			SET @v_genres_after = '';
		END IF;
       -- Select id of existing genre
	select genre_id into v_genre_id from genres where genre=@v_genre;
	if @v_genre<>@v_genre_after then -- if the genres are not equal
		if v_genre_id is null then -- if the book has empty genre
			if exists(select * from genres where genre=@v_genre_after) then -- if that new genre already exists add that genre to that book
				select genre_id into v_new_genre from genres where genre=@v_genre_after;
				if not exists(select * from books_genres where book_id=v_book_id and genre_id=v_new_genre) then 
					insert into books_genres
					values (v_book_id, v_new_genre);
                end if;
			ELSE	-- else if that genre does not exist insert into genres new genre and add that genre to the book
				insert into genres(genre)
				values (@v_genre_after);
                set v_new_genre=last_insert_id();
                insert into books_genres
                values (v_book_id, v_new_genre);
		end if;
		elseif (length(@v_genre_after))=0 then -- if the new genre is empty delete the genre from the book 
            delete from books_genres
            where genre_id=v_genre_id and book_id=v_book_id;
            if not exists (select * from books_genres where genre_id = v_genre_id) then -- if that genre does not belong to any other book delete it
				delete from genres 
                where genre_id=v_genre_id;
            end if;
		else
        if exists(select * from genres where genre=@v_genre_after) then -- if that new genre already exists chnage the current genre of that book
				select genre_id into v_new_genre from genres where genre=@v_genre_after;
                if not exists(select * from books_genres where book_id=v_book_id and genre_id=v_new_genre) then
					update books_genres
					set genre_id= v_new_genre
					where genre_id=v_genre_id and book_id=v_book_id;
                end if;
				if not exists (select * from books_genres where genre_id = v_genre_id) then -- if previous genre does not belong to any other book delete it
					delete from genres 
					where genre_id=v_genre_id;
				end if;
			else -- else if that genre does not exist insert into genres new genre and chnage the current genre of that book
				insert into genres(genre)
				values (@v_genre_after);
                set v_new_genre=last_insert_id();
                update books_genres
                set genre_id= v_new_genre
                where genre_id=v_genre_id and book_id=v_book_id;
				if not exists (select * from books_genres where genre_id = v_genre_id) then -- if previous genre does not belong to any other book delete it
					delete from genres 
					where genre_id=v_genre_id;
				end if;
			end if;
        end if;
end if;

            
	UNTIL LENGTH(@v_genres) = 0 AND LENGTH(@v_genres_after) = 0 END REPEAT;

-- updating isbnCode
if(isbnCode<>isbnCodeAfter) then
	if (select count(*) from books where isbn=isbnCodeAfter)=0
    then
		update books
		set isbn=isbnCodeAfter
		where book_id=v_book_id;
	else
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Book with that isbn already exists.';
    end if;
end if;

END //
DELIMITER ;
 -- call editBook('The selfish giant','Oscar Wilde','Penguin','1999','Science Fiction,Philosophical Fiction','9780141192642','The selfish giant','Oscar Wilde','Penguin','2001','Science Fiction,Science fiction','9780141192344');
use unifun_project;

DROP PROCEDURE IF EXISTS deleteBook;

delimiter //
create procedure deleteBook(in bookName varchar(250), in authorName varchar(250))
begin
# creating variables to store temp values
declare v_book_id int;
declare v_genre_id int;
declare v_author_id int;

select book_id into v_book_id from books where book_name=bookName and author_id=
						(select author_id from authors where author=authorName);
if v_book_id is not null then -- checking if that book really exists
# selecting all genres that belong to that book and concatenating them into one string
	set @v_genres = '';
	select GROUP_CONCAT(genres.genre separator ',') 
    into @v_genres
    from genres 
    left join books_genres using(genre_id) 
    where book_id=(select book_id from books where book_name=bookName);

# deleting the book  (genres from that book are also delted)
	delete from books where book_id=v_book_id;
    
    # deleting the author if he doesn't have more books
	IF (SELECT COUNT(*) FROM books WHERE author_id = (SELECT author_id FROM authors WHERE author = authorName)) = 0 THEN
    select author_id into v_author_id from authors where author=authorName;
    DELETE FROM authors WHERE author_id=v_author_id;
	END IF;
    
    # checking each genre from that book if there aren't books with that genre we delete it
    repeat 
    set v_genre_id=null;
		set @delimiter_position = locate(',',@v_genres);
        if @delimiter_position>0 then 
			set @v_genre = substring(@v_genres,1,@delimiter_position-1);
            set @v_genres = substring(@v_genres, @delimiter_position+1);
		else
			set @v_genre=@v_genres;
            set @v_genres='';
		end if;
        IF (SELECT COUNT(*) FROM books_genres WHERE genre_id = (SELECT genre_id FROM genres WHERE genre = @v_genre)) = 0 THEN -- if there are no books with that genre delete it
        SELECT genre_id INTO v_genre_id FROM genres WHERE genre = @v_genre;
        DELETE FROM genres WHERE genre_id = v_genre_id; 
    END IF;
    until LENGTH(@v_genres)=0 end repeat;
else -- if the book doesn't exist throw an error message
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Book you are trying to delete does not exist.';
end if;

end//
delimiter ;

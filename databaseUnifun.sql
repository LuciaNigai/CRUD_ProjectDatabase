CREATE DATABASE  IF NOT EXISTS `unifun_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `unifun_project`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: unifun_project
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `author` varchar(255) NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(13) DEFAULT NULL,
  `book_name` varchar(255) NOT NULL,
  `author_id` int DEFAULT NULL,
  `publisher_id` int DEFAULT NULL,
  `published` smallint NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `author_id` (`author_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_genres` (
  `book_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `books_genres_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `books_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_genres`
--

LOCK TABLES `books_genres` WRITE;
/*!40000 ALTER TABLE `books_genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `books_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher` varchar(255) NOT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'unifun_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `addBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBook`(in bookName varchar(255), 
in authorName varchar(255), 
in publisherName varchar(255),
in publishedYear varchar(4),
in genreNames varchar(500),
in isbnCode varchar(13)
)
BEGIN

declare v_book_id int;
declare v_publisher_id int;
declare v_author_id int;
declare v_genre_id int;


select book_id into v_book_id from books where books.book_name=bookName and author_id=
		(select author_id from authors where author=authorName); 
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteAllBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAllBooks`()
BEGIN
# delete all books and reset the id's to start again from 1
delete from books where book_id>0;
delete from authors where author_id>0;
delete from genres where genre_id>0;
delete from publishers where publisher_id>0;

ALTER table books AUTO_INCREMENT=1;
alter table authors AUTO_INCREMENT=1;
ALTER TABLE genres AUTO_INCREMENT=1;
alter table publishers AUTO_INCREMENT=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBook`(in bookName varchar(250), in authorName varchar(250))
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `editBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editBook`(in bookName varchar(255), 
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBook` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBook`(in bookName varchar(250), in authorName varchar(250))
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getBooks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBooks`()
begin
# fetting all books data from the database
select books.book_name, authors.author, publishers.publisher,books.published as 'year', GROUP_CONCAT(genre) as 'genres',books.isbn
from books
left join authors using(author_id)
left join publishers using(publisher_id)
left join books_genres using(book_id)
left join genres using(genre_id)
group by books.book_name, authors.author, publishers.publisher, books.isbn, books.published, year;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `search`(in p_search varchar(300),in p_option varchar(300))
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 11:27:45

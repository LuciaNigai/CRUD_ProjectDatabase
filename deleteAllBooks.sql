use unifun_project;

DROP PROCEDURE if EXISTS deleteAllBooks;
DELIMITER //
CREATE PROCEDURE deleteAllBooks()
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

END //
DELIMITER ;

CALL deleteAllBooks;

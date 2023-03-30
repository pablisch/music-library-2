TRUNCATE TABLE albums, artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Future Days', '1974', 1), ('Forever', '1976', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Tell Her', '1969', 2);



INSERT INTO artists (name, genre) VALUES ('Pixies', 'Indie');
INSERT INTO artists (name, genre) VALUES ('CAN', 'Krautrock');
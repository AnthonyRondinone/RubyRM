CREATE TABLE paintings (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  artist_id INTEGER,

  FOREIGN KEY(artist_id) REFERENCES artist(id)
);

CREATE TABLE artists (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  gallery_id INTEGER,

  FOREIGN KEY(gallery_id) REFERENCES human(id)
);

CREATE TABLE galleries (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  galleries (id, address)
VALUES
  (1, "1071 5th Ave"), (2, "100 Washington Square");

INSERT INTO
  artists (id, fname, lname, gallery_id)
VALUES
  (1, "Salvador", "Dali", 1),
  (2, "Pablo", "Picasso", 1),
  (3, "Claude", "Monet", 2),
  (4, "Anthony", "Rondinone", 2);

INSERT INTO
  paintings (id, title, artist_id)
VALUES
  (1, "Time", 1),
  (2, "The Pond", 2),
  (3, "Little Girl", 3),
  (4, "The Wait", 3),
  (5, "Stray Cat", 4);

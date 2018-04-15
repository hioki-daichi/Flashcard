CREATE TABLE health
  (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    time DATETIME NOT NULL
  );

INSERT INTO health (time) VALUES (datetime('now', 'localtime'));

CREATE TABLE Free_users(
	Email VARCHAR(40),
    Pasword VARCHAR(40),
    User_name VARCHAR(20),
    Birthdate DATE,
    Gender BOOLEAN,
    Country VARCHAR(60),
    Postal_code VARCHAR(10),
    Premium_ID BIGINT REFERENCES Premium_users(User_ID),
    User_ID BIGINT AUTO_INCREMENT PRIMARY KEY
);
CREATE TABLE Premium_users(
	Email VARCHAR(40),
    Pasword VARCHAR(40),
    User_name VARCHAR(20),
    Birthdate DATE,
    Gender BOOLEAN,
    Country VARCHAR(60),
    Postal_code VARCHAR(10),
    Free_ID BIGINT REFERENCES Free_users(User_ID),
    User_ID BIGINT AUTO_INCREMENT PRIMARY KEY
);
CREATE TABLE Transactions(
	Order_number BIGINT AUTO_INCREMENT PRIMARY KEY,
    Payment_date DATE,
    Total_amount INT,
    User_ID BIGINT REFERENCES Premium_users(User_ID)
);
CREATE TABLE Subscriptions(
	Start_date DATE,
    Renove_date DATE,
    Payment_method BOOLEAN,
    User_ID BIGINT REFERENCES Premium_users(User_ID),
    PRIMARY KEY (User_ID)
);
CREATE TABLE Credit_cards(
	User_ID BIGINT REFERENCES Premium_users(User_ID),
    Card_number INT,
    Expiry_month INT,
    Expiry_year INT,
    Security_code INT,
    Salt VARCHAR(40),
    PRIMARY KEY (User_ID, Card_number),
    CONSTRAINT Expiry_month_CK CHECK(Expiry_month IN("01","02","03","04","05","06","07","08","09","10","11","12"))
);
CREATE TABLE Paypal_accounts(
	User_ID BIGINT REFERENCES Premium_users(User_ID),
    Paypal_user_ID INT,
    Salt VARCHAR(40),
    PRIMARY KEY (User_ID, Paypal_user_ID)
);
CREATE TABLE Songs(
	Song_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(20),
    Duration TIME,
    Times_played INT,
    Album_ID INT REFERENCES Albums(Album_ID),
    Artist_ID INT REFERENCES Artists(Artist_ID)
);
CREATE TABLE Albums(
	Album_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(20),
    Publish_date DATE,
    Image BLOB,
    Artist_ID INT REFERENCES Arstists(Artist_ID)
);
CREATE TABLE Albums_songs(
	Album_ID INT REFERENCES Albums(Album_ID),
    Song_ID BIGINT REFERENCES Songs(Song_ID),
    PRIMARY KEY (Album_ID, Song_ID)
);
CREATE TABLE Artists(
	Artist_ID INT AUTO_INCREMENT PRIMARY KEY,
    Artist_name VARCHAR(25),
    Image BLOB
);
CREATE TABLE Artists_albums(
	Artist_ID INT REFERENCES Artists(Artist_ID),
    Album_ID INT REFERENCES Albums(Album_ID),
    PRIMARY KEY (Artist_ID, Album_ID)
);
CREATE TABLE Similar_artists(
	Artist_ID INT REFERENCES Artists(Artist_ID),
    Similar_artist_ID INT REFERENCES Artists(Artist_ID),
    PRIMARY KEY (Artist_ID, Similar_artist_ID)
);
CREATE TABLE Follow(
	Follow_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
	Artist_ID INT REFERENCES Artists(Artist_ID),
    Free_user_ID BIGINT REFERENCES Free_users(User_ID),
    Premium_user_ID BIGINT REFERENCES Premium_users(User_ID)
);
CREATE TABLE Favorite_albums(
	Favorite_album_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
	Album_ID INT REFERENCES Albums(Album_ID),
    Free_user_ID BIGINT REFERENCES Free_users(User_ID),
    Premium_user_ID BIGINT REFERENCES Premium_users(User_ID)
);
CREATE TABLE Favorite_songs(
	Favorite_song_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
	Song_ID INT REFERENCES Songs(Song_ID),
    Free_user_ID BIGINT REFERENCES Free_users(User_ID),
    Premium_user_ID BIGINT REFERENCES Premium_users(User_ID)
);
CREATE TABLE Songs_playlists(
	Song_ID INT REFERENCES Songs(Song_ID),
    Free_user_ID BIGINT REFERENCES Free_users(User_ID),
    Premium_user_ID BIGINT REFERENCES Premium_users(User_ID),
    PlayList_ID INT REFERENCES Active_playLists(PlayList_ID),
    Song_added_date DATE,
    PRIMARY KEY (Song_ID, PlayList_ID)
);
CREATE TABLE Active_playlists(
	PlayList_ID INT PRIMARY KEY,
    PlayList_name VARCHAR(25),
    Creation_date DATE,
    Number_songs INT,
    Is_shared BOOLEAN,
	Free_user_creator BIGINT REFERENCES Free_users(User_ID),
    Premium_user_creator BIGINT REFERENCES Premium_users(User_ID)
);
CREATE TABLE Deleted_playlists(
	PlayList_ID INT REFERENCES Active_playlists(PlayList_ID),
    PlayList_name VARCHAR(25),
    Creation_date DATE,
    Number_songs INT,
    Deletion_date DATE,
	Free_user_creator BIGINT REFERENCES Free_users(User_ID),
    Premium_user_creator BIGINT REFERENCES Premium_users(User_ID)
);
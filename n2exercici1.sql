CREATE TABLE YT_user(
	Email VARCHAR(40) PRIMARY KEY,
    Pasword VARCHAR(40),
    User_name VARCHAR(20) UNIQUE,
    Birthdate DATE,
    Gender BOOLEAN,
    Country VARCHAR(60),
    Postal_code VARCHAR(10),
    Salt VARCHAR(40)
);
CREATE TABLE YT_channel(
	Channel_ID INT AUTO_INCREMENT PRIMARY KEY,
    Channel_name VARCHAR(25),
    Channel_description VARCHAR(200),
    Creation_date DATE,
    User_creator VARCHAR(40) REFERENCES YT_user(Email),
    Subscribers INT
);
CREATE TABLE Subscribe(
	Channel_ID INT REFERENCES YT_channel(Channel_ID),
    User_email VARCHAR(40) REFERENCES YT_user(Email),
    Subscribe_date DATE,
    PRIMARY KEY (Channel_ID, User_email)
);
CREATE TABLE Videos(
	Video_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(50),
    Video_description VARCHAR(200),
    Size_bytes DECIMAL (15, 2),
    File_name VARCHAR(25),
    Duration TIME,
    Thumbnail BLOB,
    Number_plays INT,
    Likes INT,
    Dislikes INT,
    Video_status VARCHAR(10),
	CONSTRAINT Video_status_CK CHECK(Video_status("Hidden", "Public", "Private"))
);
CREATE TABLE Tags(
	Tag_ID INT AUTO_INCREMENT PRIMARY KEY,
    Tag_name VARCHAR(25)
);
ALTER TABLE Tags
AUTO_INCREMENT = 100;

CREATE TABLE PlayLists(
	PlayList_ID INT AUTO_INCREMENT PRIMARY KEY,
    PlayList_name VARCHAR(25),
    Creation_date DATE,
    Public_private BOOLEAN,
    User_creator VARCHAR(40) REFERENCES YT_user(Email)
);
ALTER TABLE PlayLists
AUTO_INCREMENT = 1000;

CREATE TABLE Videos_playlist(
	Video_ID BIGINT REFERENCES Videos(Video_ID),
    PlayList_ID INT REFERENCES PlayLists(PlayList_ID),
    Video_order INT,
    PRIMARY KEY (Video_ID, PlayList_ID)
);
CREATE TABLE Publish(
	User_email VARCHAR(40) REFERENCES YT_user(Email),
    Video_ID BIGINT REFERENCES Videos(Video_ID),
    Date_time DATETIME,
    PRIMARY KEY (User_email, Video_ID)
);
CREATE TABLE Like_Dislike_video(
	Like_dislike BOOLEAN,
    Date_time DATETIME,
    User_email VARCHAR(40) REFERENCES YT_user(Email),
    Video_ID BIGINT REFERENCES Videos(Video_ID),
    PRIMARY KEY (User_email, Video_ID)
);
CREATE TABLE Like_Dislike_comment(
	Like_dislike BOOLEAN,
    Date_time DATETIME,
    User_email VARCHAR(40) REFERENCES YT_user(Email),
    Comment_ID BIGINT REFERENCES Comment_video(Comment_ID),
    PRIMARY KEY (User_email, Comment_ID)
);
CREATE TABLE Comment_video(
	Comment_ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    Date_time DATETIME,
    Comment_text VARCHAR(250),
	User_email VARCHAR(40) REFERENCES YT_user(Email),
    Video_ID BIGINT REFERENCES Videos(Video_ID)
);
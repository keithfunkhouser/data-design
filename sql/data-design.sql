ALTER DATABASE kfunkhouser CHARACTER SET utf8 COLLATE utf8_unicode_ci;

DROP TABLE IF EXISTS `share`;
DROP TABLE IF EXISTS `file`;
DROP TABLE IF EXISTS folder;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	userId BINARY(16) NOT NULL,
	userActivationToken CHAR(32),
	userEmail VARCHAR(128) NOT NULL,
	userHash CHAR(97) NOT NULL,
	userName VARCHAR(32) NOT NULL,
	userRole VARCHAR(32) NOT NULL,
	UNIQUE(userEmail),
	PRIMARY KEY(userId)
);

CREATE TABLE folder (
	folderId BINARY(16) NOT NULL,
	folderUserId BINARY(16) NOT NULL,
	folderDateCreated DATETIME(6) NOT NULL,
	folderDateModified DATETIME(6),
	folderName VARCHAR(32) NOT NULL,
	folderPath VARCHAR(255) NOT NULL,
	INDEX(folderUserId),
	FOREIGN KEY(folderUserId) REFERENCES `user`(userId),
	PRIMARY KEY(folderId)
);

CREATE TABLE `file` (
	fileId BINARY(16) NOT NULL,
	fileUserId BINARY(16) NOT NULL,
	fileFolderId BINARY(16) NOT NULL,
	fileDateUploaded DATETIME(6) NOT NULL,
	fileDateModified DATETIME(6),
	fileName VARCHAR(32) NOT NULL,
	filePath VARCHAR(255) NOT NULL,
	INDEX(fileUserId),
	INDEX(fileFolderId),
	FOREIGN KEY(fileUserId) REFERENCES `user`(userId),
	FOREIGN KEY(fileFolderId) REFERENCES folder(folderId),
	PRIMARY KEY(fileId)
);

CREATE TABLE `share` (
	shareUserId BINARY(16) NOT NULL,
	shareFolderId BINARY(16) NOT NULL,
	shareEmail VARCHAR(128) NOT NULL,
	shareLink VARCHAR(255) NOT NULL,
	shareMessage VARCHAR(300),
	sharePermissions VARCHAR(32) NOT NULL,
	INDEX(shareUserId),
	INDEX(shareFolderId),
	FOREIGN KEY(shareUserId) REFERENCES `user`(userId),
	FOREIGN KEY(shareFolderId) REFERENCES folder(folderId),
	PRIMARY KEY(shareUserId, shareFolderId)
);
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

INSERT INTO `user` VALUES (
    UNHEX('b7e9cbdfde6d44b9b2a0abd0a3898a4f'),
    'VioWJmEzi50MeDoZxTUWmvcLGxUocLYI',
    'sally@sallydesign.com',
    'YdWEUYtLZP5McRTmreFJd57df6BtMcBYNsOnBChjNgH0ptQSewNRqAj5WNAvrdSdHVkb6fDOt9Fe3K8AylGk4KX6YNDCg82CT',
    'Sally',
    'Admin'
);

INSERT INTO `user` VALUES (
    UNHEX('ac8e277e8d9b4e17aa60209e8f88b846'),
    'Oe6K3ifCEMqPKOmO0L6iFjZ8drZD6REw',
    'john@sallydesign.com',
    'JnY2XeHtOovKlQJ96rfy4Mo2TxDnz86d7wmltug7VQHgtp14PAxlvDZGQjipo1VdGBYYokySJYqrBKT9tkjopCgwfY7UxiAuZ',
    'John',
    'Team Member'
);

INSERT INTO `user` VALUES (
    UNHEX('1cc4c7b658cf419a8dcba66d4583bb4d'),
    '5NOMiQZ4u7scANQIY90Zc5F6E7RPldzh',
    'sarah@sallydesign.com',
    '0lDBpKZPUgHOemxYIZSKXw4VtwTszQpW6JLZHCOvzaM8I84Djc1YibX0d113vesgbYIt45XsAQeDNKBywiXUUrG3WcjsUgARS',
    'Sara',
    'Team Member'
);

UPDATE `user` SET userName = 'Sarah' WHERE userId = UNHEX('1cc4c7b658cf419a8dcba66d4583bb4d');

DELETE FROM `user` WHERE userId = UNHEX('ac8e277e8d9b4e17aa60209e8f88b846');

INSERT INTO folder(folderID, folderUserId, folderDateCreated, folderName, folderPath) VALUES (
    UNHEX('f81e0992154b4cf1813f8d03038f4c28'),
    UNHEX('b7e9cbdfde6d44b9b2a0abd0a3898a4f'),
    '2020-05-09 11:05:00.000000',
    'renders',
    'home/clients/initech/logo'
);

SELECT * FROM `user` WHERE userId = UNHEX('1cc4c7b658cf419a8dcba66d4583bb4d');

SELECT userName FROM folder INNER JOIN `user` ON folder.folderUserId = `user`.userId WHERE folderName = 'renders';

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Movie] (
    [MovieId] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Year] int NOT NULL,
    [Rating] int NOT NULL,
    CONSTRAINT [PK_Movie] PRIMARY KEY ([MovieId])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] ON;
INSERT INTO [Movie] ([MovieId], [Name], [Rating], [Year])
VALUES (1, N'Casablance', 5, 1942);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] ON;
INSERT INTO [Movie] ([MovieId], [Name], [Rating], [Year])
VALUES (2, N'Wonder Woman', 3, 2017);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] ON;
INSERT INTO [Movie] ([MovieId], [Name], [Rating], [Year])
VALUES (3, N'Moonstruck', 4, 1988);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'MovieId', N'Name', N'Rating', N'Year') AND [object_id] = OBJECT_ID(N'[Movie]'))
    SET IDENTITY_INSERT [Movie] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210215014916_Initial', N'8.0.11');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Movie] DROP CONSTRAINT [PK_Movie];
GO

EXEC sp_rename N'[Movie]', N'Movies';
GO

ALTER TABLE [Movies] ADD [GenreId] nvarchar(450) NOT NULL DEFAULT N'';
GO

ALTER TABLE [Movies] ADD CONSTRAINT [PK_Movies] PRIMARY KEY ([MovieId]);
GO

CREATE TABLE [Genres] (
    [GenreId] nvarchar(450) NOT NULL,
    [Name] nvarchar(max) NULL,
    CONSTRAINT [PK_Genres] PRIMARY KEY ([GenreId])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GenreId', N'Name') AND [object_id] = OBJECT_ID(N'[Genres]'))
    SET IDENTITY_INSERT [Genres] ON;
INSERT INTO [Genres] ([GenreId], [Name])
VALUES (N'A', N'Action'),
(N'C', N'Comedy'),
(N'D', N'Drama'),
(N'H', N'Horror'),
(N'M', N'Musical'),
(N'R', N'RomCom'),
(N'S', N'SciFi');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GenreId', N'Name') AND [object_id] = OBJECT_ID(N'[Genres]'))
    SET IDENTITY_INSERT [Genres] OFF;
GO

UPDATE [Movies] SET [GenreId] = N'D', [Name] = N'Casablanca'
WHERE [MovieId] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [Movies] SET [GenreId] = N'A'
WHERE [MovieId] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [Movies] SET [GenreId] = N'R'
WHERE [MovieId] = 3;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_Movies_GenreId] ON [Movies] ([GenreId]);
GO

ALTER TABLE [Movies] ADD CONSTRAINT [FK_Movies_Genres_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [Genres] ([GenreId]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20210215034651_Genre', N'8.0.11');
GO

COMMIT;
GO


﻿/*
Deployment script for PokeDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PokeDatabase"
:setvar DefaultFilePrefix "PokeDatabase"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The type for column pokemonName in table [dbo].[Pokemon] is currently  NVARCHAR (15) NOT NULL but is being changed to  VARCHAR (15) NOT NULL. Data loss could occur.

The type for column type in table [dbo].[Pokemon] is currently  NVARCHAR (10) NOT NULL but is being changed to  VARCHAR (10) NOT NULL. Data loss could occur.

The type for column weakness in table [dbo].[Pokemon] is currently  NVARCHAR (10) NOT NULL but is being changed to  VARCHAR (10) NOT NULL. Data loss could occur.


IF EXISTS (select top 1 1 from [dbo].[Pokemon])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT
*/

GO
/*
The column pokeHint on table [dbo].[PokemonHints] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The type for column pokeHint in table [dbo].[PokemonHints] is currently  NVARCHAR (150) NULL but is being changed to  VARCHAR (150) NOT NULL. Data loss could occur.

The column pokeName on table [dbo].[PokemonHints] must be changed from NULL to NOT NULL. If the table contains data, the ALTER script may not work. To avoid this issue, you must add values to this column for all rows or mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The type for column pokeName in table [dbo].[PokemonHints] is currently  NVARCHAR (MAX) NULL but is being changed to  VARCHAR (20) NOT NULL. Data loss could occur.


IF EXISTS (select top 1 1 from [dbo].[PokemonHints])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT


GO
/*
The type for column typeImg in table [dbo].[Types] is currently  VARCHAR (20) NOT NULL but is being changed to  VARCHAR (13) NOT NULL. Data loss could occur.

The type for column typeName in table [dbo].[Types] is currently  VARCHAR (20) NOT NULL but is being changed to  VARCHAR (10) NOT NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Types])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT
*/
GO
PRINT N'Rename refactoring operation with key 2f07bfa7-5a06-4c0f-a8cb-7184db21ec65 is skipped, element [dbo].[Pokemon].[Id] (SqlSimpleColumn) will not be renamed to pokeId';


GO
PRINT N'Rename refactoring operation with key c57ea864-becb-4b9b-8f8e-376862bd46b9 is skipped, element [dbo].[Pokemon].[strengthId] (SqlSimpleColumn) will not be renamed to height';


GO
PRINT N'Rename refactoring operation with key a22b1dd5-47ce-42ee-a78f-9193a8dcbea2, 1f26fe56-761b-4de9-9965-0cb98b9c67a4 is skipped, element [dbo].[Weaknesses].[Id] (SqlSimpleColumn) will not be renamed to attributeId';


GO
PRINT N'Rename refactoring operation with key 5d761ef0-9bdc-46c6-9d63-52b4a46c46df is skipped, element [dbo].[Strengths].[Id] (SqlSimpleColumn) will not be renamed to strengthId';


GO
PRINT N'Rename refactoring operation with key 5432c25c-bb18-4bb2-95b8-42e27e4d8a26 is skipped, element [dbo].[Weaknesses].[weaknessName] (SqlSimpleColumn) will not be renamed to attributeName';


GO
PRINT N'Rename refactoring operation with key e83bb3cc-2809-45ed-b650-7cecde1cc421 is skipped, element [dbo].[Weaknesses].[weaknessImgName] (SqlSimpleColumn) will not be renamed to attributeImgName';


GO
PRINT N'Rename refactoring operation with key 6c2ad676-91dd-4188-8b44-9fed642f5f7a is skipped, element [dbo].[Types].[Id] (SqlSimpleColumn) will not be renamed to typeId';


GO
PRINT N'Rename refactoring operation with key 2db05e9f-0d32-437f-9a98-1ede774445a8 is skipped, element [dbo].[Types].[typeDestination] (SqlSimpleColumn) will not be renamed to typeImg';


GO
PRINT N'Rename refactoring operation with key 97381325-afe5-46a7-a9e1-54183fe2053d is skipped, element [dbo].[Pokemon].[max] (SqlSimpleColumn) will not be renamed to maxEvo';


GO
PRINT N'Rename refactoring operation with key 51f17d16-54f3-4d2c-8721-359830bc54ad is skipped, element [dbo].[PokemonHints].[Id] (SqlSimpleColumn) will not be renamed to hintId';


GO
PRINT N'Starting rebuilding table [dbo].[Pokemon]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Pokemon] (
    [pokeId]      INT            NOT NULL,
    [height]      DECIMAL (5, 2) NOT NULL,
    [weight]      DECIMAL (5, 2) NOT NULL,
    [gender]      CHAR (1)       NOT NULL,
    [category]    VARCHAR (20)   NOT NULL,
    [pokeImgName] VARCHAR (1000) NOT NULL,
    [evolution]   INT            NOT NULL,
    [pokemonName] VARCHAR (15)   NOT NULL,
    [weakness]    VARCHAR (10)   NOT NULL,
    [type]        VARCHAR (10)   NOT NULL,
    [maxEvo]      TINYINT        NULL,
    PRIMARY KEY CLUSTERED ([pokeId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Pokemon])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Pokemon] ([pokeId], [type], [weakness], [height], [weight], [gender], [category], [pokeImgName], [evolution], [pokemonName], [maxEvo])
        SELECT   [pokeId],
                 [type],
                 [weakness],
                 [height],
                 [weight],
                 [gender],
                 [category],
                 [pokeImgName],
                 [evolution],
                 [pokemonName],
                 [maxEvo]
        FROM     [dbo].[Pokemon]
        ORDER BY [pokeId] ASC;
    END

DROP TABLE [dbo].[Pokemon];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Pokemon]', N'Pokemon';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[PokemonHints]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_PokemonHints] (
    [hintId]   UNIQUEIDENTIFIER NOT NULL,
    [pokeName] VARCHAR (20)     NOT NULL,
    [pokeHint] VARCHAR (150)    NOT NULL,
    [userId]   UNIQUEIDENTIFIER NOT NULL,
    [pokeId]   INT              NOT NULL,
    PRIMARY KEY CLUSTERED ([hintId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[PokemonHints])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_PokemonHints] ([hintId], [userId], [pokeId], [pokeName], [pokeHint])
        SELECT   [hintId],
                 [userId],
                 [pokeId],
                 [pokeName],
                 [pokeHint]
        FROM     [dbo].[PokemonHints]
        ORDER BY [hintId] ASC;
    END

DROP TABLE [dbo].[PokemonHints];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_PokemonHints]', N'PokemonHints';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Types]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Types] (
    [typeId]   INT          NOT NULL,
    [typeName] VARCHAR (10) NOT NULL,
    [typeImg]  VARCHAR (13) NOT NULL,
    PRIMARY KEY CLUSTERED ([typeId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Types])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Types] ([typeId], [typeName], [typeImg])
        SELECT   [typeId],
                 [typeName],
                 [typeImg]
        FROM     [dbo].[Types]
        ORDER BY [typeId] ASC;
    END

DROP TABLE [dbo].[Types];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Types]', N'Types';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[AspNetRoles]...';


GO
CREATE TABLE [dbo].[AspNetRoles] (
    [Id]   NVARCHAR (128) NOT NULL,
    [Name] NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetRoles].[RoleNameIndex]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
    ON [dbo].[AspNetRoles]([Name] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserClaims]...';


GO
CREATE TABLE [dbo].[AspNetUserClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     NVARCHAR (128) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserClaims].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserClaims]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserLogins]...';


GO
CREATE TABLE [dbo].[AspNetUserLogins] (
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    [UserId]        NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserLogins].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserLogins]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserRoles]...';


GO
CREATE TABLE [dbo].[AspNetUserRoles] (
    [UserId] NVARCHAR (128) NOT NULL,
    [RoleId] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUserRoles].[IX_UserId]...';


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserRoles]([UserId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUserRoles].[IX_RoleId]...';


GO
CREATE NONCLUSTERED INDEX [IX_RoleId]
    ON [dbo].[AspNetUserRoles]([RoleId] ASC);


GO
PRINT N'Creating [dbo].[AspNetUsers]...';


GO
CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                   NVARCHAR (128) NOT NULL,
    [Email]                NVARCHAR (256) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[AspNetUsers].[UserNameIndex]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
    ON [dbo].[AspNetUsers]([UserName] ASC);


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserClaims] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserLogins] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]...';


GO
ALTER TABLE [dbo].[AspNetUserRoles] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE;


GO
PRINT N'Creating [dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]...';


GO
ALTER TABLE [dbo].[AspNetUserRoles] WITH NOCHECK
    ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2f07bfa7-5a06-4c0f-a8cb-7184db21ec65')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2f07bfa7-5a06-4c0f-a8cb-7184db21ec65')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c57ea864-becb-4b9b-8f8e-376862bd46b9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c57ea864-becb-4b9b-8f8e-376862bd46b9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a22b1dd5-47ce-42ee-a78f-9193a8dcbea2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a22b1dd5-47ce-42ee-a78f-9193a8dcbea2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5d761ef0-9bdc-46c6-9d63-52b4a46c46df')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5d761ef0-9bdc-46c6-9d63-52b4a46c46df')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1f26fe56-761b-4de9-9965-0cb98b9c67a4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1f26fe56-761b-4de9-9965-0cb98b9c67a4')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5432c25c-bb18-4bb2-95b8-42e27e4d8a26')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5432c25c-bb18-4bb2-95b8-42e27e4d8a26')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e83bb3cc-2809-45ed-b650-7cecde1cc421')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e83bb3cc-2809-45ed-b650-7cecde1cc421')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6c2ad676-91dd-4188-8b44-9fed642f5f7a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6c2ad676-91dd-4188-8b44-9fed642f5f7a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2db05e9f-0d32-437f-9a98-1ede774445a8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2db05e9f-0d32-437f-9a98-1ede774445a8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '97381325-afe5-46a7-a9e1-54183fe2053d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('97381325-afe5-46a7-a9e1-54183fe2053d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '51f17d16-54f3-4d2c-8721-359830bc54ad')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('51f17d16-54f3-4d2c-8721-359830bc54ad')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[AspNetUserClaims] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserLogins] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserRoles] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId];

ALTER TABLE [dbo].[AspNetUserRoles] WITH CHECK CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId];


GO
PRINT N'Update complete.';


GO

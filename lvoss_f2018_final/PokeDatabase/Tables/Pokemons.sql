CREATE TABLE [dbo].[Pokemon]
(
	[pokeId] INT NOT NULL PRIMARY KEY, 
    [height] DECIMAL(5, 2) NOT NULL, 
    [weight] DECIMAL(5, 2) NOT NULL, 
    [gender] CHAR NOT NULL, 
    [category] VARCHAR(20) NOT NULL, 
    [pokeImgName] VARCHAR(1000) NOT NULL, 
    [evolution] INT NOT NULL, 
    [pokemonName] VARCHAR(15) NOT NULL, 
    [weakness] VARCHAR(10) NOT NULL, 
    [type] VARCHAR(10) NOT NULL, 
    [maxEvo] TINYINT NULL
)

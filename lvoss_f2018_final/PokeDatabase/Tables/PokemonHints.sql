﻿CREATE TABLE [dbo].[PokemonHints]
(
	[hintId] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY, 
    [pokeName] VARCHAR(20) NOT NULL, 
    [pokeHint] VARCHAR(150) NOT NULL, 
    [userId] UNIQUEIDENTIFIER NOT NULL, 
    [pokeId] INT NOT NULL
)

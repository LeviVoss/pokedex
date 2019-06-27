using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PokeDex_lvoss
{
    public class MyConstans
    {
        public const int ITEMS_PER_PAGE = 5;
        //public const int MAX_CAST_SIZE = 3;

        //pokemon IMGS
        public const string POKEMON_IMAGE_PATH = "~/Content/PokemonImgs/";
        public const int POKEMON_IMAGE_SIZE = 160;

        //type IMGS
        public const string TYPE_IMAGE_PATH = "~/Content/PokemonTypes/";
        public static readonly string[] POKEMON_TYPES = new string[]
        {
            "bug",
            "dark",
            "dragon",
            "electric",
            "fairy",
            "fighting",
            "fire",
            "flying",
            "ghost",
            "grass",
            "ground",
            "ice",
            "normal",
            "posion",
            "psychic",
            "rock",
            "steel",
            "unkown",
            "water"
        };


        //4MB
        public const int MAX_IMAGE_FILE_SIZE = 5 * 1024 * 1024;

        //(Multiple extensions)
        //public static readonly string[] ALLOWED_IMAGE_EXTENSIONS = new string[]
        //{
        //    ".png"
        //};
        public const string ALLOWED_IMG_EXTENSION = ".png";
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace PokeDex_lvoss.Models
{
    [Table("PokemonHints")]
    public class PokemonHint
    {
        [Key]
        public Guid hintId { get; set; }
        public Guid userId { get; set; }
        public int pokeId { get; set; }

        [Display(Name = "Name:")]
        public string pokeName { get; set; }

        [Display(Name = "Hint:")]
        [StringLength(150, ErrorMessage = "Your hint can only contain 150 characters.")]
        public string pokeHint { get; set; }
    }
}
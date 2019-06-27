namespace PokeDex_lvoss.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Pokemon")]
    public partial class Pokemon
    {
        [Key]
        [Display(Name = "Pokemon #")]
        [Range(1,150,ErrorMessage = "Only 150 alloted for in the pokedex.")]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int pokeId { get; set; }

        [Required]
        [Display(Name = "Type")]
        [StringLength(10, ErrorMessage = "There should be no type that is more than 10 characters")]
        public string type { get; set; }

        [Required]
        [Display(Name = "Weakness")]
        [StringLength(10, ErrorMessage = "There should be no type that is more than 10 characters")]
        public string weakness { get; set; }

        [Display(Name = "Height")]
        [Required(ErrorMessage = "What is the pokemon's height?")]
        public decimal height { get; set; }

        [Display(Name = "Weight")]
        [Required(ErrorMessage = "What is the pokemon's weight?")]
        public decimal weight { get; set; }

        [Display(Name = "Gender")]
        [Required(ErrorMessage = "What is the pokemon's gender? (It can be Male, Female, or Both).")]
        [StringLength(1)]
        public string gender { get; set; }

        [Display(Name = "Category")]
        [Required(ErrorMessage = "What is the pokemon's category.")]
        [StringLength(20)]
        public string category { get; set; }

        [Display(Name = "Picture")]
        [Required(ErrorMessage = "I need an image of the pokemon")]
        [StringLength(1000, ErrorMessage = "Your filename cannot be longer than 1000 characters")]
        public string pokeImgName { get; set; }

        [Display(Name = "Evolution")]
        [Required(ErrorMessage = "What evolution is your pokemon at")]
        [Range(1,4,ErrorMessage = "Only 1 to 4 evolutions atm plz( eevee :( )")]
        public int evolution { get; set; }

        [Required(ErrorMessage = "The pokemon has to have a name.")]
        [Display(Name = "Name")]
        [StringLength(15, ErrorMessage = "The max characters your pokemon can have is 15")]
        public string pokemonName { get; set; }

        [Display(Name = "Max Evolution")]
        public byte maxEvo { get; set; }
    }
}

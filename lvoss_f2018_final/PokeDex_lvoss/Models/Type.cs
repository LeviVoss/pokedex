namespace PokeDex_lvoss.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Type
    {
        public int typeId { get; set; }

        [Required]
        [StringLength(20)]
        public string typeName { get; set; }

        [Required]
        [StringLength(20)]
        public string typeImg { get; set; }
    }
}

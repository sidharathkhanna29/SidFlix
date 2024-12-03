using System.ComponentModel.DataAnnotations; //Using the directive

namespace MovieList.Models
{
    public class Users
    {
        [Key] // Specifies that this is the primary key
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required.")] // Ensures the field is not empty
        [StringLength(100, ErrorMessage = "Name cannot exceed 100 characters.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid email address.")] // Ensures valid email format
        public string Email { get; set; }

        [StringLength(500, ErrorMessage = "Bio cannot exceed 500 characters.")] // Limits the length of the Bio
        public string Bio { get; set; }
    }
}

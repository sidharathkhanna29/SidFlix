namespace MovieList.Models
{
    public class Genre
    {
        public string GenreId { get; set; }
        public string Name { get; set; }

        public override string ToString()
        {
            return Name; // Return the genre name for display
        }
    }
}

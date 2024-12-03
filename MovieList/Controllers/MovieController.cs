using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MovieList.Models;

namespace MovieList.Controllers
{
    public class MovieController : Controller
    {
        private MovieContext context { get; set; }

        public MovieController(MovieContext ctx)
        {
            context = ctx;
        }

        public IActionResult Index(string genre)
        {
            // Get all genres for the dropdown filter
            var genres = context.Genres
                                 .OrderBy(g => g.Name)
                                 .ToList();

            // Filter movies based on selected genre
            var movies = string.IsNullOrEmpty(genre)
                ? context.Movies.Include(m => m.Genre).ToList()  // If no genre selected, show all movies
                : context.Movies
                          .Where(m => m.GenreId.ToString() == genre)  // Filter by selected genre
                          .Include(m => m.Genre)  // Include Genre details
                          .ToList();

            Console.WriteLine($"Movies count: {movies.Count}");

            // Pass genres to ViewBag for dropdown and the selected genre
            ViewBag.Genres = new SelectList(genres, "GenreId", "Name", genre);  // Set selected genre
            ViewBag.SelectedGenre = genre;  // Store selected genre for highlighting in dropdown

            // Return the view with filtered movies
            return View(movies);
        }



        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            ViewBag.Genres = context.Genres.OrderBy(g => g.Name).ToList();
            return View("Edit", new Movie());
        }
        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            ViewBag.Genres = context.Genres.OrderBy(g => g.Name).ToList();
            var movie = context.Movies.Find(id);
            return View(movie);
        }

        [HttpPost]
        public IActionResult Edit(Movie movie)
        {
            if (ModelState.IsValid)
            {
                if (movie.MovieId == 0)
                    context.Movies.Add(movie);
                else
                    context.Movies.Update(movie);
                context.SaveChanges();
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Action = (movie.MovieId == 0) ? "Add" : "Edit";
               ViewBag.Genres = context.Genres.OrderBy(g => g.Name).ToList();
                return View(movie);
            }
        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var movie = context.Movies.Find(id);
            return View(movie);
        }
        [HttpPost]
        public IActionResult Delete(Movie movie)
        {
            context.Movies.Remove(movie);
            context.SaveChanges();
            return RedirectToAction("Index", "Home");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using netlexapiwebadmin.Models;

namespace netlexapiwebadmin.Controllers
{
    public class FavorMoviesController : Controller
    {
        private readonly netflexContext _context;

        public FavorMoviesController(netflexContext context)
        {
            _context = context;
        }

        // GET: FavorMovies
        public async Task<IActionResult> Index()
        {
            var netflexContext = _context.FavorMovies.Include(f => f.Movie).Include(f => f.User);
            return View(await netflexContext.ToListAsync());
        }

        // GET: FavorMovies/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.FavorMovies == null)
            {
                return NotFound();
            }

            var favorMovie = await _context.FavorMovies
                .Include(f => f.Movie)
                .Include(f => f.User)
                .FirstOrDefaultAsync(m => m.FavorId == id);
            if (favorMovie == null)
            {
                return NotFound();
            }

            return View(favorMovie);
        }

        // GET: FavorMovies/Create
        public IActionResult Create()
        {
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id");
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId");
            return View();
        }

        // POST: FavorMovies/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("FavorId,MovieId,UserId")] FavorMovie favorMovie)
        {
            if (ModelState.IsValid)
            {
                _context.Add(favorMovie);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", favorMovie.MovieId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", favorMovie.UserId);
            return View(favorMovie);
        }

        // GET: FavorMovies/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.FavorMovies == null)
            {
                return NotFound();
            }

            var favorMovie = await _context.FavorMovies.FindAsync(id);
            if (favorMovie == null)
            {
                return NotFound();
            }
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", favorMovie.MovieId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", favorMovie.UserId);
            return View(favorMovie);
        }

        // POST: FavorMovies/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("FavorId,MovieId,UserId")] FavorMovie favorMovie)
        {
            if (id != favorMovie.FavorId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(favorMovie);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FavorMovieExists(favorMovie.FavorId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", favorMovie.MovieId);
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", favorMovie.UserId);
            return View(favorMovie);
        }

        // GET: FavorMovies/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.FavorMovies == null)
            {
                return NotFound();
            }

            var favorMovie = await _context.FavorMovies
                .Include(f => f.Movie)
                .Include(f => f.User)
                .FirstOrDefaultAsync(m => m.FavorId == id);
            if (favorMovie == null)
            {
                return NotFound();
            }

            return View(favorMovie);
        }

        // POST: FavorMovies/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.FavorMovies == null)
            {
                return Problem("Entity set 'netflexContext.FavorMovies'  is null.");
            }
            var favorMovie = await _context.FavorMovies.FindAsync(id);
            if (favorMovie != null)
            {
                _context.FavorMovies.Remove(favorMovie);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool FavorMovieExists(int id)
        {
          return (_context.FavorMovies?.Any(e => e.FavorId == id)).GetValueOrDefault();
        }
    }
}

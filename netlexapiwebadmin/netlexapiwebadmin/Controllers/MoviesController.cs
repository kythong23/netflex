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
    public class MoviesController : Controller
    {
        private readonly netflexContext _context;

        public MoviesController(netflexContext context)
        {
            _context = context;
        }

        // GET: Movies
        public async Task<IActionResult> Index()
        {
            var netflexContext = _context.Movies.Include(m => m.Country).Include(m => m.Creator).Include(m => m.Subtitle);
            return View(await netflexContext.ToListAsync());
        }

        // GET: Movies/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Creator)
                .Include(m => m.Subtitle)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // GET: Movies/Create
        public IActionResult Create()
        {
            ViewData["CountryId"] = new SelectList(_context.Countries, "CountryId", "CountryId");
            ViewData["CreatorId"] = new SelectList(_context.Creators, "CreatorId", "CreatorId");
            ViewData["SubtitleId"] = new SelectList(_context.Subtitles, "SubtitleId", "SubtitleId");
            return View();
        }

        // POST: Movies/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Title,Description,Img,Duration,DateRelease,Likes,Episode,Views,AgeLimit,CountryId,CreatorId,SubtitleId,Status,Trailer")] Movie movie)
        {
            if (ModelState.IsValid)
            {
                _context.Add(movie);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CountryId"] = new SelectList(_context.Countries, "CountryId", "CountryId", movie.CountryId);
            ViewData["CreatorId"] = new SelectList(_context.Creators, "CreatorId", "CreatorId", movie.CreatorId);
            ViewData["SubtitleId"] = new SelectList(_context.Subtitles, "SubtitleId", "SubtitleId", movie.SubtitleId);
            return View(movie);
        }

        // GET: Movies/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies.FindAsync(id);
            if (movie == null)
            {
                return NotFound();
            }
            ViewData["CountryId"] = new SelectList(_context.Countries, "CountryId", "CountryId", movie.CountryId);
            ViewData["CreatorId"] = new SelectList(_context.Creators, "CreatorId", "CreatorId", movie.CreatorId);
            ViewData["SubtitleId"] = new SelectList(_context.Subtitles, "SubtitleId", "SubtitleId", movie.SubtitleId);
            return View(movie);
        }

        // POST: Movies/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Title,Description,Img,Duration,DateRelease,Likes,Episode,Views,AgeLimit,CountryId,CreatorId,SubtitleId,Status,Trailer")] Movie movie)
        {
            if (id != movie.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(movie);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MovieExists(movie.Id))
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
            ViewData["CountryId"] = new SelectList(_context.Countries, "CountryId", "CountryId", movie.CountryId);
            ViewData["CreatorId"] = new SelectList(_context.Creators, "CreatorId", "CreatorId", movie.CreatorId);
            ViewData["SubtitleId"] = new SelectList(_context.Subtitles, "SubtitleId", "SubtitleId", movie.SubtitleId);
            return View(movie);
        }

        // GET: Movies/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Movies == null)
            {
                return NotFound();
            }

            var movie = await _context.Movies
                .Include(m => m.Country)
                .Include(m => m.Creator)
                .Include(m => m.Subtitle)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (movie == null)
            {
                return NotFound();
            }

            return View(movie);
        }

        // POST: Movies/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Movies == null)
            {
                return Problem("Entity set 'netflexContext.Movies'  is null.");
            }
            var movie = await _context.Movies.FindAsync(id);
            if (movie != null)
            {
                _context.Movies.Remove(movie);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool MovieExists(int id)
        {
          return (_context.Movies?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}

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
    public class EpisodesController : Controller
    {
        private readonly netflexContext _context;

        public EpisodesController(netflexContext context)
        {
            _context = context;
        }

        // GET: Episodes
        public async Task<IActionResult> Index()
        {
            var netflexContext = _context.Episodes.Include(e => e.Movie);
            return View(await netflexContext.ToListAsync());
        }

        // GET: Episodes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Episodes == null)
            {
                return NotFound();
            }

            var episode = await _context.Episodes
                .Include(e => e.Movie)
                .FirstOrDefaultAsync(m => m.EpisodeId == id);
            if (episode == null)
            {
                return NotFound();
            }

            return View(episode);
        }

        // GET: Episodes/Create
        public IActionResult Create()
        {
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id");
            return View();
        }

        // POST: Episodes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("EpisodeId,Name,Link,MovieId")] Episode episode)
        {
            if (ModelState.IsValid)
            {
                _context.Add(episode);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", episode.MovieId);
            return View(episode);
        }

        // GET: Episodes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Episodes == null)
            {
                return NotFound();
            }

            var episode = await _context.Episodes.FindAsync(id);
            if (episode == null)
            {
                return NotFound();
            }
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", episode.MovieId);
            return View(episode);
        }

        // POST: Episodes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("EpisodeId,Name,Link,MovieId")] Episode episode)
        {
            if (id != episode.EpisodeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(episode);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EpisodeExists(episode.EpisodeId))
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
            ViewData["MovieId"] = new SelectList(_context.Movies, "Id", "Id", episode.MovieId);
            return View(episode);
        }

        // GET: Episodes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Episodes == null)
            {
                return NotFound();
            }

            var episode = await _context.Episodes
                .Include(e => e.Movie)
                .FirstOrDefaultAsync(m => m.EpisodeId == id);
            if (episode == null)
            {
                return NotFound();
            }

            return View(episode);
        }

        // POST: Episodes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Episodes == null)
            {
                return Problem("Entity set 'netflexContext.Episodes'  is null.");
            }
            var episode = await _context.Episodes.FindAsync(id);
            if (episode != null)
            {
                _context.Episodes.Remove(episode);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EpisodeExists(int id)
        {
          return (_context.Episodes?.Any(e => e.EpisodeId == id)).GetValueOrDefault();
        }
    }
}

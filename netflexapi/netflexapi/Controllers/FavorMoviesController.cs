using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using netflexapi.Models;

namespace netflexapi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FavorMoviesController : ControllerBase
    {
        private readonly netflexContext _context;

        public FavorMoviesController(netflexContext context)
        {
            _context = context;
        }

        // GET: api/FavorMovies
        [HttpGet]
        public async Task<ActionResult<IEnumerable<FavorMovie>>> GetFavorMovies()
        {
          if (_context.FavorMovies == null)
          {
              return NotFound();
          }
            return await _context.FavorMovies.ToListAsync();
        }


        // GET: api/FavorMovies/5
        [HttpGet("{id}")]
        public async Task<ActionResult<FavorMovie>> GetFavorMovie(int id)
        {
          if (_context.FavorMovies == null)
          {
              return NotFound();
          }
            var favorMovie = await _context.FavorMovies.FindAsync(id);

            if (favorMovie == null)
            {
                return NotFound();
            }

            return favorMovie;
        }

        // PUT: api/FavorMovies/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutFavorMovie(int id, FavorMovie favorMovie)
        {
            if (id != favorMovie.FavorId)
            {
                return BadRequest();
            }

            _context.Entry(favorMovie).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FavorMovieExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/FavorMovies
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<FavorMovie>> PostFavorMovie(FavorMovie favorMovie)
        {
          if (_context.FavorMovies == null)
          {
              return Problem("Entity set 'netflexContext.FavorMovies'  is null.");
          }
            _context.FavorMovies.Add(favorMovie);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (FavorMovieExists(favorMovie.FavorId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetFavorMovie", new { id = favorMovie.FavorId }, favorMovie);
        }

        // DELETE: api/FavorMovies/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteFavorMovie(int id)
        {
            if (_context.FavorMovies == null)
            {
                return NotFound();
            }
            var favorMovie = await _context.FavorMovies.FindAsync(id);
            if (favorMovie == null)
            {
                return NotFound();
            }

            _context.FavorMovies.Remove(favorMovie);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool FavorMovieExists(int id)
        {
            return (_context.FavorMovies?.Any(e => e.FavorId == id)).GetValueOrDefault();
        }
    }
}

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
    public class SubcriptionsController : ControllerBase
    {
        private readonly netflexContext _context;

        public SubcriptionsController(netflexContext context)
        {
            _context = context;
        }

        // GET: api/Subcriptions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Subcription>>> GetSubcriptions()
        {
          if (_context.Subcriptions == null)
          {
              return NotFound();
          }
            return await _context.Subcriptions.ToListAsync();
        }

        // GET: api/Subcriptions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Subcription>> GetSubcription(int id)
        {
          if (_context.Subcriptions == null)
          {
              return NotFound();
          }
            var subcription = await _context.Subcriptions.FindAsync(id);

            if (subcription == null)
            {
                return NotFound();
            }

            return subcription;
        }

        // PUT: api/Subcriptions/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSubcription(int id, Subcription subcription)
        {
            if (id != subcription.SubId)
            {
                return BadRequest();
            }

            _context.Entry(subcription).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubcriptionExists(id))
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

        // POST: api/Subcriptions
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Subcription>> PostSubcription(Subcription subcription)
        {
          if (_context.Subcriptions == null)
          {
              return Problem("Entity set 'netflexContext.Subcriptions'  is null.");
          }
            _context.Subcriptions.Add(subcription);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SubcriptionExists(subcription.SubId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetSubcription", new { id = subcription.SubId }, subcription);
        }

        // DELETE: api/Subcriptions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSubcription(int id)
        {
            if (_context.Subcriptions == null)
            {
                return NotFound();
            }
            var subcription = await _context.Subcriptions.FindAsync(id);
            if (subcription == null)
            {
                return NotFound();
            }

            _context.Subcriptions.Remove(subcription);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SubcriptionExists(int id)
        {
            return (_context.Subcriptions?.Any(e => e.SubId == id)).GetValueOrDefault();
        }
    }
}

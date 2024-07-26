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
    public class SubcriptionsController : Controller
    {
        private readonly netflexContext _context;

        public SubcriptionsController(netflexContext context)
        {
            _context = context;
        }

        // GET: Subcriptions
        public async Task<IActionResult> Index()
        {
              return _context.Subcriptions != null ? 
                          View(await _context.Subcriptions.ToListAsync()) :
                          Problem("Entity set 'netflexContext.Subcriptions'  is null.");
        }

        // GET: Subcriptions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Subcriptions == null)
            {
                return NotFound();
            }

            var subcription = await _context.Subcriptions
                .FirstOrDefaultAsync(m => m.SubId == id);
            if (subcription == null)
            {
                return NotFound();
            }

            return View(subcription);
        }

        // GET: Subcriptions/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Subcriptions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("SubId,SubName,SubPrice,Subdesc")] Subcription subcription)
        {
            if (ModelState.IsValid)
            {
                _context.Add(subcription);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(subcription);
        }

        // GET: Subcriptions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Subcriptions == null)
            {
                return NotFound();
            }

            var subcription = await _context.Subcriptions.FindAsync(id);
            if (subcription == null)
            {
                return NotFound();
            }
            return View(subcription);
        }

        // POST: Subcriptions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("SubId,SubName,SubPrice,Subdesc")] Subcription subcription)
        {
            if (id != subcription.SubId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(subcription);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SubcriptionExists(subcription.SubId))
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
            return View(subcription);
        }

        // GET: Subcriptions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Subcriptions == null)
            {
                return NotFound();
            }

            var subcription = await _context.Subcriptions
                .FirstOrDefaultAsync(m => m.SubId == id);
            if (subcription == null)
            {
                return NotFound();
            }

            return View(subcription);
        }

        // POST: Subcriptions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Subcriptions == null)
            {
                return Problem("Entity set 'netflexContext.Subcriptions'  is null.");
            }
            var subcription = await _context.Subcriptions.FindAsync(id);
            if (subcription != null)
            {
                _context.Subcriptions.Remove(subcription);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool SubcriptionExists(int id)
        {
          return (_context.Subcriptions?.Any(e => e.SubId == id)).GetValueOrDefault();
        }
    }
}

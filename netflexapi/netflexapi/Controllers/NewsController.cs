﻿using System;
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
    public class NewsController : ControllerBase
    {
        private readonly netflexContext _context;

        public NewsController(netflexContext context)
        {
            _context = context;
        }

        // GET: api/News
        [HttpGet]
        public async Task<ActionResult<IEnumerable<News>>> GetNews()
        {
          if (_context.News == null)
          {
              return NotFound();
          }
            return await _context.News.ToListAsync();
        }

        // GET: api/News/5
        [HttpGet("{id}")]
        public async Task<ActionResult<News>> GetNews(int id)
        {
          if (_context.News == null)
          {
              return NotFound();
          }
            var news = await _context.News.FindAsync(id);

            if (news == null)
            {
                return NotFound();
            }

            return news;
        }

        // PUT: api/News/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNews(int id, News news)
        {
            if (id != news.NewsId)
            {
                return BadRequest();
            }

            _context.Entry(news).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NewsExists(id))
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

        // POST: api/News
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<News>> PostNews(News news)
        {
          if (_context.News == null)
          {
              return Problem("Entity set 'netflexContext.News'  is null.");
          }
            _context.News.Add(news);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (NewsExists(news.NewsId))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetNews", new { id = news.NewsId }, news);
        }

        // DELETE: api/News/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNews(int id)
        {
            if (_context.News == null)
            {
                return NotFound();
            }
            var news = await _context.News.FindAsync(id);
            if (news == null)
            {
                return NotFound();
            }

            _context.News.Remove(news);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NewsExists(int id)
        {
            return (_context.News?.Any(e => e.NewsId == id)).GetValueOrDefault();
        }
    }
}

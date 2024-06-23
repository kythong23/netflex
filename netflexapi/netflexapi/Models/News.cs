using System;
using System.Collections.Generic;

namespace netflexapi.Models
{
    public partial class News
    {
        public int NewsId { get; set; }
        public string? NewsContent { get; set; }
        public string? NewsDateRelease { get; set; }
    }
}

﻿using System;
using System.Collections.Generic;
using System.Text;

namespace SeminarskiRSII.Model.Requests
{
   public class RecenzijaSearchRequest
    {
        public int? ocjena { get; set; }
        public int? BrojSobe { get; set; }
        public string? ImePrezime { get; set; }
        public int? sobaID { get; set; }
    }
}

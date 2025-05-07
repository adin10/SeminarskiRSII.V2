using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.Requests
{
    public class MarkAsReadRequest
    {
        public int NovostId { get; set; }
        public int GostId { get; set; }
    }
}

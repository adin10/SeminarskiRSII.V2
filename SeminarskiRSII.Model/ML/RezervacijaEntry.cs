using Microsoft.ML.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.Model.ML
{
    public class Copurchase_prediction
    {
        public float Score { get; set; }
    }
    public class RezervacijaEntry
    {
        [KeyType(count: 2000)]
        public uint SobaID { get; set; }
        [KeyType(count: 2000)]
        public uint CoPurchaseProductID { get; set; }
        public float Label { get; set; }
    }

    //public class CountMaterial
    //{
    //    public int EventSchoolId { get; set; }
    //    public int MaterialCount { get; set; }
    //}

    //public class EventSchoolMaterial
    //{
    //    public int EventSchoolId { get; set; }
    //    public int MaterialId { get; set; }
    //    public string MaterialName { get; set; }
    //}
}

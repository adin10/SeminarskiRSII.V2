using AutoMapper;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
    public class BaseService<TModel, TSearch, TDatabase> : IService<TModel, TSearch> where TDatabase : class
    {
        // BaseService je glavni servis u kojem napravimo get i getByID za svaki servis
        protected readonly IB210330Context _context;
        protected readonly IMapper _mapper;
        public BaseService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual List<TModel> get(TSearch search)
        {
            var list = _context.Set<TDatabase>().ToList();
            return _mapper.Map<List<TModel>>(list);
        }

        public virtual TModel getByID(int id)
        {
            var entity = _context.Set<TDatabase>().Find(id);
            return _mapper.Map<TModel>(entity);
        }
    }
}
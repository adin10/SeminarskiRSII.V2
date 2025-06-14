using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebAPI.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.WebApi.Services
{
    public class GostService:IGostService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public GostService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Gost> AuthenticirajGosta(string username, string pass)
        {
            var user =  await _context.Gost.Where(x => x.KorisnickoIme == username).FirstOrDefaultAsync();

            if (user != null)
            {
                var newHash =Util.PasswordGenerator.GenerateHash(user.LozinkaSalt, pass);

                if (newHash == user.LozinkaHash)
                {
                    return _mapper.Map<Model.Models.Gost>(user);
                }
            }
            return null;
        }

        //__________________________________________________________________

        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        //_____________________________________________________________________

        public async Task<List<Model.Models.Gost>> GetList(GostiSearchRequest search)
        {
            var query = _context.Gost.Include(g => g.Grad).AsQueryable();
            if (search != null)
            {
                if (search.gradID.HasValue)
                {
                    query = query.Where(v => v.GradId == search.gradID.Value);
                }
                if (!string.IsNullOrWhiteSpace(search?.ime))
                {
                    query = query.Where(x => x.Ime.ToLower().Contains(search.ime.ToLower()));
                }
                if (!string.IsNullOrWhiteSpace(search?.prezime))
                {
                    query = query.Where(x => x.Prezime.ToLower().Contains(search.prezime.ToLower()));
                }
                if (!string.IsNullOrWhiteSpace(search?.KorisnickoIme))
                {
                    query = query.Where(x => x.KorisnickoIme.ToLower().Contains(search.KorisnickoIme.ToLower()));
                }
                if (search.Status.HasValue)
                {
                    query = query.Where(x => x.Status == search.Status.Value);
                }
            }
            var gosti = await query.ToListAsync();

            var godinaUnazad = DateTime.Now.AddYears(-1);
            var mjesecDanaUnazad = DateTime.Now.AddDays(-30);

            var aktivniGostIdsPoRezervacijama = await _context.Rezervacija
                .Where(r => r.DatumRezervacije >= godinaUnazad)
                .Select(r => r.GostId)
                .Distinct()
                .ToListAsync();

            var aktivniGostIdsPoRegistraciji = await _context.Gost
                .Where(g => g.DatumRegistracije >= mjesecDanaUnazad)
                .Select(g => g.Id)
                .ToListAsync();

            var aktivniGostIds = aktivniGostIdsPoRezervacijama
                .Union(aktivniGostIdsPoRegistraciji)
                .ToHashSet();

            var gostIds = gosti.Select(x => x.Id).ToList();
            var ocjene = await _context.Recenzija.Where(x => gostIds.Contains(x.GostId))
                .GroupBy(x => x.GostId).Select(g => new
                {
                    GostId = g.Key,
                    ProsjecnaOcjena = g.Average(r => r.Ocjena)
                })
        .ToListAsync();

            var mapped = _mapper.Map<List<Model.Models.Gost>>(gosti);

            foreach (var gost in mapped)
            {
                var ocjena = ocjene.FirstOrDefault(o => o.GostId == gost.Id);
                gost.ProsjecnaOcjena = ocjena?.ProsjecnaOcjena;
                gost.Status = aktivniGostIds.Contains(gost.Id);
            }

            return mapped;
        }

        public async Task<Model.Models.Gost> Get(int id)
        {
            var entity = await _context.Gost.Include(a=>a.Grad).FirstOrDefaultAsync(x=>x.Id==id);
            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> Insert(GostiInsertRequest requst)
        {
            var entity = _mapper.Map<Database.Gost>(requst);
            if (requst.Lozinka != requst.PotvrdiLozinku)
            {
                throw new UserException("Lozinke se ne podudaraju");
            }
            entity.DatumRegistracije = DateTime.Now;
            entity.Status = true;
            entity.LozinkaSalt = Util.PasswordGenerator.GenerateSalt();
            entity.LozinkaHash = Util.PasswordGenerator.GenerateHash(entity.LozinkaSalt,requst.Lozinka);
            await _context.Gost.AddAsync(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> Update(int id, GostiInsertRequest request)
        {
            var entity = await _context.Gost.FindAsync(id);
            _context.Gost.Attach(entity);
            _context.Gost.Update(entity);
            if (!string.IsNullOrWhiteSpace(request.Lozinka))
            {
                if (request.Lozinka != request.PotvrdiLozinku)
                {
                    throw new Exception("Passwordi se ne slažu");
                }

                entity.LozinkaSalt =Util.PasswordGenerator.GenerateSalt();
                entity.LozinkaHash =Util.PasswordGenerator.GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }
            _mapper.Map(request, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> UpdateInformation(int id, GostiUpdateRequest request)
        {
            var entity = await _context.Gost.FindAsync(id);
            entity.Ime = request.Ime;
            entity.Prezime = request.Prezime;
            entity.KorisnickoIme = request.korisnickoIme;
            entity.Email = request.Email;
            entity.GradId = request.GradId;
            entity.Telefon = request.Telefon;
            //_context.Gost.Attach(entity);
            _context.Gost.Update(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> Delete(int id)
        {
            var entity = await _context.Gost.FindAsync(id);
            _context.Gost.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> ChangePassword(int id, ChangePasswordRequest request)
        {
            var entity = await _context.Gost.FirstOrDefaultAsync(x => x.Id == id);
            if (entity == null)
            {
                throw new UserException("User not found!");
            }

            // Check if the old password is correct
            if (entity.LozinkaHash != GenerateHash(entity.LozinkaSalt, request.OldPassword))
            {
                throw new UserException("Old password is incorrect!");
            }

            // Check if new password and confirmed new password match
            if (request.NewPassword != request.ConfirmNewPassword)
            {
                throw new UserException("New passwords do not match!");
            }

            // Generate new salt and hash for the new password
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.NewPassword);

            _context.SaveChanges();

            return _mapper.Map<Model.Models.Gost>(entity);
        }

        public async Task<Model.Models.Gost> UpdateUserProfile(int id, UpdateUserProfile request)
        {
            var gost = await _context.Gost.FindAsync(id);
            if(gost == null)
            {
                throw new UserException("Gost not found!");
            }

            gost.Email = request.Email;
            gost.KorisnickoIme = request.KorisnickoIme;
            gost.Telefon = request.Telefon;
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Gost>(gost);
        }
    }
}

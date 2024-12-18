using AutoMapper;
using SeminarskiRSII.Model.Requests;
using SeminarskiRSII.WebApi.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Text;
using SeminarskiRSII.WebApi.Interfaces;
using SeminarskiRSII.WebAPI.Exceptions;
using SeminarskiRSII.WebApi.Util;

namespace SeminarskiRSII.WebApi.Services
{
    public class OsobljeService : IOsobljeService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public OsobljeService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Model.Models.Osoblje> Authenticiraj(string username, string pass)
        {
            var user = await _context.Osoblje.Include(x=>x.OsobljeUloge).FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (user != null)
            {
                var newHash = GenerateHash(user.LozinkaSalt, pass);

                if (newHash == user.LozinkaHash)
                {
                    return _mapper.Map<Model.Models.Osoblje>(user);
                }
            }
            return null;
        }
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
        public async Task<List<Model.Models.Osoblje>> GetList(OsobljeSearchRequest search)
        {
            var query = _context.Osoblje.Include(x=>x.OsobljeUloge).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.ime))
            {
                query = query.Where(o => o.Ime.ToLower().Contains(search.ime.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.prezime))
            {
                query = query.Where(o => o.Prezime.ToLower().Contains(search.prezime.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.korisnickoIme))
            {
                query = query.Where(l => l.KorisnickoIme.ToLower().Contains(search.korisnickoIme.ToLower()));
            }

            var list = await query.ToListAsync();
            return _mapper.Map<List<Model.Models.Osoblje>>(list);
        }

        public async Task<Model.Models.Osoblje> Get(int id)
        {
            var entity = await _context.Osoblje.Include(x=>x.OsobljeUloge).ThenInclude(x=>x.VrstaOsoblja).Where(x => x.Id == id).FirstOrDefaultAsync();
            if (entity is null)
            {
                throw new UserException("Niije pronadjen korisnik!");
            }
            return _mapper.Map<Model.Models.Osoblje>(entity);
        }

        public async Task<Model.Models.Osoblje> Insert(OsobljeInsertRequest insert)
        {
            if (string.IsNullOrWhiteSpace(insert.Lozinka) || string.IsNullOrWhiteSpace(insert.PotvrdiLozinku))
            {
                string defaultPassword = PasswordGenerator.GenerateRandomPassword(12);
                insert.Lozinka = defaultPassword;
                insert.PotvrdiLozinku = defaultPassword;
            }

            var entity = _mapper.Map<Osoblje>(insert);

            if (insert.Lozinka != insert.PotvrdiLozinku)
            {
                throw new UserException("Lozinke se ne podudaraju");
            }
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt,insert.Lozinka);
            await _context.Osoblje.AddAsync(entity);
            _context.SaveChanges();
            foreach (var uloga in insert.Uloge)
            {
                Database.OsobljeUloge korisniciUloge = new OsobljeUloge{

                DatumIzmjene = DateTime.Now,
                OsobljeId = entity.Id,
                VrstaOsobljaId = uloga
                };
               await _context.OsobljeUloge.AddAsync(korisniciUloge);
               _context.SaveChanges();
            }
            return _mapper.Map<Model.Models.Osoblje>(entity);
        }

        public async Task<Model.Models.Osoblje> Update(int id, OsobljeInsertRequest request)
        {
            if (string.IsNullOrWhiteSpace(request.Lozinka) || string.IsNullOrWhiteSpace(request.PotvrdiLozinku))
            {
                string defaultPassword = PasswordGenerator.GenerateRandomPassword(12);
                request.Lozinka = defaultPassword;
                request.PotvrdiLozinku = defaultPassword;
            }

            var entity = await _context.Osoblje.FindAsync(id);
            if(entity != null)
            {
                _context.Osoblje.Attach(entity);
                _context.Osoblje.Update(entity);
            }

            //____________________________________________________________
            var korisnickeUloge = await _context.OsobljeUloge.Where(x => x.OsobljeId == id).ToListAsync();
            foreach(var item in korisnickeUloge)
            {
                _context.OsobljeUloge.Remove(item);
            }
            foreach(var uloga in request.Uloge)
            {
                OsobljeUloge korisniciUloge = new OsobljeUloge
                {
                    OsobljeId = entity.Id,
                    VrstaOsobljaId = uloga,
                    DatumIzmjene = DateTime.Now
                };
                await _context.OsobljeUloge.AddAsync(korisniciUloge);
            }
           await _context.SaveChangesAsync();
            //______________________________________________________
            if (!string.IsNullOrWhiteSpace(request.Lozinka))
            {
                if (request.Lozinka != request.PotvrdiLozinku)
                {
                    throw new Exception("Passwordi se ne slazu");
                }
                entity.LozinkaSalt =GenerateSalt();
                entity.LozinkaHash =GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }
            _mapper.Map(request, entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Osoblje>(entity);
        }

        public async Task<Model.Models.Osoblje> Delete(int id)
        {
            var entity = await _context.Osoblje.FindAsync(id);
            _context.Osoblje.Remove(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Models.Osoblje>(entity);
        }

        public async Task<Model.Models.Osoblje> ChangePassword(int id, ChangePasswordRequest request)
        {
            var entity = await _context.Osoblje.FirstOrDefaultAsync(x => x.Id == id);
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

            return _mapper.Map<Model.Models.Osoblje>(entity);
        }
    }
}

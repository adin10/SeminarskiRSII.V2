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
    public class LoginService:ILoginService
    {
        private readonly IB210330Context _context;
        private readonly IMapper _mapper;

        public LoginService(IB210330Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public Model.Models.Osoblje Authenticiraj(string username, string pass)
        {
            var user = _context.Osoblje.Include(x=>x.OsobljeUloge).FirstOrDefault(x => x.KorisnickoIme == username);

            if (user != null)
            {
                var newHash = Util.PasswordGenerator.GenerateHash(user.LozinkaSalt,pass);

                if (newHash == user.LozinkaHash)
                {
                    return _mapper.Map<Model.Models.Osoblje>(user);
                }
            }
            return null;
        }

        public Model.Models.Osoblje AuthenticirajGosta(string username, string pass)
        {
            var user = _context.Gost.FirstOrDefault(x => x.KorisnickoIme == username);

            if (user != null)
            {
                var newHash = Util.PasswordGenerator.GenerateHash(user.LozinkaSalt,pass);

                if (newHash == user.LozinkaHash)
                {
                    return _mapper.Map<Model.Models.Osoblje>(user);
                }
            }

            return null;
        }

        //____________________________________________________
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
    }
}

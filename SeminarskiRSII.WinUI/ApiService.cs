//using Flurl.Http;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using System.Windows.Forms;
//using SeminarskiRSII.Model;

//namespace SeminarskiRSII.WinUI
//{
//    public class ApiService
//    {
//        public static string KorisnickoIme { get; set; }
//        public static string Lozinka { get; set; }
//        private string _route;
//        public ApiService(string route)
//        {
//            _route = route;
//        }
//        public async Task<T> get<T>(object search)
//        {

//            var url = $"{ Properties.Settings.Default.ApiUrl }/{ _route}";
//            try
//            {
//                if (search != null)
//                {
//                    url = url + "?";
//                    url = url + await search.ToQueryString();
//                }
//                return await url.WithBasicAuth(KorisnickoIme, Lozinka).GetJsonAsync<T>();
//            }
//            catch (FlurlHttpException ex)
//            {
//                if (ex.Call.HttpStatus == System.Net.HttpStatusCode.Unauthorized)
//                {
//                    MessageBox.Show("Niste authentificirani");
//                }
//                throw;
//            }
//        }
//        public async Task<T> getByID<T>(object id)
//        {
//            var result = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";
//            return await result.WithBasicAuth(KorisnickoIme, Lozinka).GetJsonAsync<T>();
//        }
//        public async Task<T> Insert<T>(object search)
//        {
//            //var result = $"{Properties.Settings.Default.ApiUrl}/{_route}";
//            //return await result.WithBasicAuth(KorisnickoIme, Lozinka).PostJsonAsync(search).ReceiveJson<T>();

//            //var url = $"{Properties.Settings.Default.ApiUrl}/{_route}";
//            //try
//            //{
//            //    return await url.WithBasicAuth(KorisnickoIme, Lozinka).PostJsonAsync(search).ReceiveJson<T>();
//            //}
//            //catch (FlurlHttpException ex)
//            //{
//            //    var errors = await ex.GetResponseJsonAsync<Dictionary<string, string[]>>();

//            //    if (errors == null)
//            //    {
//            //        throw;
//            //    }
//            //    else
//            //    {
//            //        var stringBuilder = new StringBuilder();
//            //        foreach (var error in errors)
//            //        {
//            //            stringBuilder.AppendLine($"{error.Key}, ${string.Join(",", error.Value)}");
//            //        }

//            //        MessageBox.Show(stringBuilder.ToString(), "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
//            //    }




//            //    return default(T);

//            var url = $"{Properties.Settings.Default.ApiUrl}/{_route}";

//            try
//            {
//                return await url.WithBasicAuth(KorisnickoIme, Lozinka).PostJsonAsync(search).ReceiveJson<T>();
//            }
//            catch (FlurlHttpException ex)
//            {
//                throw new Exception(ex.Message);
//            }

//        }
//public async Task<T> Update<T>(object id, object request)
//{
//    var result = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";
//    return await result.WithBasicAuth(KorisnickoIme, Lozinka).PutJsonAsync(request).ReceiveJson<T>();
//}
//        public async Task<T> Update<T>(object id, object request)
//        {
//            //var url = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";

//            //try
//            //{
//            //    return await url.WithBasicAuth(KorisnickoIme, Lozinka).PutJsonAsync(request).ReceiveJson<T>();
//            //}
//            //catch (FlurlHttpException ex)
//            //{
//            //    var errors = await ex.GetResponseJsonAsync<Dictionary<string, string[]>>();

//            //    var stringBuilder = new StringBuilder();
//            //    foreach (var error in errors)
//            //    {
//            //        stringBuilder.AppendLine($"{error.Key}, ${string.Join(",", error.Value)}");
//            //    }

//            //    MessageBox.Show(stringBuilder.ToString(), "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
//            //    return default(T);
//            //}
//            try
//            {
//                var url = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";

//                return await url.WithBasicAuth(KorisnickoIme, Lozinka).PutJsonAsync(request).ReceiveJson<T>();
//            }
//            catch (FlurlHttpException ex)
//            {
//                throw new Exception(ex.Message);
//            }
//        }
//    }
//}



using Flurl.Http;
using SeminarskiRSII.Model;
using SeminarskiRSII.Model.Models;
using SeminarskiRSII.WinUI.Properties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SeminarskiRSII.WinUI
{
    public class ApiService
    {
        public static string Username { get; set; }
        public static string Password { get; set; }

        private readonly string _route;
        public ApiService(string route)
        {
            _route = route;
        }

        public async Task<T> get<T>(object search)
        {
            var url = $"{Properties.Settings.Default.ApiUrl}/{_route}";

            try
            {
                if (search != null)
                {
                    url += "?";
                    url += await search.ToQueryString();
                }

                return await url.WithBasicAuth(Username, Password).GetJsonAsync<T>();
            }
            catch (FlurlHttpException ex)
            {
                if (ex.Call.Response.ResponseMessage.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    MessageBox.Show("Pogresan Username ili Password");
                }
                throw;
            }
        }

        public async Task<T> getByID<T>(object id)
        {
            var url = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";

            return await url.WithBasicAuth(Username, Password).GetJsonAsync<T>();
        }

        public async Task<T> Delete<T>(object id)
        {
            var url = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";
            return await url.WithBasicAuth(Username, Password).DeleteAsync().ReceiveJson<T>();
        }

        public async Task<T> Insert<T>(object request)
        {
            var url = $"{Properties.Settings.Default.ApiUrl}/{_route}";

            try
            {
                return await url.WithBasicAuth(Username, Password).PostJsonAsync(request).ReceiveJson<T>();
            }
            catch (FlurlHttpException ex)
            {
                throw new Exception(ex.Message);
            }

        }

        //public async Task<T> Update<T>(int id, object request)
        //{
        //    try
        //    {
        //        var url = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";

        //        return await url.WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<T>();
        //    }
        //    catch (FlurlHttpException ex)
        //    {
        //        throw new Exception(ex.Message);
        //    }
        //}
        public async Task<T> Update<T>(object id, object request)
        {
            try
            {
                var result = $"{Properties.Settings.Default.ApiUrl}/{_route}/{id}";
            return await result.WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<T>();
            }
            catch (FlurlHttpException ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}


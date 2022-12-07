using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SeminarskiRSII.WinUI.Helper
{
   public class ImageHelper
    {
        public static byte[] FromImageToByte(Image image)
        {
            MemoryStream ms = new MemoryStream();
            image.Save(ms, ImageFormat.Png);

            return ms.ToArray();
        }

        public static Image FromByteToImage(byte[] img)
        {
            MemoryStream ms = new MemoryStream(img);

            return Image.FromStream(ms);
        }
    }
}

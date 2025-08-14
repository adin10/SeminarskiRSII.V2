using System;
using System.Text;

public class StripeSettings
{
    private string _secretKey;

    public string SecretKey
    {
        get => DecodeBase64(_secretKey);
        set => _secretKey = value;
    }

    private string DecodeBase64(string encoded)
    {
        if (string.IsNullOrWhiteSpace(encoded))
            return encoded;

        try
        {
            var bytes = Convert.FromBase64String(encoded);
            return Encoding.UTF8.GetString(bytes);
        }
        catch
        {
            return encoded;
        }
    }
}

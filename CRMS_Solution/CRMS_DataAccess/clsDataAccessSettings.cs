using System;
using System.Configuration;

namespace CRMS_DataAccess
{
    public static class clsDataAccessSettings
    {
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
    }
}
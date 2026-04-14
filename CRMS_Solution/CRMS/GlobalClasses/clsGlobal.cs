using CRMS_Business;
using Microsoft.Win32;
using System;
using System.IO;

namespace CRMS.GlobalClasses
{
    public class clsGlobal
    {
        public static clsUser CurrentUser = null;

        public static bool RememberUserNameAndPassword(string UserName, string Password)
        {
            string KeyPath = @"HKEY_CURRENT_USER\SOFTWARE\CRMS\UserAccount";
            string ValueUserName = "UserName";
            string ValuePassword = "Password";
            string DataUserName = UserName;
            string DataPassword = Password;

            try
            {
                Registry.SetValue(KeyPath, ValueUserName, DataUserName);
                Registry.SetValue(KeyPath, ValuePassword, DataPassword);
                return true;
            }
            catch (Exception)
            {
                return false;
                // Event Viewer
            }
        }

        public static bool GetStoredUserNameAndPasswordFromRegistry(ref string UserName, ref string Password)
        {
            string KeyPath = @"HKEY_CURRENT_USER\SOFTWARE\CRMS\UserAccount";
            string ValueUserName = "UserName";
            string ValuePassword = "Password";

            try
            {
                string DataUserName = Registry.GetValue(KeyPath, ValueUserName, null) as string;
                string DataPassword = Registry.GetValue(KeyPath, ValuePassword, null) as string;

                if(DataUserName != null && DataPassword != null)
                {
                    UserName = DataUserName;
                    Password = DataPassword;
                    return true;
                }

                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool DeleteUserAccountFromRegistry()
        {
            string KeyPath = @"SOFTWARE\CRMS\UserAccount";
            string ValueUserName = "UserName";
            string ValuePassword = "Password";


            try
            {
                using(RegistryKey baseKey = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry64))
                {
                    using(RegistryKey subKey = baseKey.OpenSubKey(KeyPath, true))
                    {
                        if(subKey != null)
                        {
                            string DataUserName = subKey.GetValue(ValueUserName, null) as string;
                            string DataPassword = subKey.GetValue(ValuePassword, null) as string;

                            if(DataUserName != null && DataPassword != null)
                            {
                                subKey.DeleteValue(ValueUserName);
                                subKey.DeleteValue(ValuePassword);

                                return true;
                            }
                            return false;
                        }

                        return false;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
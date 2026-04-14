using System;
using System.IO;

namespace CRMS.GlobalClasses
{
    public class clsUtil
    {
        public static string GenerateGUID()
        {
            return Guid.NewGuid().ToString();
        }

        public static string ReplaceFileNameToGUID(string SourceFile, string FolderImages)
        {
            FileInfo fileInfo = new FileInfo(SourceFile);
            string Extension = fileInfo.Extension;
            return $"{FolderImages}\\{GenerateGUID() + Extension}";
        }

        public static bool CreateFolderDoesNotFound(string FolderImages)
        {
            string FolderPeopleImages = FolderImages;

            if (Directory.Exists(FolderPeopleImages))
                return true;

            Directory.CreateDirectory(FolderPeopleImages);
            return true;
        }

        public static bool CopyImageToFolderImages(ref string SourceFile, string FolderImages)
        {
            if (!CreateFolderDoesNotFound(FolderImages))
                return false;

            string destFileName = ReplaceFileNameToGUID(SourceFile, FolderImages);

            try
            {
                File.Copy(SourceFile, destFileName, true);
            }
            catch (Exception)
            {
                return false;
            }

            SourceFile = destFileName;
            return true;
        }

        public static string EncryptPassword(string Password, int Key = 3)
        {
            string EncryptedPassword = string.Empty;

            for (int Character = 0; Character < Password.Length; Character++)
            {
                EncryptedPassword += (char)(Password[Character] + (char)Key);
            }
            return EncryptedPassword;
        }

        public static string DecryptPassword(string Password, int Key = 3)
        {
            string DecryptedPassword = string.Empty;

            for (int Character = 0; Character < Password.Length; Character++)
            {
                DecryptedPassword += (char)(Password[Character] - (char)Key);
            }
            return DecryptedPassword;
        }
    }
}
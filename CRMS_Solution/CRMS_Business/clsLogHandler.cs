using CRMS_DataAccess;

namespace CRMS_Business
{
    public static class clsLogHandler
    {
        public static void Log(string Subject, string Message)
        {
            clsEventLogHandler.LogException(Subject, Message);
        }
    }
}
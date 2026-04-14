using System;
using System.Diagnostics;
using System.Configuration;

namespace CRMS_DataAccess
{
    public static class clsEventLogHandler
    {
        private static string _AppSource = ConfigurationManager.AppSettings["AppSource"];

        public static void LogException(string Subject, string Message)
        {
            try
            {
                if (!EventLog.SourceExists(_AppSource))
                    EventLog.CreateEventSource(_AppSource, "Application");

                string FullMessage = $"Subject : {Subject}\nMessage : {Message}";

                EventLog.WriteEntry(_AppSource, FullMessage, EventLogEntryType.Error);
            }
            catch (Exception)
            {
            }
        }
    }
}
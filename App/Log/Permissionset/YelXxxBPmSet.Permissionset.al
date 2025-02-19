permissionset 50000 "YelXxx BPmSet"
{
    Assignable = true;
    Permissions =
        table "YelBas Log Entry" = X,
        tabledata "YelBas Log Entry" = RMID,
            page "YelBas Log Entry Card" = X,
            page "YelBas Log Entries" = X,
            codeunit "YelBas Log" = X,
            codeunit "YelBas DownloadDataFromLog" = X,
            codeunit "YelBas GetLogData" = X,
            codeunit "YelBas GetLogJsonData" = X,
            codeunit "YelBas Clear Log" = X;
}
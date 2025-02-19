namespace YellowSolution.Y365Base.Log;
using System.Utilities;

/// <summary>
/// Handles log cleanup 
/// </summary>
codeunit 54750 "YelBas Clear Log"
{
    /// <summary> 
    /// Clear log
    /// </summary>
    procedure Clear()
    var
        LogEntry: Record "YelBas Log Entry";
        ConfirmMgt: Codeunit "Confirm Management";
        ClearQst: Label 'Are you sure you want to clear the log?';
        IsHandled: Boolean;
    begin

        if not ConfirmMgt.GetResponse(ClearQst, IsHandled) then
            exit;

        OnBeforeClear(LogEntry, IsHandled);

        DoClear(LogEntry, IsHandled);

        OnAfterClear(LogEntry);
    end;

    /// <summary>
    /// Clear log
    /// </summary>
    /// <param name="LogEntry"></param>
    /// <param name="IsHandled"></param>
    local procedure DoClear(var LogEntry: Record "YelBas Log Entry"; IsHandled: Boolean)
    var
        ClearedMsg: Label 'The log is now cleared!';
    begin
        if IsHandled then
            exit;

        LogEntry.DeleteAll(true);
        Message(ClearedMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeClear(var LogEntry: Record "YelBas Log Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterClear(var LogEntry: Record "YelBas Log Entry")
    begin
    end;
}
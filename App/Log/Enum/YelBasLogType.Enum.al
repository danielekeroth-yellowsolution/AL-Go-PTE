namespace YellowSolution.Y365Base.Log;

/// <summary>
/// Log Type
/// </summary>
enum 54750 "YelBas Log Type"
{
    Extensible = true;
    Caption = 'Log Type';

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Error") { Caption = 'Error'; }
    value(2; "Warning") { Caption = 'Warning'; }
    value(3; "Info") { Caption = 'Info'; }
    value(4; "Trace") { Caption = 'Trace'; }
}
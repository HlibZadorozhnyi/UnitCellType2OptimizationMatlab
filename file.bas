Option Explicit
Sub Main ()
OpenFile ("C:\Work\MatlabApps\UnitCellType2OptimizationMatlab\Results\Function_Evaluation_000081\unitcell.cst")
StoreDoubleParameter ("Wline", 0.972)
StoreDoubleParameter ("Wgap1", 1.058)
StoreDoubleParameter ("Wgap2", 1.120)
StoreDoubleParameter ("Wgap3", 1.457)
StoreDoubleParameter ("Wgap4", 1.940)
StoreDoubleParameter ("Wgap5", 1.632)
StoreDoubleParameter ("Wgap6", 1.688)
Rebuild
SimulationTask.Name("SPara1")
SimulationTask.Update
End Sub

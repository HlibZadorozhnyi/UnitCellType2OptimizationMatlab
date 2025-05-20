Option Explicit
Sub Main ()
OpenFile ("C:\Work\MatlabApps\UnitCellType2OptimizationMatlab\Results\Function_Evaluation_000015\unitcell.cst")
StoreDoubleParameter ("Wline", 1.100)
StoreDoubleParameter ("Wgap1", 2.000)
StoreDoubleParameter ("Wgap2", 1.048)
StoreDoubleParameter ("Wgap3", 0.884)
StoreDoubleParameter ("Wgap4", 1.576)
StoreDoubleParameter ("Wgap5", 0.771)
StoreDoubleParameter ("Wgap6", 1.968)
Rebuild
SimulationTask.Name("SPara1")
SimulationTask.Update
End Sub

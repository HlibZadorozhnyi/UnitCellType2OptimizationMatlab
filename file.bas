Option Explicit
Sub Main ()
OpenFile ("C:\Work\MatlabApps\UnitCellType2OptimizationMatlab\CST\unitcell.cst")
DeleteResults
StoreDoubleParameter ("Wline", 0.967)
StoreDoubleParameter ("Wgap1", 1.554)
StoreDoubleParameter ("Wgap2", 0.759)
StoreDoubleParameter ("Wgap3", 0.926)
StoreDoubleParameter ("Wgap4", 1.980)
StoreDoubleParameter ("Wgap5", 1.466)
StoreDoubleParameter ("Wgap6", 1.381)
StoreDoubleParameter ("Wgap7", 0.350)
StoreDoubleParameter ("Wgap8", 1.613)
StoreDoubleParameter ("Wgap9", 1.236)
StoreDoubleParameter ("Wgap10", 0.230)
StoreDoubleParameter ("Wgap11", 1.951)
StoreDoubleParameter ("Wgap12", 1.395)
StoreDoubleParameter ("Wgap13", 0.708)
Rebuild
SimulationTask.Name("Sweep1")
SimulationTask.Update
End Sub

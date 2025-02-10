'# MWS Version: Version 2024.1 - Oct 16 2023 - ACIS 33.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 7 fmax = 15
'# created = '[VERSION]2024.1|33.0.1|20231016[/VERSION]


'@ define material: Copper (pure)

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Material
     .Reset
     .Name "Copper (pure)"
     .Folder ""
     .FrqType "all"
     .Type "Lossy metal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Mu "1.0"
     .Sigma "5.96e+007"
     .Rho "8930.0"
     .ThermalType "Normal"
     .ThermalConductivity "401.0"
     .SpecificHeat "390", "J/K/kg"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Isotropic"
     .YoungsModulus "120"
     .PoissonsRatio "0.33"
     .ThermalExpansionRate "17"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .FrqType "static"
     .Type "Normal"
     .SetMaterialUnit "Hz", "mm"
     .Epsilon "1"
     .Mu "1.0"
     .Kappa "5.96e+007"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .KappaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .DispersiveFittingSchemeMu "Nth Order"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .Colour "1", "1", "0"
     .Wireframe "False"
     .Reflection "False"
     .Allowoutline "True"
     .Transparentoutline "False"
     .Transparency "0"
     .Create
End With

'@ define material: IS400

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Material 
     .Reset 
     .Name "IS400"
     .Folder ""
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .Absorptance "0"
     .MechanicsType "Unused"
     .IntrinsicCarrierDensity "0"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "degC"
     .Epsilon "4.43"
     .Mu "1"
     .Sigma "0.0"
     .TanD "0.0189"
     .TanDFreq "10"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0", "1", "1" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ new component: Bottom

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Component.New "Bottom"

'@ define brick: Bottom:solid1

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "Bottom" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "W/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "0", "th" 
     .Create
End With

'@ new component: Substrate

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Component.New "Substrate"

'@ define brick: Substrate:solid2

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "Substrate" 
     .Material "IS400" 
     .Xrange "-W/2", "W/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "th", "th+h" 
     .Create
End With

'@ define material colour: IS400

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Material 
     .Name "IS400"
     .Folder ""
     .Colour "1", "0", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ new component: Top

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Component.New "Top"

'@ define brick: Top:solid3

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-Wline/2", "Wline/2" 
     .Yrange "-L/2", "L/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid4

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap7", "W/2" 
     .Yrange "Lpad/2", "-Lpad/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid5

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid5" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap7" 
     .Yrange "-Lpad/2", "Lpad/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid6

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid6" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap8", "W/2" 
     .Yrange "Lpad/2", "Lpad/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid7

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid7" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap8" 
     .Yrange "Lpad/2", "Lpad/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid8" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap6", "W/2" 
     .Yrange "-Lpad/2-Lpad", "-Lpad/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid9" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap6" 
     .Yrange "-Lpad/2-Lpad", "-Lpad/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid10" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap5", "W/2" 
     .Yrange "-Lpad*3/2-Lpad", "-Lpad*3/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid11" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap5" 
     .Yrange "-Lpad*3/2-Lpad", "-Lpad*3/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid12" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap4", "W/2" 
     .Yrange "-Lpad*5/2-Lpad", "-Lpad*5/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid13" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap4" 
     .Yrange "-Lpad*5/2-Lpad", "-Lpad*5/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid14" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap3", "W/2" 
     .Yrange "-Lpad*7/2-Lpad", "-Lpad*7/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid15" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap3" 
     .Yrange "-Lpad*7/2-Lpad", "-Lpad*7/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid16" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap2", "W/2" 
     .Yrange "-Lpad*9/2-Lpad", "-Lpad*9/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid17" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap2" 
     .Yrange "-Lpad*9/2-Lpad", "-Lpad*9/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid18" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap1", "W/2" 
     .Yrange "-L/2", "-Lpad*11/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid19" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap1" 
     .Yrange "-L/2", "-Lpad*11/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid20" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap9", "W/2" 
     .Yrange "Lpad*3/2", "Lpad*3/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid21" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap9" 
     .Yrange "Lpad*3/2", "Lpad*3/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid22" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap10", "W/2" 
     .Yrange "Lpad*5/2", "Lpad*5/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid23" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap10" 
     .Yrange "Lpad*5/2", "Lpad*5/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid24" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap11", "W/2" 
     .Yrange "Lpad*7/2", "Lpad*7/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid25" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap11" 
     .Yrange "Lpad*7/2", "Lpad*7/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid26" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap12", "W/2" 
     .Yrange "Lpad*9/2", "Lpad*9/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid27" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap12" 
     .Yrange "Lpad*9/2", "Lpad*9/2+Lpad" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid28" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "Wline/2+Wgap13", "W/2" 
     .Yrange "Lpad*11/2", "L/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ define brick: Top:solid8

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Brick
     .Reset 
     .Name "solid29" 
     .Component "Top" 
     .Material "Copper (pure)" 
     .Xrange "-W/2", "-Wline/2-Wgap13" 
     .Yrange "Lpad*11/2", "L/2" 
     .Zrange "th+h", "th*2+h" 
     .Create
End With

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid10", "49"

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid10", "75"

'@ define background

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0.0" 
     .ZmaxSpace "D" 
     .ApplyInAllDirections "False" 
End With 

With Material 
     .Reset 
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .Absorptance "0"
     .MechanicsType "Unused"
     .IntrinsicCarrierDensity "0"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "m"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "K"
     .Epsilon "1.0"
     .Mu "1.0"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstSigma"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With

'@ define frequency range

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Solver.FrequencyRange "7", "15"

'@ define boundaries

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Boundary
     .Xmin "electric"
     .Xmax "electric"
     .Ymin "magnetic"
     .Ymax "magnetic"
     .Zmin "conducting wall"
     .Zmax "open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
     .ApplyInAllDirections "False"
     .WallConductivity "1000"
End With

'@ define material: IS400

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Material 
     .Reset 
     .Name "IS400"
     .Folder ""
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .Absorptance "0"
     .MechanicsType "Unused"
     .IntrinsicCarrierDensity "0"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "degC"
     .Epsilon "4.43"
     .Mu "1"
     .Sigma "0.0"
     .TanD "0.0189"
     .TanDFreq "10"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "0", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define material colour: IS400

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Material 
     .Name "IS400"
     .Folder ""
     .Colour "1", "0", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeColour 
End With

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid5", "1"

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid3", "3"

'@ define discrete port: 1

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "1" 
     .Type "SParameter"
     .Label ""
     .Folder ""
     .Impedance "50.0"
     .Voltage "1.0"
     .Current "1.0"
     .Monitor "True"
     .Radius "0.0"
     .SetP1 "True", "-1.35", "0", "0.97"
     .SetP2 "True", "-1", "0", "0.97"
     .InvertDirection "False"
     .LocalCoordinates "False"
     .Wire ""
     .Position "end1"
     .Create 
End With

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid4", "3"

'@ pick mid point

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Pick.PickMidpointFromId "Top:solid3", "1"

'@ define discrete port: 2

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With DiscretePort 
     .Reset 
     .PortNumber "2" 
     .Type "SParameter"
     .Label ""
     .Folder ""
     .Impedance "50.0"
     .Voltage "1.0"
     .Current "1.0"
     .Monitor "True"
     .Radius "0.0"
     .SetP1 "True", "1.35", "0", "0.97"
     .SetP2 "True", "1", "0", "0.97"
     .InvertDirection "False"
     .LocalCoordinates "False"
     .Wire ""
     .Position "end1"
     .Create 
End With

'@ define port: 3

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
With Port 
     .Reset 
     .PortNumber "3" 
     .Label ""
     .Folder ""
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Full"
     .Orientation "zmax"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "-5", "5"
     .Yrange "-5", "5"
     .Zrange "15.97", "15.97"
     .XrangeAdd "0.0", "0.0"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ set pba mesh type

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
Mesh.MeshType "PBA"

'@ change solver type

'[VERSION]2024.1|33.0.1|20231016[/VERSION]
ChangeSolverType "HF Time Domain"


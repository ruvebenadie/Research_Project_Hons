# coding: utf-8
import arcpy
import os
#set workspace
arcpy.env.workspace = "C:/Users/ruveb/Downloads/ArcPy"
arcpy.env.overwriteOutput = True
arcpy.addOutputsToMap = True

#Select different types and save new layer
Footpath = arcpy.SelectLayerByAttribute_management("Polygon_23_MA", "NEW_SELECTION", 
                                        "Type = 0")
Footpath = arcpy.management.CopyFeatures("Polygon_23_MA", "MyProject26.gdb/Footpath")
Vehicular = arcpy.SelectLayerByAttribute_management("Polygon_23_MA", "NEW_SELECTION", 
                                        "Type = 1")
Vehicular = arcpy.management.CopyFeatures("Polygon_23_MA", "MyProject26.gdb/Vehicular")
Alley = arcpy.SelectLayerByAttribute_management("Polygon_23_MA", "NEW_SELECTION", 
                                        "Type = 2")
Alley = arcpy.management.CopyFeatures("Polygon_23_MA", "MyProject26.gdb/Alley")

#Singlepart to multipart
Single_Foot = arcpy.MultipartToSinglepart_management("Footpath",  "MyProject26.gdb/single_foot")
Single_Vech = arcpy.MultipartToSinglepart_management("Vehicular",  "MyProject26.gdb/single_vech")
centerline_foot = arcpy.topographic.PolygonToCenterline("single_foot", "MyProject26.gdb/foot_cnrline")

#Extract centrelines
centerline_alley = arcpy.topographic.PolygonToCenterline("Alley", "MyProject26.gdb/alley_cnrline")
centerline_vech = arcpy.topographic.PolygonToCenterline("single_vech", "MyProject26.gdb/vech_cnrline")
centerline_alley = arcpy.topographic.PolygonToCenterline("single_alley", "MyProject26.gdb/alley_cnrline")

#Buffer back to polygon 
clean_footpath = arcpy.analysis.Buffer("foot_cnrline", "MyProject26.gdb/clean_footpath", "0.2 meters", "Full", "Round", "All")
clean_alley = arcpy.analysis.Buffer("alley_cnrline", "MyProject26.gdb/clean_alley", "0.2 meters", "Full", "Round", "All")
clean_vehicular = arcpy.analysis.Buffer("vech_cnrline", "MyProject26.gdb/clean_vehicular", "1 meters", "Full", "Round", "All")

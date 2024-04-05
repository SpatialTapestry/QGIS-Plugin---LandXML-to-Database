# -*- coding: utf-8 -*-
#
################################################################################
#
# Copyright
# Spatial Tapestry
# All rights reserved
#
# This program is released under the terms of the new BSD license. See the 
# LICENSE file for more information.
#
################################################################################

from PyQt5.QtCore import *
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from qgis.core import *

from shapely.geometry import MultiPolygon,MultiLineString,LinearRing,LineString
import shapely.wkt

from . import LandXml


def _saveMonuments(self,landxml, **myGBL):
    insSql = "Insert into " + myGBL['PG_Schema'] + ".stt_dp_monument"
    insSql = insSql + " (geom_orig,planlabel,monumentname,state,pntref,type,datecollected,ctrlclass,ctrlorder) values ("

    fromCRS = QgsCoordinateReferenceSystem(myGBL['a57'])
    destCRS = QgsCoordinateReferenceSystem(myGBL['l3l'])
    ct = QgsCoordinateTransform(fromCRS, destCRS, QgsProject.instance())
    
    name = "LandXml_marks"
    uri="Point?"+"&".join(['field='+x for x in (
        'mrk_id:int')])

    vl = QgsVectorLayer(uri,name,"memory")
    vl.startEditing()
    fields=vl.fields()
    pr=vl.dataProvider()
    
    retList = list()
    retList.append("delete from " + myGBL['PG_Schema'] + ".stt_dp_monument where planlabel = '" + landxml._SurveyHeader['name'] + "';")
    
    for mark in landxml.monuments():
        try:
            (x,y) = mark.point().coords()
            fet = QgsFeature(fields)
            fet.setGeometry(QgsGeometry.fromPointXY(QgsPointXY(x,y)))
            geom = fet.geometry()
            geom.transform(ct)
            geom_asWkt = geom.asWkt()

            t2t = "st_setSRID(ST_GeomFromText('" + geom_asWkt + "')," + myGBL['l3l'].replace("EPSG:","") + "),"
            t2t = t2t + "'" + landxml._SurveyHeader['name'] + "',"
            t2t = t2t + "'" + mark.name() + "',"
            t2t = t2t + "'" + mark.state() + "',"
            t2t = t2t + "'" + mark.point().id() + "',"
            t2t = t2t + "'" + mark.type() + "',"
            if landxml._SurveyHeader['adminDate'] == "":
                t2t = t2t + "null," # datecollected
            else:
                t2t = t2t + "'" + landxml._SurveyHeader['adminDate'] + "'," # datecollected
            t2t = t2t + "'" + mark.point().classx() + "',"
            t2t = t2t + "'" + mark.point().order() + "')"
            retList.append(insSql + t2t + ";")

        except Exception as e:
            raise RuntimeError("Parcel "+mark.name()+": "+str(e))
    return retList


def _saveParcelLayer(self, landxml, **myGBL):

    insSql = "Insert into " + myGBL['PG_Schema'] + ".stt_dp_parcel"
    insSql = insSql + " (geom_orig,planlabel,sectionname,parcelname,datecollected,class,state,"
    insSql = insSql + "parceltype,parcelformat,center_pref,cent_orig,numpnts,description) values ("

    fromCRS = QgsCoordinateReferenceSystem(myGBL['a57'])
    destCRS = QgsCoordinateReferenceSystem(myGBL['l3l'])
    ct = QgsCoordinateTransform(fromCRS, destCRS, QgsProject.instance())

    parcel_layers={
        'MultiPolygon':{'name':'LandXml_parcels','layer':None,'geomfunc':MultiPolygon},
        'MultiLineString':{'name':'LandXml_linear_parcels','layer':None,'geomfunc':MultiLineString},
        }

    uri='&'.join(['field='+x for x in (
        'lolid:int')])
    epsg = landxml.coordSysEpsgId()
    if epsg:
        uri += '&crs=epsg:'+str(epsg)

    retList = list()
    retList.append("delete from " + myGBL['PG_Schema'] + ".stt_dp_parcel where planlabel = '" + landxml._SurveyHeader['name'] + "';")

    for parcel in landxml.parcels():
        try:
            gtype=parcel.geomtype()
            if not gtype in parcel_layers:
                raise RuntimeError("Cannot handle parcel geometry type "+str(gtype))
            glayer=parcel_layers[gtype]
            if glayer['layer'] is None:
                glayer['layer']=QgsVectorLayer(gtype+"?"+uri,glayer['name'],'memory')
            vl=glayer['layer']
            fields=vl.fields()
            pr=vl.dataProvider()
            fet = QgsFeature(fields)
            geomwkt=shapely.wkt.dumps(glayer['geomfunc'](parcel.coords()))
            # test if it is valid to convert to a polygon - it should be
            if "TIPO" in geomwkt:
                geomraw = geomwkt.replace(")))","")
                if not ")" in geomraw:
                    geomwkt = geomwkt.replace("MULTI","").replace("(((","((").replace(")))","))")
            elif "TILI" in geomwkt:
                geomraw = geomwkt.replace("))","")
                if not ")" in geomraw:
                    geomwkt = geomwkt.replace("MULTI","").replace("((","(").replace("))",")")

            fet.setGeometry(QgsGeometry.fromWkt(geomwkt))
            geom = fet.geometry()
            geom.transform(ct)
            geom_asWkt = geom.asWkt()

            t2t = "st_setSRID(ST_GeomFromText('" + geom_asWkt + "')," + myGBL['l3l'].replace("EPSG:","") + "),"

            t2t = t2t + "'" + landxml._SurveyHeader['name'] + "',"

            # fet['area']=parcel.area() 
            if parcel.name() is None:
                parcel.name=""
            if parcel.state() is None:
                parcel.state=""
            if parcel.pclass() is None:
                parcel.pclass=""
            if parcel.type() is None:
                parcel.type=""
            if parcel.description() is None:
                parcel.description=""
            if landxml._SurveyHeader['adminDate'] is None:
                landxml._SurveyHeader['adminDate']=""
            #QMessageBox.information(None,"_saveParcelLayer",parcel.name() + " " + parcel.type(), QMessageBox.Ok, QMessageBox.Ok)
            sectName = parcel.name()
            if len(sectName) > 10:
              sectName = sectName[1:10]
            t2t = t2t + "'" + sectName + "',"        # sectionname
            t2t = t2t + "'" + parcel.name() + "',"        # lotname
            if landxml._SurveyHeader['adminDate'] == "":
                t2t = t2t + "null," # datecollected
            else:
                t2t = t2t + "'" + landxml._SurveyHeader['adminDate'] + "'," # datecollected
            t2t = t2t + "'" + parcel.pclass() + "',"      # class
            t2t = t2t + "'" + parcel.state() + "',"       # state
            t2t = t2t + "'" + parcel.type() + "',"        # parceltype
            t2t = t2t + "'" + parcel.type() + "',"        # parcelformat
            t2t = t2t + "null,"     # center_pref
            t2t = t2t + "null,"     # cent_orig
            t2t = t2t + "0,"        # numpnts
            t2t = t2t + "'" + parcel.description() + "')" # description
            retList.append(insSql + t2t + ";")

        except Exception as e:
            raise RuntimeError("Parcel "+parcel.name()+": "+str(e))
    return retList


def _saveObsLayer(self,landxml, **myGBL):

    insSql = "Insert into " + myGBL['PG_Schema'] + ".stt_dp_surveyline"
    insSql = insSql + " (lineno,geom_orig,pointno1,setupid,pointno2,targetsetupid,planlabel,isvalid,"
    insSql = insSql + "  titlebear,titledist,titleradius,title_dms,linetype,useinlsa,purpose) values ("

    fromCRS = QgsCoordinateReferenceSystem(myGBL['a57'])
    destCRS = QgsCoordinateReferenceSystem(myGBL['l3l'])
    ct = QgsCoordinateTransform(fromCRS, destCRS, QgsProject.instance())

    name = "LandXml_observations"
    uri="LineString?"+"&".join(['field='+x for x in (
        'from:string'
        )])
    epsg = landxml.coordSysEpsgId()
    if epsg:
        uri += '&crs=epsg:'+str(epsg)
    vl = QgsVectorLayer(uri,name,"memory")
    # Need to do something about crs()
    vl.startEditing()
    fields=vl.fields()
    pr=vl.dataProvider()
    count = 0

    retList = list()
    retList.append("delete from " + myGBL['PG_Schema'] + ".stt_dp_surveyline where planlabel = '" + landxml._SurveyHeader['name'] + "';")

    for obs in landxml.observations():
        try:
            fet = QgsFeature(fields)
            fet.setGeometry(QgsGeometry.fromPolyline(
                [QgsPoint(x,y) for x,y in obs.coords()]))

            geom = fet.geometry()
            geom.transform(ct)
            geom_asWkt = geom.asWkt()

            count =count + 1
            t2t = str(count) + ",st_setSRID(ST_GeomFromText('" + geom_asWkt + "')," + myGBL['l3l'].replace("EPSG:","") + "),"
            t2t = t2t + "-1,'" + obs.mntfrom() + "',"
            t2t = t2t + "-1,'" + obs.mntto() + "',"

            t2t = t2t + "'" + landxml._SurveyHeader['name'] + "',"

            t2t = t2t + "True,'" + str(obs.azdegrees()) + "',"
            t2t = t2t + str(obs.distance()) + "," + str(obs.arcradius()) + ",'"
            t2t = t2t + str(obs.azimuth()).replace("'","''") + "','" + str(obs.aztype()) + "',"
            t2t = t2t + "True,'" + str(obs.equipment()) + "')"
            retList.append(insSql + t2t + ";")

        except Exception as e:
            raise RuntimeError("Observation " + obs.mntfrom() + " to " + obs.mntto() + ": "+str(e))
    return retList

def _saveCGPoints(self,landxml, **myGBL):

    insSql = "Insert into " + myGBL['PG_Schema'] + ".stt_dp_cgpoint"
    insSql = insSql + " (geom_orig,planlabel,cgname,pntsurv,description,state,datecollected,issvpoint) values ("

    fromCRS = QgsCoordinateReferenceSystem(myGBL['a57'])
    destCRS = QgsCoordinateReferenceSystem(myGBL['l3l'])
    ct = QgsCoordinateTransform(fromCRS, destCRS, QgsProject.instance())
    
    name = "LandXml_CGPoint"
    uri="Point?"+"&".join(['field='+x for x in (
        'mrk_id:int')])

    vl = QgsVectorLayer(uri,name,"memory")
    vl.startEditing()
    fields=vl.fields()
    pr=vl.dataProvider()
    
    retList = list()
    retList.append("delete from " + myGBL['PG_Schema'] + ".stt_dp_cgpoint where planlabel = '" + landxml._SurveyHeader['name'] + "';")
    
    for cgPnt in landxml._points:
        try:
            (x,y) = cgPnt.coords()
            fet = QgsFeature(fields)
            fet.setGeometry(QgsGeometry.fromPointXY(QgsPointXY(x,y)))
            geom = fet.geometry()
            geom.transform(ct)
            geom_asWkt = geom.asWkt()
            t2t = "st_setSRID(ST_GeomFromText('" + geom_asWkt + "')," + myGBL['l3l'].replace("EPSG:","") + "),"
            t2t = t2t + "'" + landxml._SurveyHeader['name'] + "',"
            t2t = t2t + "'" + cgPnt.id() + "'," # cgname
            t2t = t2t + "'" + cgPnt.type() + "'," # pntsurv
            t2t = t2t + "''," # description
            t2t = t2t + "''," # state
            if landxml._SurveyHeader['adminDate'] == "": 
                t2t = t2t + "null," # datecollected
            else:
                t2t = t2t + "'" + landxml._SurveyHeader['adminDate'] + "'," # datecollected
            t2t = t2t + "'f')" # issvpoint
            retList.append(insSql + t2t + ";")

        except Exception as e:
            raise RuntimeError("Parcel "+cgPnt.name()+": "+str(e))
    return retList

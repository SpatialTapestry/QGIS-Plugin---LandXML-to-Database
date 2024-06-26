################################################################################
#
# Copyright 2013 Crown copyright (c)
# Land Information New Zealand and the New Zealand Government.
# All rights reserved
#
# This program is released under the terms of the new BSD license. See the 
# LICENSE file for more information.
#
# This has been slightly modified to deal with Australian LandXML Files by Spatial Tapestry
#
################################################################################

import re
import xml.etree.ElementTree as et
import math
from PyQt5.QtWidgets import *

linz_epsg_mapping = {
    'COLLTM2000':2114,
    'COLLTM1949':27214,
    'GAWLTM2000':2125,
    'GAWLTM1949':27225,
    'GREYTM2000':2118,
    'GREYTM1949':27218,
    'HAWKTM2000':2108,
    'HAWKTM1949':27208,
    'HOKITM2000':2121,
    'HOKITM1949':27221,
    'JACKTM2000':2123,
    'JACKTM1949':27223,
    'KARATM2000':2116,
    'KARATM1949':27216,
    'LINDTM2000':2127,
    'LINDTM1949':27227,
    'MARLTM2000':2120,
    'MARLTM1949':27220,
    'EDENTM2000':2105,
    'EDENTM1949':27205,
    'PLEATM2000':2124,
    'PLEATM1949':27224,
    'YORKTM2000':2129,
    'YORKTM1949':27229,
    'NICHTM2000':2128,
    'NICHTM1949':27228,
    'NELSTM2000':2115,
    'NELSTM1949':27215,
    'TAIETM2000':2131,
    'TAIETM1949':27231,
    'OBSETM2000':2130,
    'OBSETM1949':27230,
    'OKARTM2000':2122,
    'OKARTM1949':27222,
    'POVETM2000':2107,
    'POVETM1949':27207,
    'TARATM2000':2109,
    'TARATM1949':27209,
    'TIMATM2000':2126,
    'TIMATM1949':27226,
    'TUHITM2000':2110,
    'TUHITM1949':27210,
    'WAIRTM2000':2112,
    'WAIRTM1949':27212,
    'WANGTM2000':2111,
    'WANGTM1949':27211,
    'WELLTM2000':2113,
    'WELLTM1949':27213,
    'NZGD1949':4272,
    'NZGD2000':4167,
    'NZMG':27200,
    'NZTM':2193
}

latlon_coordsys = {
    'NZGD1949':1,
    'NZGD2000':1,
}


class LandXmlException( Exception ):

    def __init_(self,value):
        self._value = value

    def str(self):
        return self._value

class Point (object):

    def __init__(self,coords, oid='',id='',order='',type='',classx=''):
        self._coords = coords
        self._oid = oid
        self._id = id
        self._class = classx
        self._order = order
        self._type = type

    def coords(self):
        return self._coords

    def oid( self ):
        return self._oid

    def id(self):
        return self._id

    def order(self):
        return self._order

    def classx(self):
        return self._class

    def type(self):
        return self._type


class InstrumentSetup (object):

    def __init__(self, id='',stationName='',instrumentHeight='',pntRef=''):
        self._id = id
        self._stationName = stationName
        self._instrumentHeight = instrumentHeight
        self._pntRef = pntRef

    def id( self ):
        return self._id

    def stationName(self):
        return self._stationName

    def instrumentHeight(self):
        return self._instrumentHeight

    def typntRefpe(self):
        return self._pntRef


class Monument (object):

    def __init__(self,point,
        oid='',
        name='',
        lolid='',
        description='',
        type='',
        beacon='',
        protection='',
        state='',
        condition='',
        purpose=''):
            self._point = point
            self._oid = oid,
            self._name = name
            self._lolid = lolid
            self._description = description
            self._type = type
            self._beacon = beacon
            self._protection = protection
            self._state = state
            self._condition = condition
            self._purpose = purpose

    def point(self):
        return self._point

    def oid(self):
        return self._oid

    def name(self):
        return self._name

    def lolid(self):
        return self._lolid

    def description(self):
        return self._description

    def type(self):
        return self._type

    def state(self):
        return self._state

    def condition(self):
        return self._condition

    def beacon(self):
        return self._beacon

    def protection(self):
        return self._protection

    def purpose(self):
        return self._purpose

class Observation:

    def __init__(self,
        mntfrom='',
        mntto='',
        distance=None,
        disttype='',
        distclass='',
        distsurvey='',
        azimuth='',
        azdegrees=None,
        aztype='',
        azclass='',
        azsurvey='',
        equipment='',
        date='',
        arctype=None,
        arcradius=0,
        geomtype=None,
        coords=None
                ):
          self._mntfrom=mntfrom
          self._mntto=mntto
          self._equipment=equipment
          self._distance=distance
          self._disttype=disttype
          self._distclass=distclass
          self._distsurvey=distsurvey
          self._azimuth=azimuth
          self._azdegrees=azdegrees
          self._aztype=aztype
          self._azclass=azclass
          self._azsurvey=azsurvey
          self._date=date
          self._arctype=arctype
          self._arcradius=arcradius
          self._geomtype=geomtype
          self._coords=coords


    def mntfrom(self):
        return self._mntfrom

    def mntto(self):
        return self._mntto

    def equipment(self):
        return self._equipment

    def distance(self):
        return self._distance

    def disttype(self):
        return self._disttype

    def distclass(self):
        return self._distclass

    def distsurvey(self):
        return self._distsurvey

    def azimuth(self):
        return self._azimuth

    def azdegrees(self):
        return self._azdegrees

    def aztype(self):
        return self._aztype

    def azclass(self):
        return self._azclass

    def azsurvey(self):
        return self._azsurvey

    def date(self):
        return self._date

    def arctype(self):
        return self._arctype

    def arcradius(self):
        return self._arcradius

    def geomtype(self):
        return self._geomtype

    def coords(self):
        return self._coords


class Parcel:

    def __init__(self,
            coords,
            geomtype,
            oid='',
            name='',
            lolid='',
            description='',
            area=0.0,
            state='',
            pclass='',
            type=''):
        self._coords=coords
        self._geomtype=geomtype
        self._oid=oid
        self._name=name
        self._lolid=lolid
        self._description = description
        self._area = area
        self._state = state
        self._pclass = pclass
        self._type=type

    def coords(self):
        return self._coords

    def geomtype( self):
        return self._geomtype

    def oid( self ):
        return self._oid

    def name(self):
        return self._name

    def lolid(self):
        return self._lolid

    def description(self):
        return self._description

    def type(self):
        return self._type

    def state(self):
        return self._state

    def area(self):
        return self._area

    def pclass(self):
        return self._pclass

class LandXml (object):

    def __init__(self,file, **TransDict):
        data = et.ElementTree()
        data.parse(file)
        root = data.find(".")
        ns = root.tag.split("}")[0]+"}"
        self._file = str(file)
        self._data = data
        self._root = root
        self._SurveyHeader = {}
        self.doTransform = TransDict['GoIt']
        if self.doTransform == "T":
            self.FrE = float(TransDict['FrE'])
            self.FrN = float(TransDict['FrN'])
            self.ToE = float(TransDict['ToE'])
            self.ToN = float(TransDict['ToN'])
            self.Rot = float(TransDict['Rot'])
            self.SFr = float(TransDict['SFr'])
        self._ns = ns
        self._coordsys = {}
        self._parcels=[]
        self._points=[]
        self._pointIdx={}
        self._instrumentIdx={}
        self._instrumentLUp={}
        self._surveys=[]
        self._monumentNames = None
        self._monumentPurposes = None
        self._setups=None;
        self._parse()
        
    def _readSurveyHeader(self):
        ns = self._ns;
        sh=self._data.findall("%sSurvey/%sSurveyHeader"%(ns,ns))
        if sh is not None:
            for p in sh:
                self._SurveyHeader['name'] = p.get('name')
                self._SurveyHeader['jurisdiction'] = p.get('jurisdiction')
                self._SurveyHeader['adminDate'] = p.get('adminDate')
 
    def _readHeader(self):
        ns = self._ns;
        cs = self._data.find(ns+'CoordinateSystem')
        if cs is not None:
            self._coordsys['name'] = cs.get('name')
            self._coordsys['description'] = cs.get('desc')
    
    def _parse(self):
        self._readSurveyHeader()
        self._readHeader()
        self._readPoints()
        self._readInstrumentSetup()
        # self._readMarks()
        # self._readParcels()
        self._readSurveys()
        # self._readObservations()

    def coordSys(self):
        return self._coordsys['name']
    
    def coordSysEpsgId(self):
        if self._coordsys['name'] in linz_epsg_mapping:
            return linz_epsg_mapping[self._coordsys['name']]

    def coordSysIsLatLon(self):
        return self._coordsys['name'] in latlon_coordsys

    def monuments(self):
        for m in self._readMarks():
            yield m

    def parcels(self):
        for p in self._readParcels():
            yield p

    def observations( self ):
        for o in self._readObservations():
            yield o

    def surveys(self):
        return self._surveys

    def _readPoints(self):
        ns = self._ns;
        points=self._data.findall("%sCgPoints/%sCgPoint"%(ns,ns))
        for p in points:
            oID = p.get('oID')
            order = p.get('surveyOrder','')
            name = p.get('name','')
            pntSurv = p.get('pntSurv','')
            coords = self._getCoords(p.text)
            point = Point(coords,oid=oID,id=name,order=order,type=pntSurv)
            self._points.append(point)
            self._pointIdx[name] = point

    def _readInstrumentSetup(self):
        ns = self._ns;
        instSetups=self._data.findall("%sSurvey/%sInstrumentSetup"%(ns,ns))
        for p in instSetups:
            ID = p.get('ID')
            stationName = p.get('stationName','')
            instrumentHeight = p.get('instrumentHeight','')
            pntRef = p.get('pntRef','')
            instSetup = InstrumentSetup(id=ID,stationName=stationName,instrumentHeight=instrumentHeight,pntRef=pntRef)
            self._instrumentIdx[id] = instSetup
            self._instrumentLUp.update({stationName: pntRef}) 

    def _surveyMonumentPurpose( self, mntref ):
        if self._monumentPurposes is None:
            ns=self._ns
            self._monumentPurposes={}
            surveymonuments=self._data.findall("%sSurvey/%sSurveyMonument"%(ns,ns))
            for sm in surveymonuments:
                name=sm.get('mntRef','')
                purpose=sm.get('purpose')
                self._monumentPurposes[name]=purpose
        return self._monumentPurposes.get(mntref,'')

    def _readMarks(self):
        ns = self._ns;
        if self._monumentNames is None: 
            self._monumentNames={}
        monuments=self._data.findall("%sMonuments/%sMonument"%(ns,ns))
        for m in monuments:
            oID = m.get('oID')
            name,lolid = self._parseLolId(m.get('name'))
            desc = m.get('desc','')
            type = m.get('type','')
            state = m.get('state','')
            condition = m.get('condition','')
            beacon = m.get('beacon','')
            protection = m.get('beaconProtection','')
            pntref = m.get('pntRef')
            if pntref == None or pntref == " ":
                QMessageBox.information(None, "_readMarks", str(pntref), QMessageBox.Ok, QMessageBox.Ok)
            point = self._getPoint(pntref)
            purpose = self._surveyMonumentPurpose(name)
            self._monumentNames[pntref]=name
            monument=Monument(
                point,
                oid=oID,
                name=name,
                lolid=lolid,
                description=desc,
                type=type,
                state=state,
                condition=condition,
                beacon=beacon,
                protection=protection,
                purpose=purpose
            )
            yield monument

    def _monumentName(self,pntref):
        if self._monumentNames is None:
            for o in self.monuments():
                pass
        return self._monumentNames.get(pntref)

    def _readParcels(self):
        ns = self._ns;
        parcels=self._data.findall("%sParcels/%sParcel"%(ns,ns))
        #QMessageBox.information(None,str(len(parcels)),"_readParcels", QMessageBox.Ok, QMessageBox.Ok)

        for p in parcels:
            cogo = p.find(ns+"CoordGeom");
            if cogo is None:
                continue
            oID = p.get('oID')
            name,lolid = self._parseLolId(p.get('name'))
            desc = p.get('desc','')
            area = 0.0
            try:
                area = float(p.get('area','0.0'))
            except:
                pass
            state = p.get('state','')
            pclass = p.get('class','')
            type = p.get('parcelType','')
            #format = p.get('parcelFormat','')
            #QMessageBox.information(None,"_readParcels",str(oID) + " " + type, QMessageBox.Ok, QMessageBox.Ok)
            try:
                coords, geomtype = self._readCoGo(cogo)
                parcel = Parcel(coords,geomtype,oid=oID,name=name,lolid=lolid,description=desc,area=area,
                    state=state,pclass=pclass,type=type)
            except LandXmlException as excp:
                raise LandXmlException("Parcel "+name+": "+str(excp))
            yield parcel
            #self._parcels.append(parcel)

    def _setupPointRef(self,stpid):
        if self._setups is None:
            ns=self._ns
            self._setups={}
            setups=self._data.findall("%sSurvey/%sInstrumentSetup"%(ns,ns))
            for stp in setups:
                id=stp.get('id')
                pt=stp.find("%sInstrumentPoint"%(ns))
                if pt is not None:
                    pntref=pt.get('pntRef')
                    if id is not None and pntref is not None:
                        self._setups[id]=pntref
        return self._setups.get(stpid)

    def _readObservations(self):
        ns = self._ns;
        obs=self._data.findall("%sSurvey//%sReducedObservation"%(ns,ns))
        for o in obs:
            yield self._readObservation(o)

        arcobs=self._data.findall("%sSurvey//%sReducedArcObservation"%(ns,ns))
        for o in arcobs:
            yield self._readObservation(o)

    def _readObservation(self, obsel ):

        try:
            ptreffrom=self._setupPointRef(obsel.get('setupID'))
            ptfrom=self._getPoint(ptreffrom)
            mntfrom=self._monumentName(ptreffrom) or ptreffrom # 'unnamed'

            ptrefto=self._setupPointRef(obsel.get('targetSetupID'))
            mntto=self._monumentName(ptrefto) or ptrefto # 'unnamed'
            ptto=self._getPoint(ptrefto)

            radius=0.0
            arctype=obsel.get('rot')
            if arctype:
                distance=obsel.get('length')
                azimuth=obsel.get('chordAzimuth')
                radius=float(obsel.get('radius'))
                disttype=obsel.get('arcType')
                aztype=disttype
                distclass=obsel.get('lengthAccClass')
                azclass=obsel.get('azimuthAccClass')
                distsurvey=obsel.get('adoptedSurvey')
                azsurvey=distsurvey
            else:
                distance=obsel.get('horizDistance')
                azimuth=obsel.get('azimuth')
                disttype=obsel.get('distanceType')
                aztype=obsel.get('azimuthType')
                distclass=obsel.get('distanceAccClass')
                azclass=obsel.get('azimuthAccClass')
                distsurvey=obsel.get('adoptedDistanceSurvey')
                azsurvey=obsel.get('adoptedAzimuthSurvey')

            equipment=obsel.get('equipmentUsed')
            date=obsel.get('date')

            azdegrees=None;
            if azimuth:
                m=re.match(r'(\d+)\.(\d\d)(\d\d)$',azimuth)
                if m:
                    azdegrees=float(m.group(1))+float(m.group(2))/60.0+float(m.group(3))/3600.0;
                    azimuth=m.group(1)+"\xB0"+m.group(2)+"'"+m.group(3)+'"'
            if distance is not None:
                distance=float(distance)

            coofrom=ptfrom.coords()
            cooto=ptto.coords()
            coords=[coofrom,cooto]

            if arctype is not None:
                coords=self._arcCoords(coords,arctype,length=distance,radius=radius)

            geomtype='line'

            return Observation(
                mntfrom=mntfrom,
                mntto=mntto,
                distance=distance,
                disttype=disttype,
                distclass=distclass,
                distsurvey=distsurvey,
                azimuth=azimuth,
                azdegrees=azdegrees,
                aztype=aztype,
                azclass=azclass,
                azsurvey=azsurvey,
                equipment=equipment,
                date=date,
                arctype=arctype,
                arcradius=radius,
                geomtype=geomtype,
                coords=coords
                )
        except LandXmlException as exc:
            tag=self._getTag(obsel)
            for k in list(obsel.keys()):
                v=obsel.get(k,'')
                tag=tag+' '+k+':'+v
            raise LandXmlException( str(exc)+' in '+tag)


    def _arcCoords( self, coords, arctype, length=0.0, radius=0.0, centre=None ):
        cw = (arctype == 'cw')
        xmult=1.0
        ymult=1.0
        latlon=self.coordSysIsLatLon()
        if latlon:
            ymult=100000.0
            xmult=ymult*math.cos(math.radians((coords[0][1]+coords[1][1])/2.0))

        wx0=coords[0][0]
        wy0=coords[0][1]
        dwx=(coords[1][0]-wx0)*xmult
        dwy=(coords[1][1]-wy0)*ymult

        twopi=math.pi*2
        if centre is not None:
            rx1=(wx0-centre[0])*xmult
            ry1=(wy0-centre[1])*ymult
            rx2=(coords[1][0]-centre[0])*xmult
            ry2=(coords[1][1]-centre[1])*ymult
            radius=(math.hypot(rx1,ry1)+math.hypot(rx2,ry2))/2.0
            angdif=math.atan2(ry2,rx2)-math.atan2(ry1,rx1)
            if cw:
                angdif=-angdif
            if angdif > twopi: 
                angdif -= twopi
            if angdif < 0:
                angdif += twopi
            length=angdif*radius

        precision=0.1
        if radius < precision:
            return coords

        angle=length/radius
        # If less than a few degrees or nearly a full circle don't use...
        #if angle < 0.05 or angle > twopi - 0.05:
        #    return coords
        if length < 0.1:
            return coords

        anginc=math.acos(1-precision/radius)
        if anginc > 0.5:
            anginc=0.5
        if anginc < 0.02:
            anginc=0.02

        nseg=int(angle/anginc)
        if nseg < 1:
            return coords

        if arctype != 'cw': 
            angle=-angle

        a0=-(math.pi+angle)/2.0
        ainc=angle/nseg
        x0=math.cos(a0)
        y0=math.sin(a0)
        dwx /= (-2.0*x0)
        dwy /= (-2.0*x0)

        coords=[]
        for i in range(nseg+1):
            x=math.cos(a0+ainc*i)-x0
            y=math.sin(a0+ainc*i)-y0
            coords.append([ wx0+(dwx*x+dwy*y)/xmult, wy0+(dwy*x-dwx*y)/ymult ])
        return coords

    def _readSurveys(self):
        pass

    def _parseLolId(self,name):
        lolid = 0
        mrkname=name
        match = re.search(r'^(.*\s+)?\[(\d+)\]\s*$',name)
        if match:
            lolid = int(match.group(2))
            mrkname = '' if match.group(1) is None else match.group(1).strip()
            if mrkname == '':
                mrkname=name
        return mrkname,lolid

    def _getTag(self,element):
        return element.tag.replace(self._ns,'')

    def _readCoGo(self,cogo):
        ''' Read a CoordGeom element to build a multipolygon coord array.
        Assumes that:
            rings are identifiable by difference between endpoint of one segment
            and startpoint of the next
            segments of rings are in order
            inner rings immediately follow their outer ring
            inner rings coordinates are in opposite direction (clockwise/anticlockwise)
            to outer ring coordinates
        '''
        crdlist = []
        coords = None
        for c in cogo:
            tag = self._getTag(c)
            line = None
            if tag == "Line":
                line = self._readLine(c)
            elif tag == "IrregularLine":
                line = self._readIrregularLine(c)
            elif tag == "Curve":
                line = self._readCurve(c)
            else:
                raise LandXmlException("CoordGeom " + tag + " type not handled")

            if line:
                if  coords==None or line[0] != coords[-1]:
                    coords=line
                    crdlist.append(coords)
                else:
                    coords.extend(line[1:])

        polylist = []
        linelist = []
        inner = None
        mult = 1.0
        for c in crdlist:
            # Test if this is a valid ring...
            if len(c) < 3 or c[0] != c[-1]:
                linelist.append(c)
                inner=None
                continue
            area = self._calcArea(c)
            # Use first polygon to define whether positive or
            # negative area corresponds to output polygon.
            if inner == None and area < 0.0:
                mult = -1.0
            area *= mult
            if area >= 0.0:
                inner = []
                polylist.append([c,inner])
            else:
                inner.append(c)

        if len(linelist) > 0 and len(polylist) > 0:
            raise LandXmlException("Cannot handle parcel with both polygon and linear geometries")

        if len(linelist) > 0:
            return linelist,"MultiLineString"

        return polylist,"MultiPolygon"

    def _getCoords(self, text):
        crds = text.split()
        East = float(crds[1])
        Nrth = float(crds[0])
        if self.doTransform == "T":
            East = East - self.FrE
            Nrth = Nrth - self.FrN
            myBear = math.degrees(bearr(East, Nrth))
            p = [East, Nrth]
            q = [0, 0]
            myDist = math.dist(p, q) * self.SFr
            myBearRad = math.radians(float(myBear) + self.Rot)
            # QMessageBox.information(None,str(int(180 * bearr(East, Nrth) / math.pi)) + "xxx" + str(self.Rot),str(int(East)) + "," + str(int(Nrth)) + "/n" + str(int(myBear)) + "," + str(int(myDist)), QMessageBox.Ok, QMessageBox.Ok)
            ETrans = self.ToE + math.sin(myBearRad) * float(myDist)
            NTrans = self.ToN + math.cos(myBearRad) * float(myDist)
            return [ETrans, NTrans]
        return [East, Nrth]

    def _readLine(self,c):
        return [self._readPointType(c,'Start'),self._readPointType(c,'End')]

    def _getPoint( self, id ):
        try:
            return self._pointIdx[id]
        except:
            QMessageBox.information(None, "_getPoint (err)", "'" + str(id) + "'/" + str( len(self._instrumentLUp)), QMessageBox.Ok, QMessageBox.Ok)
            raise LandXmlException("CgPoint with name '"+str(id)+"' is not defined in "+self._file)

    def _readPointType(self,c,tag):
        ns = self._ns
        pntref = c.find(ns+tag)
        if pntref == None:
            ctag = self._getTag(c)
            raise LandXmlException(tag + ' element missing in '+ctag)
        crds = []
        if pntref.text:
            crds = self._getCoords(pntref.text)
        else:
            ref = pntref.get("pntRef")
            if ref == None or ref == " ":
                QMessageBox.information(None, "_readPointType", str(ref), QMessageBox.Ok, QMessageBox.Ok)
            crds = self._getPoint(ref).coords()
        return crds

    def _readIrregularLine(self,c):
        crds = []
        pts = c.find(self._ns + 'PntList2D')
        dim = 2
        if pts == None:
            pts = c.find(self._ns+'PntList3D')
            dim = 3
        icrds = pts.text.split()
        for i in range(0,len(icrds),dim):
            crds.append([float(icrds[i+1]),float(icrds[i])])

        p0 = self._readPointType(c,'Start')
        if p0 != crds[0]:
            crds.insert(0,p0)

        p1 = self._readPointType(c,'End')
        if p1 != crds[-1]:
            crds.append(p1)
        return crds

    def _readCurve(self,c):
        crds=self._readLine(c)
        try:
            cntel=c.find("%sCenter"%(self._ns))
            centre=self._getCoords(cntel.text)
            arctype=c.get('rot')
            return self._arcCoords(crds,arctype,centre=centre)
        except:
            return crds

    def _calcArea(self,c):
        if len(c) < 3:
            return 0.0
        area = 0.0
        x = c[0][0]
        y = c[0][1]
        dx0 = 0
        dy0 = 0
        for crd in c[1:]:
            dx1 = crd[0]-x
            dy1 = crd[1]-y
            area += dx0*dy1-dx1*dy0
            dx0 = dx1
            dy0 = dy1
        return area


def bearr(DiffE, DiffN):
    if abs(DiffN) > 0:
        Bear = math.atan(DiffE / DiffN)
        if DiffN < 0 or DiffE < 0.0:
            if DiffN < 0:
                Bear = Bear + math.pi
            else:
                Bear = Bear + 2 * math.pi
    elif DiffE > 0:
        Bear = math.pi / 2.0#
    else:
        Bear = math.pi * 1.5

    if Bear >= 2 * math.pi:
        Bear = Bear - 2 * math.pi
    return Bear

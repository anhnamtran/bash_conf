#!/usr/bin/env python3

import sys
import datetime
from collections import namedtuple

logPath = sys.argv[ 1 ]

logFile = open( logPath, 'r' )

LineTuple = namedtuple( "LineTuple", [ 'time', 'host', 'status' ] )

class TimeRange( object ):
    def __init__( self ):
        self.start = None
        self.end = None

    def startIs( self, line ):
        time = line.time
        assert( type( time ) == datetime.datetime )
        if self.end is not None:
            assert( time <= self.end.time )
        self.start = line

    def endIs( self, line ):
        time = line.time
        assert( type( time ) == datetime.datetime )
        if self.start is not None:
            assert( time >= self.start.time )
        self.end = line

    def timeDelta( self ):
        return self.end.time - self.start.time

    def __str__( self ):
        startTime = self.start.time.strftime( "%a %b %d %H:%M:%S" )
        endTime = self.end.time.strftime( "%a %b %d %H:%M:%S" )

        return ( f"Host: {self.start.host}" +
                 f", time range: {self.timeDelta()}" +
                 f", start time: {startTime}" +
                 f", end time: {endTime}" )
lineTuples = []
for line in logFile.readlines():
    now = datetime.datetime.now()
    timestamp, host, status = line.rstrip().split( '\t' )

    timeObj = datetime.datetime.strptime( timestamp, "%a %b %d %H:%M:%S" )
    timeObj = timeObj.replace( year=now.year )

    lineTuples.append( LineTuple( timeObj, host, status ) )


def getTimeRanges( status ):
    result = []

    timeRange = TimeRange()
    currentTup = None
    nextTup = None
    for idx in range( len( lineTuples ) - 1 ):
        currentTup = lineTuples[ idx ]
        nextTup = lineTuples[ idx + 1 ]

        if ( currentTup.status not in [ 'OK', 'NOT CONNECTED' ] or
             nextTup.status not in [ 'OK', 'NOT CONNECTED'] ):
            raise Exception( "Unrecognized log status" )

        if currentTup.status == status:
            if nextTup.status == status:
                if timeRange.start is None:
                    timeRange.startIs( currentTup )
            else:
                if timeRange.start is None:
                    timeRange.startIs( currentTup )
                timeRange.endIs( currentTup )
                result.append( timeRange )
                timeRange = TimeRange()
    if timeRange.start is not None and timeRange.end is None:
        timeRange.end = nextTup
        result.append( timeRange )
    return result

uptimeRanges = getTimeRanges( 'OK' )

downtimeRanges = getTimeRanges( 'NOT CONNECTED' )

allTimeRanges = uptimeRanges + downtimeRanges
allTimeRanges.sort( key=lambda timeRange: timeRange.start.time )


print( f"Activity summary for"
       f" {allTimeRanges[ -1 ].end.time - allTimeRanges[ 0 ].start.time}"
       " of monitoring:" )
for timeRange in allTimeRanges:
    startTime = timeRange.start.time.strftime( "%a %b %d %H:%M:%S" )
    endTime = timeRange.end.time.strftime( "%a %b %d %H:%M:%S" )
    if timeRange.start.status == 'OK':
        print( f"[UP]:   {timeRange.timeDelta()}"
               f", start: {startTime}"
               f", end: {endTime}" )
    else:
        print( f"[DOWN]: {timeRange.timeDelta()}"
               f", start: {startTime}"
               f", end: {endTime}" )
print( '-' * 80 )

total = datetime.timedelta()
print( "Up times:" )
for uptimeRange in uptimeRanges:
    total += uptimeRange.timeDelta()
    print( uptimeRange )
print( f"The connection was up {len( uptimeRanges )} times during the day" )
print( f"The total up time was: {total}" )
print( f"Average up time was: {total / 10}" )
print( '-' * 80 )

total = datetime.timedelta()
print( "Down times:" )
for downtimeRange in downtimeRanges:
    total += downtimeRange.timeDelta()
    print( downtimeRange )
print( f"The connection was down {len( downtimeRanges )} times during the day" )
print( f"The total down time was: {total}" )
print( f"Average down time was: {total / 10}" )

#!/usr/bin/python3

import os
import sys
import socket
import datetime
import argparse
from time import sleep
from urllib.parse import urlparse

defaultHost = "http://www.google.com"
logFmt = "{timestamp}\t{host}\t{status}\n"

def internet( host=defaultHost, port=80, timeout=1 ):
    """ Generates a new request"""
    if host.startswith( 'http' ):
        host = urlparse( host ).netloc
    try:
        hostIp = socket.gethostbyname( host )
        socket.setdefaulttimeout( timeout )
        sock = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
        sock.connect( ( hostIp, port ) )
        return True
    except socket.timeout:
        return False
    except socket.gaierror:
        return False
    except Exception:
        raise

def timestamp():
    """ Get Current timestamp string """
    return datetime.datetime.now().strftime("%a %b %d %H:%M:%S")

def parseArgs():
    parser = argparse.ArgumentParser( description="Monitor network connection" )

    parser.add_argument(
        '--host', '-H', dest='host', default=defaultHost,
        help=f"Monitor using the given host. Default: {defaultHost}" )
    parser.add_argument(
        '--overwrite-log', '-O', dest='overwrite', action='store_true',
        help="Overwrite the log file if it exists instead of appending" )
    parser.add_argument( '--logFile', '-l', default="connection.log",
                         help="Name of log file to use" )
    parser.add_argument( '--stdout', action='store_true',
                         help="Use stdout instead of output file" )
    parser.add_argument( '--interval', '-i', metavar='SECONDS', type=int, default=5,
                         help="Check the host every {interval} seconds" )
    parser.add_argument( '--timeout', '-t', metavar='SECONDS', default=1,
                         help="Timeout for connection check")

    return parser.parse_args()

def writeLog( file, host, status ):
    file.write( logFmt.format( timestamp=timestamp(),
                               host=host,
                               status=status ) )
    file.flush()

if __name__ == '__main__':
    args = parseArgs()
    logFile = args.logFile

    outFile = None
    if args.stdout:
        outFile = sys.stdout
    elif not os.path.isfile( logFile ) or args.overwrite:
        outFile = open( logFile, 'w' )
    else:
        outFile = open( logFile, 'a' )

    host = args.host
    print( f"Starting monitoring with {host} at {timestamp()}" )
    startTime = datetime.datetime.now()
    try:
        while True:
            if internet( host, timeout=args.timeout ):
                writeLog( outFile, host, 'OK' )
            else:
                writeLog( outFile, host, 'NOT CONNECTED' )

            elapsed = datetime.datetime.now() - startTime
            sys.stdout.write( f"\rElapsed time: {elapsed}" )
            sys.stdout.flush()

            sleep( args.interval )
    except KeyboardInterrupt:
        print( f"\nStopping monitor at {timestamp()}" )
    outFile.close()

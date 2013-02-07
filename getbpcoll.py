from redcap import Project
import csv
import datetime

"""
in `project_info.txt` store
your token (first line)
REDCap-specific API URL (second line)
"""
fh = open('project_info.txt','r')
token = fh.next().strip()
apiurl = fh.next().strip()
fh.close()

"""
The heavy lifting is done in 2 lines of code
using Scott Burns' awesome PyCap module
"""
bpcoll = Project( apiurl, token )
bpcoll_csvrecords = bpcoll.export_records( format='csv' )

"""
Save a snapshot of the blood pressure data to a csv
"""
filenowname = 'bpcoll_{0}.csv'.format( datetime.datetime.today().strftime('%Y%m%d_%H%M') )
filecurrentname = 'bpcoll_current.csv'
fhout = open( filenowname, 'w' )
fhout.write( bpcoll_csvrecords )
fhout.close()
fhout = open( filecurrentname, 'w' )
fhout.write( bpcoll_csvrecords )
fhout.close()

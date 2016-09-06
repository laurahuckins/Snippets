
import sys
import numpy as np

nsnps=int(sys.argv[1])
gene=sys.argv[2]

ldname= "%s.ld" % (gene)
dosname= "%s.dosage" % (gene)

fout = open(ldname, 'w')

file=open(dosname, 'r')

headfile=open('header', 'r')

header=headfile.readline().strip().split()
nsamples = max(1, (len(header)-6))
for i in range(nsamples):
    ii = i+6
    header[i] = header[ii]

header = header[:nsamples:]
data = np.empty([nsnps,nsamples])

snp=0
snpids = []
A1s = []
A2s = []

for line in file:
    raw = line.strip().split()
    snpids.append(raw[1])
    A1s.append(raw[3])
    A2s.append(raw[4])
    for i in xrange(nsamples):
        ii = i+6
        data[snp,i] = float(raw[ii])
    snp+=1

keep=set()
keepf = open("IDS.EU.use",'r')
for line in keepf.readlines():
    indiv = line.strip()
    keep.add(indiv)

keepf.close()
keep=frozenset(keep)
keepis = [i for i, e in enumerate(header) if e in keep]
nkeepsamples = len(keepis)

x = np.empty([snp,snp])

x = np.corrcoef(data[:snp,keepis])

print >> fout, ' '.join(snpids)
print >> fout, '\n'.join([' '.join(['{:}'.format(item) for item in row]) for row in x]) # To print whole LD mat use this command instead
fout.close()

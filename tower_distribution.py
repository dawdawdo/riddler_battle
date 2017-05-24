# Standard Modules
import logging as log

# User Modules
from cfg import app


 
# Constraint function returns true if inputs meet constraint requirement
def partitionfunc(n,k,l=0):
    '''n is the integer to partition, k is the length of partitions, l is the min partition element size'''
 
    if k < 1:
        raise StopIteration
    if k == 1:
        if n >= l:
            yield (n,)
        raise StopIteration
    for i in range(l,n+1):
        for result in partitionfunc(n-i,k-1,i):
            yield (i,)+result
 
@app()
def main():
 
    log.info('Openinig output file...')
 
    with open(r'C:\ProgramData\Scratchwork\tower_distributions.txt', mode='w') as twr:
 
        log.info('Output file open')
        for i, x in enumerate(partitionfunc(100, 10, l=0)):
 
            twr.write(repr(x).replace('(', '').replace(')', '') + '\n')
 
            if (1 + i) % 1000000 == 0:
                log.info('Line %i written: %s' % (1+i, repr(x)))
 
    log.info('tower_distribution complete')

if __name__ == '__main__': main()


# Standard Modules
from itertools import permutations
import logging as log

# User Modules
from cfg import app
 
@app()
def main():
 
    log.info('Openinig output file...')
 
    with open(r'C:\ProgramData\Scratchwork\permnutations.txt', mode='w') as twr:
 
        log.info('Output file open')

        for i, p in enumerate(permutations(range(1,11))):
 
            twr.write(repr(p).replace('(', '').replace(')', '') + '\n')
 
            if (1 + i) % 1000000 == 0:
                log.info('Line %i written: %s' % (1+i, repr(p)))
 
    log.info('permutations complete')

if __name__ == '__main__': main()


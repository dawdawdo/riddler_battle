# Standard Modules
from itertools import permutations
import logging as log

# User Modules
from cfg import app
 
@app()
def main():
 
    # Each evolution has a number of generations (determined by the annealing factor).
    # Begin by checking out the active generation of the current evolution, or by creating
    # one (randomly).

    log.info('Beginning playtime...')
 
    log.info('Check for the active generation of the current evolution or generate a new evolution.')



    log.info('Playtime has ended.')

if __name__ == '__main__': main()


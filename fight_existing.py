# Standard Modules
import logging as log
from math import floor
from numpy.random import choice
from os import system
from random import shuffle, random


# User Modules
from cfg import app
import psql


def fight(co, ci):

    co_scr = 0
    ci_scr = 0

    for idx, (o, i) in enumerate(zip(co, ci)):

        if o > i:
            co_scr += idx
        elif i > o:
            ci_scr += idx
        else:
            ci_scr += (idx / 2)
            co_scr += (idx / 2)

    return 'out' if co_scr > ci_scr else 'in'

 
@app(log_level=log.DEBUG)
def main():

    log.info('Initializing fight_existing.py....')

    srv = r'localhost\SQLEXPRESS'
    db = 'Nymphadora'
    db_cnxn = psql.Executer(srv, db)

    entries = db_cnxn.exec_sql("""SELECT [Castle 1]
      ,[Castle 2]
      ,[Castle 3]
      ,[Castle 4]
      ,[Castle 5]
      ,[Castle 6]
      ,[Castle 7]
      ,[Castle 8]
      ,[Castle 9]
      ,[Castle 10] FROM [Nymphadora].dbo.Tower_Submissions""")

    cnd = db_cnxn.exec_sql("""SELECT TestId, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10
                                    FROM dbo.Tower_Test_Candidates
                                    WHERE TestStatus = 'ready'""")

    log.info('Found %i candidates' % len(cnd))

    for cand in cnd:

        score = 0

        testid, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10 = cand

        c = (c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)

        log.debug('Testing candidate %s' % repr(c))

        for e in entries:
            res = fight(c, e)
            if res == 'out':
                score += 1

        log.debug('Recording results...')

        db_cnxn.exec_sql("""
        UPDATE dbo.Tower_Test_Candidates
        SET Score = ?
        , TestStatus = 'complete'
        WHERE TestId = ?
        """, [score, testid])

    log.info('Recorded solutions')

if __name__ == '__main__': main()


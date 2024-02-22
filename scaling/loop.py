#
# Show the elapsed time to execute a loop where each iteration takes the same
# amount of time as we increase the num ber of threads.
#

def loopTime(iterations, threadCount):
    """Compute the number of iterations executed by one of the threads which has
    the most. We are assuming that whatever schedule is used does as well as is possible
    which means there will only be an imbalance of one iteration.
    That is entirely independent of the methos by which the iterations are allocated,
    and which precise iterations each executes."""
    baseIterations = iterations // threadCount
    return baseIterations if (iterations % threadCount) == 0 else baseIterations+1

def outputTimes(iterations, threadCount):
    print ("Theory")
    print ("Best Possible Schedule")
    print ("Threads, Time")
    for threads in range(1,threadCount+1):
        print (f"{threads}, {loopTime(iterations,threads)} s")


outputTimes(50, 64)





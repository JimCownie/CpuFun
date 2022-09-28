import BMutils
import os

os.chdir ("/home/br-jcownie/miniBude/buildAarch64/")

runDesc = BMutils.runDescription(
    BMutils.getExecutable("omp-bude"),
    {
    },
    {
    },
    "miniBude",
)

test = ""


BMutils.runScaling(runDesc, test, 4)

# Read a set of CSV files contaning  Archer2 usage information
# and aggregate them before outputting a summary.

import pandas as pd


### Which language is each code written in?
### Required web search, and is incomplete.
def language(code):
    codeToLanguage = {
        "3DNS": "Fortran",  # Private communication from Andy Wheeler
        "a.out" : "Unknown",
        "Amber": "Fortran",
        # Also has CUDA and some C++, but since we're not using GPUs, Fortran seems fair
        "AxiSEM3D": "C++",
        # https://github.com/AxiSEMunity/AxiSEM3D
        "CASINO": "Fortran",
        # https://www.ehu.eus/sgi/ARCHIVOS/casino_manual.pdf
        "CASTEP": "Fortran",
        "CESM": "Fortran",  # https://www.cesm.ucar.edu/models/cesm1.2/cesm/doc/usersguide/x32.html
        "COSA": "Fortran",
        # https://www.sites.google.com/site/mscampobasso/home/cosa-cfd-project/parallelization ("Compiled with ifort")
        "CP2K": "Fortran",
        "CPMD": "Fortran",  # https://www.cpmd.org/wordpress/CPMD/getFile.php?file=manual.pdf "There are several Fortran compiler..."
        "CRYSTAL": "Fortran",
        # https://www.crystal.unito.it/Manuals/crystal17.pdf
        "ChemShell": "Python",
        # But it's invoking underlying codes in other languages...
        "CloverLeaf": "C++",
        "Code_Saturne": "Fortran + C",
        "DL_MESO": "Fortran + C++",  # https://ccp5.gitlab.io/dl_meso/DL_MESO.html
        "DL_POLY": "Fortran",
        # https://www.scd.stfc.ac.uk/Pages/DL_POLY.aspx
        "ECHAM": "Unknown",
        # Probably Fortran, but it's hard to find out.
        "EPOCH": "Fortran",
        # http://www.archie-west.ac.uk/wp-content/uploads/2014/02/EPOCH_notes.pdf "EPOCH is a Fortan90 program"
        "FHI aims": "Fortran",
        # Private email: "The core of FHI-aims is written in Fortran"
        "FVCOM": "Fortran",
        # https://github.com/FVCOM-GitHub/fvcom43
        "Fluidity": "Fortran + C",  # https://github.com/FluidityProject/fluidity
        "GPAW": "Python",
        # https://wiki.fysik.dtu.dk/gpaw/ (but sits on top os ASE which invokes many "real" underlying codes."
        "GROMACS": "C",
        "GS2": "Fortran",  # https://bitbucket.org/gyrokinetics/gs2/src/master/src/
        "HANDE": "Fortran",
        # https://hande.readthedocs.io/en/v1.5/manual/prereq.html "HANDE is written in (mostly) Fortran 2003 with some C code."
        "HYDRA": "Python",
        # https://hydra.cc/docs/intro/ (but it invokes other things)
        "HemeLB": "C++",
        # https://github.com/hemelb-codes/hemelb
        "iIMB": "C & C++",   # Assuming this is the Intel MPI benchmarks https://github.com/intel/mpi-benchmarks
        "LAMMPS": "C++",
        "MITgcm": "Fortran",
        # https://github.com/MITgcm/MITgcm
        "Met Office UM": "Fortran",
        "NAMD": "C++",  # https://www.ks.uiuc.edu/Research/namd/features.html "C++ source code"
        "NEMO": "Fortran",
        # https://sites.nemo-ocean.io/user-guide/install.html "The NEMO source code is written in Fortran 95"
        "NWChem": "Fortran",
        # https://github.com/nwchemgit/nwchem
        "Nek5000": "Fortran",
        # https://github.com/Nek5000/Nek5000
        "Nektar++": "C++",
        # https://github.com/certik/nektar
        "ONETEP": "Fortran",
        # https://www.onetep.org/pmwiki/uploads/Main/Documentation/ONETEP_GPU.pdf shows setting up F90 compilers
        "OSIRIS": "Unknown",
        # C++ at a guess, but hard to tell
        "OpenFOAM": "C++",
        # https://github.com/OpenFOAM/OpenFOAM-10
        "PDNS3D": "Fortran",
        # https://www.archer.ac.uk/documentation/white-papers/benchmarks/UK_National_HPC_Benchmarks.pdf
        "PRECISE": "Unknown",
        "ptau3d": "Unknown",
        # It's the TAU performance tool, so the real applications are underneath
        "Python": "Python",
        "Quantum Espresso": "Fortran",  # https://gitlab.com/QEF/q-e/-/wikis/Developers/General-information-for-developers#:~:text=Preprocessing-,Fortran%20source%20code,-contains%20preprocessing%20option
        "RMT": "Fortran", # "Programming language: Fortran" https://www.sciencedirect.com/science/article/pii/S0010465519303856 
        "SBLI": "Fortran",
        # Probably... "Legacy versions of SBLI comprise static hand-written Fortran code" -- OpenSBLI paper https://eprints.soton.ac.uk/402534/1/opensbli.pdf says
        "SENGA": "Fortran",
        # https://www.ukctrf.com/index.php/senga/ "SENGA+ [1] is .. written in FORTRAN"
        "SIESTA": "Fortran",
        # https://gitlab.com/siesta-project/siesta
        "Smilei": "C++",
        # https://github.com/SmileiPIC/Smilei
        "TPLS": "Fortran",
        # https://www.software.ac.uk/who-do-we-work/tpls
        "UKRmol+": "Fortran",
        # https://fortran.bcs.org/2012/UKRAMP12_JDG.pdf
        "Unidentified": "Unknown",
        "VASP": "Fortran",
        "WRF": "Fortran",  # "The majority of the WRF model, WPS, and WRFDA codes are written in Fortran 90." https://www2.mmm.ucar.edu/wrf/users/docs/user_guide_v4/v4.4/users_guide_chap2.html
        "Xcompact3d": "Fortran",
        # "Xcompact3d is a Fortran90 MPI based ..."https://hpcadvisorycouncil.atlassian.net/wiki/spaces/HPCWORKS/pages/2799468548/Getting+Started+with+Xcompact3d+for+ISC22+SCC
        "Zacros": "Fortran",
        # "Zacros is a Kinetic Monte Carlo (KMC) software package written in Fortran" https://zacros.org/
    }
    return codeToLanguage.get(code, "Unknown")

def removeTrivial(d):
    # Remove entries with value zero
    # Feels as if there should be a diictionary comprehension way of writing this, but I don't see it :-(
    res = {}
    for k in d.keys():
        if d[k] != 0:
            res[k] = d[k]
    return res

def filter(data, ignore):
    """Pull the program name, the node hours and build a simple dictionary
    indexed by the program name. Since we're just dealing with nodeH now, this is
    easier than messing around with Pandas (at least for me)!
    Looking at the energy consumption would also be interesting, but it's only present
    from July 22.
    """
    res = {k: v for k, v in zip(data["Software"], data["Nodeh"])}
    if ignore:
        ud = res["Unidentified"]
        res["Overall"] -= ud
        res.pop("Unidentified")
        # And also filter all of the entries which have Unknown language
        r = {}
        for k,v in zip(res.keys(), res.values()):
            if k != "Overall" and language(k) == "Unknown":
                r["Overall"] -= v
                continue
            r[k] = v
        res = r
    return removeTrivial(res)


def add(d1, d2):
    """Add the corresponding entries from the two dictionaries together"""
    res = {}
    for k in set(d1.keys()) | set(d2.keys()):
        res[k] = d1.get(k, 0.0) + d2.get(k, 0.0)
    return res


def aggregate(data):
    """Add all the values together"""
    total = {}
    for month in data.values():
        total = add(total, month)
    return total


def sortToList(d, keyFunc=lambda x: x[1]):
    """Return a sorted list of (Code, value) pairs, where the largest
    value is at the start of the list
    """
    return sorted([(k, v) for k, v in zip(d.keys(), d.values())], key=keyFunc, reverse=True)


def summariseLanguage(d, preferredLanguage="Fortran"):
    """Extract a summary of the use of each language.
    The preferredLanguage gets all of the usage for mixed language codes if it is present.
    """
    values= {}
    for k,v in d:
        l = language(k)
        if preferredLanguage and preferredLanguage in l.split(" "):
            l = preferredLanguage 
        prev = values.get(l,[0,0])
        prev[0] += 1
        prev[1] += v
        values[l] = prev
    return sortToList(values,keyFunc=lambda x: x[1][1])

def output(files, d, options):

    prefer  = options.prefer
    ignore  = options.ignore
    # Assume that we have the "Overall" field and it will be first
    total = d[0][1]

    print ("\nInput files: " + (", ".join(files)))
    if ignore:
        print ("""Ignoring unidentified codes and those whose language we cannot determine.
        If you want to see them don't pass the --ignoreunidentified flag!""")
    print ("Per code summary\n"
           "Code, Language, Percentage use, Node Hours")
    for (code, usage) in d:
        pct = usage*100/total
        # Filter out codes that show 0% as being uninteresting.
        if pct < 0.01:
            continue
        line = f"{code}, {language(code)}, {pct:4.2f}%, {usage:.0f}"
        print (line)

    print()
    # print (f"Total codes: {len(d)-1}")
    langs = summariseLanguage(d[1:],prefer)   # Skip the total which will be first!
    if prefer:
        print (f"Preferring {prefer}, so allocating all usage for codes that include that language to it alone.")
    print ("Per language summary\n"
           "Language, Number of Codes, Percentage use, Node Hours")
    for (lang, use) in langs:
        pct = use[1]*100/total
        if pct < 0.01:
            continue
        print ( f"{lang}, {use[0]}, {pct:4.2f}%, {use[1]:.0f}")
    
def generateReport():
    """Do everything!"""
    from optparse import OptionParser

    options = OptionParser()

    options.add_option(
        "--ignoreunidentified",
        action="store_true",
        dest="ignore",
        default=False,
        help="Ignore unidentified codes"
    )
    options.add_option(
        "--prefer",
        action="store",
        type="string",
        dest="prefer",
        default=None,
        help="Language to prefer for codes written in more than one."
    )

    (options, args) = options.parse_args()
    data = {}
    for file in args:
        print("Reading " + file)
        data[file] = filter(pd.read_csv(file), options.ignore)

    total = aggregate(data)
    total = sortToList(total)
    output(args, total, options)


if __name__ == "__main__":
    generateReport()

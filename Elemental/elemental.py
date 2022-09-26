#
# See whether a word can be expressed in terms of the checmical abbreviations used for
# elements, and, if so, in what ways.
#
# For instance, carbon can be expressed as Ca, Rb, O, N (Calcium Rubidium, Oxygen, Nitrogen),
# or Carbon, Argon, Boron, Oxygen, Nitrogen (C, Ar, B, O, N)
# If no input us given, then all of the element names themselves are encoded...
#
# Jim Cownie 25 July 2022
#
# License: Apache License with LLVM exceptions.
#

elements = {
    "H": "Hydrogen",
    "He": "Helium",
    "Li": "Lithium",
    "Be": "Beryllium",
    "B": "Boron",
    "C": "Carbon",
    "N": "Nitrogen",
    "O": "Oxygen",
    "F": "Fluorine",
    "Ne": "Neon",
    "Na": "Sodium",
    "Mg": "Magnesium",
    "Al": "Aluminium",
    "Si": "Silicon",
    "P": "Phosphorus",
    "S": "Sulphur",
    "Cl": "Chlorine",
    "Ar": "Argon",
    "K": "Potassium",
    "Ca": "Calcium",
    "Sc": "Scandium",
    "Ti": "Titanium",
    "V": "Vanadium",
    "Cr": "Chromium",
    "Mn": "Manganese",
    "Fe": "Iron",
    "Co": "Cobalt",
    "Ni": "Nickel",
    "Cu": "Copper",
    "Zn": "Zinc",
    "Ga": "Gallium",
    "Ge": "Germanium",
    "As": "Arsenic",
    "Se": "Selenium",
    "Br": "Bromine",
    "Kr": "Krypton",
    "Rb": "Rubidium",
    "Sr": "Strontium",
    "Y": "Yttrium",
    "Zr": "Zirconium",
    "Nb": "Niobium",
    "Mo": "Molybdenum",
    "Tc": "Technetium",
    "Ru": "Ruthenium",
    "Rh": "Rhodium",
    "Pd": "Palladium",
    "Ag": "Silver",
    "Cd": "Cadmium",
    "In": "Indium",
    "Sn": "Tin",
    "Sb": "Antimony",
    "Te": "Tellurium",
    "I": "Iodine",
    "Xe": "Xenon",
    "Cs": "Caesium",
    "Ba": "Barium",
    "La": "Lanthanum",
    "Ce": "Cerium",
    "Pr": "Praseodymium",
    "Nd": "Neodymium",
    "Pm": "Promethium",
    "Sm": "Samarium",
    "Eu": "Europium",
    "Gd": "Gadolinium",
    "Tb": "Terbium",
    "Dy": "Dysprosium",
    "Ho": "Holmium",
    "Er": "Erbium",
    "Tm": "Thulium",
    "Yb": "Ytterbium",
    "Lu": "Lutetium",
    "Hf": "Hafnium",
    "Ta": "Tantalum",
    "W": "Tungsten",
    "Re": "Rhenium",
    "Os": "Osmium",
    "Ir": "Iridium",
    "Pt": "Platinum",
    "Au": "Gold",
    "Hg": "Mercury",
    "Tl": "Thallium",
    "Pb": "Lead",
    "Bi": "Bismuth",
    "Po": "Polonium",
    "At": "Astatine",
    "Rn": "Radon",
    "Fr": "Francium",
    "Ra": "Radium",
    "Ac": "Actinium",
    "Th": "Thorium",
    "Pa": "Protactinium",
    "U": "Uranium",
    "Np": "Neptunium",
    "Pu": "Plutonium",
    "Am": "Americium",
    "Cm": "Curium",
    "Bk": "Berkelium",
    "Cf": "Californium",
    "Es": "Einsteinium",
    "Fm": "Fermium",
    "Md": "Mendelevium",
    "No": "Nobelium",
    "Lr": "Lawrencium",
    "Rf": "Rutherfordium",
    "Db": "Dubnium",
    "Sg": "Seaborgium",
    "Bh": "Bohrium",
    "Hs": "Hassium",
    "Mt": "Meitnerium",
    "Ds": "Darmstadtium",
    "Rg": "Roentgenium",
    "Cn": "Copernicium",
    "Nh": "Nihonium",
    "Fl": "Flerovium",
    "Mc": "Moscovium",
    "Lv": "Livermorium",
    "Ts": "Tennessine",
    "Og": "Oganesson",
}


def attempt(useNames, text, prefixLen):
    """Try a prefix of the given length
    useNames requests use of the whole element name, if True
    text is the text to encode
    prefixLen is the length of the prefix to attempt to replace.
    """
    # print ("*** Encoding \""+text+"\" trying prefix of " + str(prefixLen))
    numChars = len(text)
    if prefixLen > numChars:
        return []
    potentialElement = text[0:prefixLen].capitalize()
    elementName = elements.get(potentialElement, None)

    if not elementName:
        # Failed to find a matching element abbreviation
        return []

    tag = elementName if useNames else potentialElement
    if numChars == prefixLen:
        # We're at the end, no need to do anything more,
        return [tag]
    # There's still stuff to encode, so recurse to do that.
    tailSolutions = encode(useNames, text[prefixLen:])
    return [tag + "," + soln for soln in tailSolutions] if tailSolutions else []


def encode(useNames, text):
    """Return all possible encodings of the given text into element
    symbols, returning a list of encodings which are either the element
    abbreviations, or their names.
    """

    results = []
    if len(text) > 1:
        # First try for a two letter element
        results = attempt(useNames, text, 2)
    # Now try for a single letter solution
    results += attempt(useNames, text, 1)
    return results


def doEncoding():
    """Main program.
    One optional flag:
        --a    Output element abbreviations, rather than names
    If present arguments are encoded. If there are none, then all of the element names are encoded.
"""
    from optparse import OptionParser

    options = OptionParser()
    # Add options here
    options.add_option(
        "--a",
        action="store_true",
        dest="abbreviations",
        default=False,
        help="Use the element abbreviations rather thane names when showing the encodings",
    )

    (options, args) = options.parse_args()
    if not args:
        args = sorted(elements.values())

    for word in args:
        encodings = encode(not options.abbreviations, word)
        print(word + ": ", end="")
        if len(encodings) == 0:
            print(" no encoding")
        else:
            print(str(len(encodings)) + " solution" +("s" if len(encodings)>1 else "") +" => " + "; ".join(encodings))


if __name__ == "__main__":
    doEncoding()

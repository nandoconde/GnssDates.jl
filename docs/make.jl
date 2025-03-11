using GnssDates
using Changelog
using Documenter
using Documenter.Remotes: GitHub

DocMeta.setdocmeta!(GnssDates, :DocTestSetup, :(using GnssDates); recursive = true)

# generate release notes
Changelog.generate(
    Changelog.Documenter(),                 # output type
    joinpath(@__DIR__, "../CHANGELOG.md"),  # input file
    joinpath(@__DIR__, "src/release-notes.md"); # output file
    repo = "nandoconde/GnssDates.jl",       # default repository for links
)

# generate documentation
makedocs(;
    modules = [GnssDates],
    format = Documenter.HTML(;
        prettyurls = !("local" in ARGS),
        canonical = "https://nandoconde.github.io/GnssDates.jl",
        assets = ["assets/favicon.ico"],
        highlights = ["yaml", "toml"],
        ansicolor = true,
        size_threshold_ignore = ["release-notes.md"],
    ),
    authors = "Fernando Conde-Pumpido",
    linkcheck = true,
    doctest = :true,
    build = "build",
    sitename = "GnssDates.jl",
    repo = GitHub("nandoconde", "GnssDates.jl"),
    pages = Any[
        "index.md",
        "Manual" => String[
            "manual/01-timescales.md",
            "manual/02-time-intervals.md",
            "manual/03-operations.md",
            "manual/04-integration-with-dates.md",
        ],
        "Reference" => String[
            "reference/01-api.md",
            "reference/02-package-dependencies.md",
        ],
        "Developers" => String[
            "developers/01-internals.md",
            "developers/02-contributing.md",
            "developers/03-devdocs.md",
            "developers/04-checklists.md",
        ],
        "release-notes.md",
    ],
)

deploydocs(;
    repo = "github.com/nandoconde/GnssDates.jl.git",
    target = "build",
    devbranch="main",
    branch="gh-pages",
)

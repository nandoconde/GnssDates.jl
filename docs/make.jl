using GnssDates
using Documenter

DocMeta.setdocmeta!(GnssDates, :DocTestSetup, :(using GnssDates); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers
const numbered_pages = [
    file for file in readdir(joinpath(@__DIR__, "src")) if
    file != "index.md" && splitext(file)[2] == ".md"
]

makedocs(;
    modules = [GnssDates],
    authors = "nandoconde <fernando.conde.pumpido@outlook.com>",
    repo = "https://github.com/nandoconde/GnssDates.jl/blob/{commit}{path}#{line}",
    sitename = "GnssDates.jl",
    format = Documenter.HTML(; canonical = "https://nandoconde.github.io/GnssDates.jl"),
    pages = ["index.md"; numbered_pages],
)

deploydocs(; repo = "github.com/nandoconde/GnssDates.jl")

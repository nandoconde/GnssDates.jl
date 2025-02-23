var documenterSearchIndex = {"docs":
[{"location":"developers/03-devdocs/#Devdocs","page":"Devdocs","title":"Devdocs","text":"","category":"section"},{"location":"developers/03-devdocs/#First-time-clone","page":"Devdocs","title":"First time clone","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"If this is the first time you work with this repository, clone the repository doing:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Fork this repo\nClone your repo (this will create a git remote called origin)\nAdd this repo as a remote:\ngit remote add upstream https://github.com/nandoconde/GnssDates.jl","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"This will ensure that you have two remotes in your git: origin and upstream. You will create branches and push to origin, and you will fetch and update your local main branch from upstream.","category":"page"},{"location":"developers/03-devdocs/#Linting-and-formatting","page":"Devdocs","title":"Linting and formatting","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"This section provides info with the tools needed to format the source code before merging. If you do not feel confident installing these tools or you would rather not do it, do not worry about it, and we will download your branch and submit a PR to it with the formatted code before merging.","category":"page"},{"location":"developers/03-devdocs/#Testing","page":"Devdocs","title":"Testing","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"As with most Julia packages, you can just open Julia in the repository folder, activate the environment, and run test:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"julia> # press ]\npkg> activate .\npkg> test","category":"page"},{"location":"developers/03-devdocs/#Working-on-a-new-issue","page":"Devdocs","title":"Working on a new issue","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"We try to keep a linear history in this repo, so it is important to keep your branches up-to-date.","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Fetch from the remote and fast-forward your local main\ngit fetch upstream\ngit switch main\ngit merge --ff-only upstream/main\nBranch from main to address the issue (see below for","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"naming)","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"bash    git switch -c 42-add-answer-universe","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Push the new local branch to your personal remote repository\ngit push -u origin 42-add-answer-universe\nCreate a pull request to merge your remote branch into the org main.","category":"page"},{"location":"developers/03-devdocs/#Branch-naming","page":"Devdocs","title":"Branch naming","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"If there is an associated issue, add the issue number.\nIf there is no associated issue, and the changes are small, add a prefix","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"such as \"typo\", \"hotfix\", \"small-refactor\", according to the type of update.","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"If the changes are not small and there is no associated issue, then create","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"the issue first, so we can properly discuss the changes.","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Use dash separated imperative wording related to the issue (e.g.,","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"14-add-tests, 15-fix-model, 16-remove-obsolete-files).","category":"page"},{"location":"developers/03-devdocs/#Commit-message","page":"Devdocs","title":"Commit message","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Use imperative or present tense, for instance: Add feature or Fix bug.\nHave informative titles.\nWhen necessary, add a body with details.\nIf there are breaking changes, add the information to the commit message.","category":"page"},{"location":"developers/03-devdocs/#Before-creating-a-pull-request","page":"Devdocs","title":"Before creating a pull request","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"tip: Atomic git commits\nTry to create \"atomic git commits\" (recommended reading: The Utopic Git History).","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Make sure the tests pass.\nMake sure the files have been formatted with the latest Runic.jl release.\nFetch any main updates from upstream and rebase your branch, if necessary:\ngit fetch upstream\ngit rebase upstream/main BRANCH_NAME\nThen you can open a pull request and work with the reviewer to address any","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"issues.","category":"page"},{"location":"developers/03-devdocs/#Building-and-viewing-the-documentation-locally","page":"Devdocs","title":"Building and viewing the documentation locally","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Following the latest suggestions, we recommend using LiveServer to build the documentation. Here is how you do it:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Run julia --project=docs to open Julia in the environment of the docs.\nIf this is the first time building the docs\nPress ] to enter pkg mode\nRun pkg> dev . to use the development version of your package\nPress backspace to leave pkg mode\nRun julia> using LiveServer\nRun julia> servedocs()","category":"page"},{"location":"developers/03-devdocs/#Making-a-new-release","page":"Devdocs","title":"Making a new release","text":"","category":"section"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"To create a new release, you can follow these simple steps:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Create a branch release-x.y.z\nUpdate version in Project.toml\nUpdate the CHANGELOG.md:\nRename the section \"Unreleased\" to \"[x.y.z] - yyyy-mm-dd\" (i.e., version\nunder brackets, dash, and date in ISO format)\nAdd a new section on top of it named \"Unreleased\"\nAdd a new link in the bottom for version \"x.y.z\"\nChange the \"[unreleased]\" link to use the latest version - end of line,\nvx.y.z ... HEAD.\nCreate a commit \"Release vx.y.z\", push, create a PR, wait for it to pass,","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"merge the PR.","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Go back to main screen and click on the latest commit (link:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"https://github.com/nandoconde/GnssDates.jl/commit/main)","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"At the bottom, write @JuliaRegistrator register","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"After that, you only need to wait and verify:","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Wait for the bot to comment (should take < 1m) with a link to a RP to the","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"registry","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Follow the link and wait for a comment on the auto-merge\nThe comment should said all is well and auto-merge should occur shortly\nAfter the merge happens, TagBot will trigger and create a new GitHub tag.","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"Check on https://github.com/nandoconde/GnssDates.jl/releases","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"After the release is created, a \"docs\" GitHub action will start for the tag.\nAfter it passes, a deploy action will run.\nAfter that runs, the","category":"page"},{"location":"developers/03-devdocs/","page":"Devdocs","title":"Devdocs","text":"stable docs should be updated. Check them and look for the version number.","category":"page"},{"location":"reference/01-api/#api","page":"API","title":"API","text":"","category":"section"},{"location":"reference/01-api/#Contents","page":"API","title":"Contents","text":"","category":"section"},{"location":"reference/01-api/","page":"API","title":"API","text":"Pages = [\"reference/01-api.md\"]","category":"page"},{"location":"reference/01-api/#Index","page":"API","title":"Index","text":"","category":"section"},{"location":"reference/01-api/","page":"API","title":"API","text":"Pages = [\"reference/01-api.md\"]","category":"page"},{"location":"reference/01-api/","page":"API","title":"API","text":"Modules = [GnssDates]","category":"page"},{"location":"reference/01-api/#GnssDates.GnssDates","page":"API","title":"GnssDates.GnssDates","text":"Package with definitions to work with GNSS datetimes and time intervals.\n\nAbstract types: SystemTime, CoarseTime, FineTime, TimeDelta\nTime references: GnssTime, GPST, GST\nTime intervals: CoarseTimeDelta, FineTimeDelta\nOperators: +, -, ==, >, >=, <, <=\n\n\n\n\n\n","category":"module"},{"location":"reference/01-api/#GnssDates.GAL_WEEK_OFFSET","page":"API","title":"GnssDates.GAL_WEEK_OFFSET","text":"Week Number offset between GST and GnssTime.\n\n\n\n\n\n","category":"constant"},{"location":"reference/01-api/#GnssDates.GPST₀","page":"API","title":"GnssDates.GPST₀","text":"Origin of GPST.\n\n\n\n\n\n","category":"constant"},{"location":"reference/01-api/#GnssDates.GST₀","page":"API","title":"GnssDates.GST₀","text":"Origin of GST.\n\n\n\n\n\n","category":"constant"},{"location":"reference/01-api/#GnssDates.LEAP_SECOND_TAI_OFFSET","page":"API","title":"GnssDates.LEAP_SECOND_TAI_OFFSET","text":"Time difference in seconds between UTC and TAI at origin of GnssTime.\n\n\n\n\n\n","category":"constant"},{"location":"reference/01-api/#GnssDates.SECONDS_IN_WEEK","page":"API","title":"GnssDates.SECONDS_IN_WEEK","text":"Number of seconds in a week.\n\n\n\n\n\n","category":"constant"},{"location":"reference/01-api/#GnssDates.CoarseTime","page":"API","title":"GnssDates.CoarseTime","text":"Abstract supertype for all coarse time references.\n\nCoarse time references are characterized for always having two fields:\n\nwn::Int64: integer weeks elapsed since origin of time reference.\ntow::Int64: integer seconds elapsed since beginning of week.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.CoarseTimeDelta","page":"API","title":"GnssDates.CoarseTimeDelta","text":"CoarseTimeDelta(weeks, seconds)\n\nTime interval with integer-second resolution.\n\nThe constructor can convert automatically from other date and datetime types.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.FineTime","page":"API","title":"GnssDates.FineTime","text":"Abstract supertype for all fine time references.\n\nFine time references are characterized for always having three fields:\n\nwn::Int64: integer weeks elapsed since origin of time reference.\ntow_int::Int64: integer seconds elapsed since beginning of week.\ntow_frac::Int64: seconds elapsed since tow_int as a floating point number.\n\nCurrently, the only implementation of a FineTime is GnssTime.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.FineTimeDelta","page":"API","title":"GnssDates.FineTimeDelta","text":"FineTimeDelta(weeks, seconds, seconds_frac)\n\nTime interval with subsecond resolution.\n\nThe constructor can convert automatically from other date and datetime types.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.GPST","page":"API","title":"GnssDates.GPST","text":"GPST(wn, tow) <: CoarseTime\n\nCoarse time reference as disseminated by GPS.\n\nResolution\n\nIt has integer-second resolution because TOW is represented by an Int64. WN does not rollover (it keeps counting since GPST₀ continuously.)\n\nMore info\n\nCheck Time References in GNSS for more info.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.GPST-Tuple{Dates.DateTime, Type{Dates.UTC}}","page":"API","title":"GnssDates.GPST","text":"GPST(t::DateTime, UTC)\n\nConvert from DateTime assumming that t is a UTC time.\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.GPST-Tuple{Union{Dates.Date, Dates.DateTime, SystemTime}}","page":"API","title":"GnssDates.GPST","text":"GPST(t::T)\n\nConvert from time reference of type T to GPST.\n\nValid types are:\n\nT::SystemTime\nT::Date\nT::DateTime\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.GST","page":"API","title":"GnssDates.GST","text":"GST(wn, tow) <: CoarseTime\n\nCoarse time reference as disseminated by Galileo.\n\nResolution\n\nIt has integer-second resolution because TOW is represented by an Int64. WN does not rollover (it keeps counting since GST₀ continuously.)\n\nMore info\n\nCheck Time References in GNSS for more info.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.GST-Tuple{Dates.DateTime, Type{Dates.UTC}}","page":"API","title":"GnssDates.GST","text":"GST(t::DateTime, UTC)\n\nConvert from DateTime assumming that t is a UTC time.\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.GST-Tuple{Union{Dates.Date, Dates.DateTime, SystemTime}}","page":"API","title":"GnssDates.GST","text":"GST(t::T)\n\nConvert from time reference of type T to GST.\n\nValid types are:\n\nT::SystemTime\nT::Date\nT::DateTime\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.GnssTime","page":"API","title":"GnssDates.GnssTime","text":"GnssTime(wn, tow_int, tow_frac) <: FineTime\n\nAbsolute time reference whose origin is aligned to GPS's.\n\nResolution\n\nIt has subsecond resolution down to femtoseconds because it uses Float64 to represent decimal part of the current second. WN does not rollover (it keeps counting since GPST₀ continuously.)\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.GnssTime-Tuple{Dates.DateTime, Type{Dates.UTC}}","page":"API","title":"GnssDates.GnssTime","text":"GnssTime(t::DateTime, UTC)\n\nConvert from DateTime assumming  that t is a UTC time.\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.GnssTime-Tuple{Union{Dates.Date, Dates.DateTime, SystemTime}}","page":"API","title":"GnssDates.GnssTime","text":"GnssTime(t::T)\n\nConvert from time reference of type T to GnssTime.\n\nValid types are:\n\nT::SystemTime\nT::Date\nT::DateTime\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates.SystemTime","page":"API","title":"GnssDates.SystemTime","text":"Abstract supertype for all time references.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates.TimeDelta","page":"API","title":"GnssDates.TimeDelta","text":"Abstract supertype for all time intervals.\n\n\n\n\n\n","category":"type"},{"location":"reference/01-api/#GnssDates._canon_coarsedelta-Tuple{Int64, Int64}","page":"API","title":"GnssDates._canon_coarsedelta","text":"_canon_coarsedelta(w, s) -> Tuple{Int,Int}\n\nNormalize a (w, s) tuple following that:\n\ns ∈ [0, SECONDS_IN_WEEK) if it is a positive interval\ns ∈ [0, -SECONDS_IN_WEEK) if it is a negative interval\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates._canon_coarsetime-Tuple{Int64, Int64}","page":"API","title":"GnssDates._canon_coarsetime","text":"_canon_coarsetime(wn, tow) -> Tuple{Int,Int}\n\nNormalize a (wn, tow) tuple following that:\n\ntow ∈ [0, SECONDS_IN_WEEK)\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates._canon_finedelta-Tuple{Int64, Int64, Float64}","page":"API","title":"GnssDates._canon_finedelta","text":"_canon_finedelta(w, s, sf) -> Tuple{Int,Int}\n\nNormalize a (w, s, sf) tuple following that:\n\ns ∈ [0, SECONDS_IN_WEEK) if it is a positive interval\ns ∈ [0, -SECONDS_IN_WEEK) if it is a negative interval\nsf ∈ [0.0, 1.0) if it is a positive interval\ns ∈ [0, -1.0) if it is a negative interval\n\n\n\n\n\n","category":"method"},{"location":"reference/01-api/#GnssDates._canon_finetime-Tuple{Int64, Int64, Float64}","page":"API","title":"GnssDates._canon_finetime","text":"_canon_finetime(wn, tow, towf) -> Tuple{Int,Int,Float64}\n\nNormalize a (wn, tow, towf) tuple following that:\n\ntow ∈ [0, SECONDS_IN_WEEK)\ntowf ∈ [0.0, 1.0)\n\n\n\n\n\n","category":"method"},{"location":"release-notes/","page":"Changelog","title":"Changelog","text":"EditURL = \"https://github.com/nandoconde/GnssDates.jl/blob/master/CHANGELOG.md\"","category":"page"},{"location":"release-notes/#Changelog","page":"Changelog","title":"Changelog","text":"","category":"section"},{"location":"release-notes/","page":"Changelog","title":"Changelog","text":"The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.","category":"page"},{"location":"release-notes/#[Unreleased]","page":"Changelog","title":"[Unreleased]","text":"","category":"section"},{"location":"release-notes/#[1.0.0]-2024-11-28","page":"Changelog","title":"[1.0.0] - 2024-11-28","text":"","category":"section"},{"location":"release-notes/#Added","page":"Changelog","title":"Added","text":"","category":"section"},{"location":"release-notes/","page":"Changelog","title":"Changelog","text":"Add type system\nAdd GnssTime for absolute common reference\nAdd coarse SystemTimes for Galileo (GST) and GPS (GPST)\nAdd time intervals (TimeDelta)\nAdd docs\nAdd devdocs\nAdd tests\nAdd doctests","category":"page"},{"location":"developers/02-contributing/#contributing","page":"Contributing guide","title":"Contributing guide","text":"","category":"section"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"First of all, thanks for the interest!","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"We welcome all kinds of contribution, including, but not limited to code, documentation, examples, configuration, issue creating, tests, etc.","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"Be polite and respectful, and follow the issue and PR templates to ease the collaboration process.","category":"page"},{"location":"developers/02-contributing/#Before-starting","page":"Contributing guide","title":"Before starting","text":"","category":"section"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"We are completely open to new ideas and features, but the core of this package is providing time management for other GNSS packages in a way that feels both minimal but feature complete. This means that any new feature should minimize:","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"Adding dependencies\nBreaking old code\nAdding different ways to do the same","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"If you detect an issue with the existing code or have a feature request, please open a GitHub issue.","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"tip: Tip\nFeel free to ping @nandoconde after a few days if there are no responses.","category":"page"},{"location":"developers/02-contributing/#How-to-contribute","page":"Contributing guide","title":"How to contribute","text":"","category":"section"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"If you found an issue that interests you, comment on that issue what your plans are. If the solution to the issue is clear, you can immediately create a pull request (see below). Otherwise, say what your proposed solution is and wait for a discussion around it.","category":"page"},{"location":"developers/02-contributing/","page":"Contributing guide","title":"Contributing guide","text":"To create the PR, please check the instructions in Devdocs, and don't forget to take all the necessary steps.","category":"page"},{"location":"manual/04-integration-with-dates/#datesintegration","page":"Integration with Dates","title":"Integration with Dates","text":"","category":"section"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"It is very likely that a user needs to convert back and forth from a GNSS time representation and a more human-readable one. GnssDates leverages the standard library Dates to provide this functionality.","category":"page"},{"location":"manual/04-integration-with-dates/#DateTime","page":"Integration with Dates","title":"DateTime","text":"","category":"section"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Conversion to/from DateTime and SystemTime works either via Base.convert or with a constructor directly. DateTimes beyond the origin of the timescale are supported.","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"julia> using GnssDates\n\njulia> using Dates\n\njulia> Base.convert(DateTime, GST(967, 432000))\n2018-03-09T00:00:00\n\njulia> DateTime(GPST(0,0))\n1980-01-06T00:00:00\n\njulia> DateTime(GnssTime(0, -1, 0.9999))\n1980-01-05T23:59:59.999","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Note that the origin of the timescale is taken as the reference DateTime and seconds elapsed in the GNSS timescale are added as they are to the reference DateTime without accounting for leap seconds at all. For more information, see the section below on UTC.","category":"page"},{"location":"manual/04-integration-with-dates/#Date","page":"Integration with Dates","title":"Date","text":"","category":"section"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Conversion to a Date works similarly. The corresponding date is formed counting whole days from the origin of the timescale.","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"julia> Base.convert(Date, GST(967, 432000))\n2018-03-09\n\njulia> Date(GnssTime(0,0, 0.1275))\n1980-01-06\n\njulia> Date(GPST(0,-1))\n1980-01-05","category":"page"},{"location":"manual/04-integration-with-dates/#Relation-with-UTC","page":"Integration with Dates","title":"Relation with UTC","text":"","category":"section"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Since most SystemTimes (though not all, see GLONASS) are continuous timescales and thus ot affected by leap seconds, they diverge from UTC time. To get the UTC time exactly corresponding to a SystemTime, the UTC type supplied by the Dates standard library is used as the second parameter in the constructor.","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"julia> DateTime(GST(967, 432000), UTC)\n2018-03-08T23:59:42\n\njulia> DateTime(GPST(0, 0), UTC)\n1980-01-06T00:00:00","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Please note that the conversion with UTC from a Date to a SystemTime is not supported in the sense that a day is a concept independent of UTC.","category":"page"},{"location":"manual/04-integration-with-dates/","page":"Integration with Dates","title":"Integration with Dates","text":"Also, no guarantees for correct UTC time conversion are made for DateTimes before the origin of GPST.","category":"page"},{"location":"manual/02-time-intervals/#timeintervals","page":"Time intervals","title":"Time intervals","text":"","category":"section"},{"location":"manual/02-time-intervals/","page":"Time intervals","title":"Time intervals","text":"The operations with timescales naturally results in time intervals (TimeDelta). These can be added or substracted to a SystemTime, resulting in another SystemTime. TimeDelta is also the result of substracting two SystemTime —representing the time difference between them—, and of the addition/subtraction of TimeDeltas.","category":"page"},{"location":"manual/02-time-intervals/#Type-hierarchy","page":"Time intervals","title":"Type hierarchy","text":"","category":"section"},{"location":"manual/02-time-intervals/","page":"Time intervals","title":"Time intervals","text":"All time interval are subtypes of TimeDelta. It is an abstract type with two concrete subtypes, each with a different precision. CoarseTimeDelta has second precision, whereas FineTimeDelta is used to represent intervals with sub-second precision.","category":"page"},{"location":"manual/02-time-intervals/","page":"Time intervals","title":"Time intervals","text":"julia> using GnssDates\n\njulia> CoarseTimeDelta(3, 127) # 3 weeks, 127 seconds\nCoarseTimeDelta(3, 127)\n\njulia> CoarseTimeDelta(-5, 127) # -5 weeks, +127 seconds -> -4 weeks, -604673 seconds\nCoarseTimeDelta(-4, -604673)\n\njulia> FineTimeDelta(10, 127, -0.5) # 10 weeks, 127 seconds, -0.5 seconds -> 10 weeks, 126 seconds, 0.5 seconds\nFineTimeDelta(10, 126, 0.5)","category":"page"},{"location":"manual/02-time-intervals/","page":"Time intervals","title":"Time intervals","text":"CoarseTimeDelta intervals arise from operating two CoarseTimes, and the result of operating a T <: CoarseTime with a CoarseTimeDelta will be another T <: CoarseTime.","category":"page"},{"location":"manual/02-time-intervals/","page":"Time intervals","title":"Time intervals","text":"Any operation involving FineTimeDelta or FineTime will always result in FineTimeDelta or FineTime.","category":"page"},{"location":"developers/01-internals/#Internals","page":"Internals","title":"Internals","text":"","category":"section"},{"location":"developers/01-internals/","page":"Internals","title":"Internals","text":"Most of the structure of the package can be inferred from the manual. Implementing new T <: SystemTimes requires only adding methods for:","category":"page"},{"location":"developers/01-internals/","page":"Internals","title":"Internals","text":"Constructor: T(...)\nConversion methods:\nBase.convert(::Type{T}, t::GnssTime)\nBase.convert(::Type{GnssTime}, t::T)\nConvenience constructors:\nT(t::Union{Date, DateTime, SystemTime})\nT(t::DateTime, ::Type{UTC}) = GST(GnssTime(t, UTC))","category":"page"},{"location":"manual/03-operations/#operations","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"","category":"section"},{"location":"manual/03-operations/#Operating-with-SystemTimes","page":"Operations with SystemTime and TimeDelta","title":"Operating with SystemTimes","text":"","category":"section"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"The time difference between two CoarseTime results in a CoarseTimeDelta.","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"julia> using GnssDates\n\njulia> GST(967, 432000) - GPST(1991, 431999)\nCoarseTimeDelta(0, 1)","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"The time difference between a FineTime and any other SystemTime results in a FineTimeDelta.","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"julia> GnssTime(1991, 432000, 0.0) - GPST(1991, 431999)\nFineTimeDelta(0, 1, 0.0)\n\njulia> GST(967, 432000) - GnssTime(1991, 431999, 0.0)\nFineTimeDelta(0, 1, 0.0)","category":"page"},{"location":"manual/03-operations/#Operating-with-TimeDelta","page":"Operations with SystemTime and TimeDelta","title":"Operating with TimeDelta","text":"","category":"section"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"The subtraction or addition of two CoarseTimeDelta results in a CoarseTimeDelta, but the subtraction or addition of a FineTimeDelta to any TimeDelta will always result in a FineTimeDelta.","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"julia> CoarseTimeDelta(10, 30) + CoarseTimeDelta(-7, -31)\nCoarseTimeDelta(2, 604799)\n\njulia> FineTimeDelta(10, 30, 0.0) + CoarseTimeDelta(-7, -31)\nFineTimeDelta(2, 604799, 0.0)\n\njulia> CoarseTimeDelta(10, 30) - FineTimeDelta(7, 31, -0.5)\nFineTimeDelta(2, 604799, 0.5)","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"The same happens with the subtraction or addition of a SystemTime and a TimeDelta: operations between a CoarseTime and a CoarseTimeDelta result in a CoarseTime of the same type. However, any operations between a SystemTime and aFineTimeDelta will result in a FineTime.","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"julia> GST(967, 432000) - CoarseTimeDelta(0, 1)\nGST(967, 431999)\n\njulia> GPST(1991, 431999) + CoarseTimeDelta(0, 1)\nGPST(1991, 432000)\n\njulia> GPST(1991, 431999) + FineTimeDelta(0, 1, 0.0)\nGnssTime(1991, 432000, 0.0)","category":"page"},{"location":"manual/03-operations/#Comparison","page":"Operations with SystemTime and TimeDelta","title":"Comparison","text":"","category":"section"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"Finally, of course, usual comparison operators among and between SystemTimes and TimeDeltas are defined.","category":"page"},{"location":"manual/03-operations/","page":"Operations with SystemTime and TimeDelta","title":"Operations with SystemTime and TimeDelta","text":"julia> GST(967, 432000) == GPST(1991, 432000)\ntrue\n\njulia> GST(967, 432000) == GnssTime(1991, 432000, 0.5)\nfalse\n\njulia> GST(967, 432000) == GnssTime(1991, 432000, 0.0)\ntrue\n\njulia> GST(967, 432000) < GnssTime(1991, 432000, 0.5)\ntrue\n\njulia> GST(967, 432000) >= GnssTime(1991, 432000, 0.0)\ntrue\n\njulia> CoarseTimeDelta(1, -1) == CoarseTimeDelta(0, GnssDates.SECONDS_IN_WEEK - 1)\ntrue\n\njulia> FineTimeDelta(10, 5, 0.0) <= CoarseTimeDelta(10, 5)\ntrue","category":"page"},{"location":"reference/02-package-dependencies/#Package-dependencies","page":"Package dependencies","title":"Package dependencies","text":"","category":"section"},{"location":"reference/02-package-dependencies/","page":"Package dependencies","title":"Package dependencies","text":"This package depends direclty only on one package outside of the standard library, LeapSeconds.jl. It would be awesome to keep it this way to maximize compatibility with past and future Julia versions.","category":"page"},{"location":"reference/02-package-dependencies/","page":"Package dependencies","title":"Package dependencies","text":"Current dependencies are:","category":"page"},{"location":"reference/02-package-dependencies/","page":"Package dependencies","title":"Package dependencies","text":"Dates\nLeapSeconds.jl","category":"page"},{"location":"manual/01-timescales/#timescales","page":"Timescales","title":"Timescales","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"Timescales are the means by which GNSS constellations keep the track of current time.","category":"page"},{"location":"manual/01-timescales/#Type-hierarchy","page":"Timescales","title":"Type hierarchy","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"All timescale types are subtypes of an abstract SystemTime. The precision of the timescale is reflected by another two abstract subtypes from SystemTime: CoarseTime and FineTime.","category":"page"},{"location":"manual/01-timescales/#System-implementations","page":"Timescales","title":"System implementations","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"The basic times associated to each constellation are CoarseTimes. These include:","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"Galileo: GST\nGPS: GPST\nOthers will come.","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"julia> using GnssDates\n\njulia> galt = GST(967, 432000)\nGST(967, 432000)\n\njulia> galt.wn\n967\n\njulia> galt.tow\n432000\n\njulia> gpst = GPST(1991, 432000)\nGPST(1991, 432000)","category":"page"},{"location":"manual/01-timescales/#High-resolution-time","page":"Timescales","title":"High-resolution time","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"The only provided subtype of FineTime is GnssTime. It is aligned in WN and TOW with GPS time, but also includes the decimal part of the current second as a Float64 between 0.0 (included) and 1.0 (not included).","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"julia> gnsst = GnssTime(967, 432000, 0.0)\nGnssTime(967, 432000, 0.0)","category":"page"},{"location":"manual/01-timescales/#Timescale-domain","page":"Timescales","title":"Timescale domain","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"These types can also represent times beyond the beginning of the timescale, using always positve TOW but negative WN.","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"The WN is not limited to that disseminated by the SIS. Just like RINEX files, it can count beyond the values that allow the usual 10 or 12 bits allocated for them in the SIS.","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"julia> GnssTime(0, -GnssDates.SECONDS_IN_WEEK + 75, 0.5)\nGnssTime(-1, 75, 0.5)\n\njulia> GST(966, 432000 + GnssDates.SECONDS_IN_WEEK)\nGST(967, 432000)\n\njulia> GPST(1992, 432000 - GnssDates.SECONDS_IN_WEEK)\nGPST(1991, 432000)","category":"page"},{"location":"manual/01-timescales/#Conversion-between-SystemTimes","page":"Timescales","title":"Conversion between SystemTimes","text":"","category":"section"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"Conversion between these types works as expected, and over/underflown values are automatically rolled over/under and converted to the appropriate times.","category":"page"},{"location":"manual/01-timescales/","page":"Timescales","title":"Timescales","text":"julia> gst = GST(967, 432000)\nGST(967, 432000)\n\njulia> gpst = GPST(gst)\nGPST(1991, 432000)\n\njulia> gnsst = GnssTime(gpst)\nGnssTime(1991, 432000, 0.0)\n\njulia> GST(gnsst)\nGST(967, 432000)","category":"page"},{"location":"developers/04-checklists/#checklists","page":"Checklists","title":"Checklists","text":"","category":"section"},{"location":"developers/04-checklists/#Request-a-new-feature","page":"Checklists","title":"Request a new feature","text":"","category":"section"},{"location":"developers/04-checklists/","page":"Checklists","title":"Checklists","text":"Open a GitHub issue\nDiscuss it there; feel free to ping the author after 3 days if no response","category":"page"},{"location":"developers/04-checklists/","page":"Checklists","title":"Checklists","text":"arrives.","category":"page"},{"location":"developers/04-checklists/","page":"Checklists","title":"Checklists","text":"Create a PR following the checklist in the next section.","category":"page"},{"location":"developers/04-checklists/#Creating-a-PR","page":"Checklists","title":"Creating a PR","text":"","category":"section"},{"location":"developers/04-checklists/","page":"Checklists","title":"Checklists","text":"Under construction...","category":"page"},{"location":"","page":"GnssDates.jl","title":"GnssDates.jl","text":"CurrentModule = GnssDates","category":"page"},{"location":"#index","page":"GnssDates.jl","title":"GnssDates.jl","text":"","category":"section"},{"location":"","page":"GnssDates.jl","title":"GnssDates.jl","text":"GNSS datetime references for Julia.","category":"page"},{"location":"","page":"GnssDates.jl","title":"GnssDates.jl","text":"A package for representing and manipulating dates and times from Global Navigation Satellite Systems (GNSS) and converting them to human-readable dates and times.","category":"page"},{"location":"#Package-Features","page":"GnssDates.jl","title":"Package Features","text":"","category":"section"},{"location":"","page":"GnssDates.jl","title":"GnssDates.jl","text":"GNSS timescales\nTime intervals\nConversion to/from Dates\nOperations with datetimes and intervals.","category":"page"},{"location":"#Manual-Outline","page":"GnssDates.jl","title":"Manual Outline","text":"","category":"section"},{"location":"","page":"GnssDates.jl","title":"GnssDates.jl","text":"Timescales\nTime intervals\nOperations\nIntegration with Dates","category":"page"}]
}

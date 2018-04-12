# Madden 16 Clustering

## Introduction

This project contains analysis of data from Madden 2016 on player clustering and archetype analysis, with papers on all players in general and quarterbacks in particular.
The data can be grouped into three general categories: Raw excel ratings data, R scripts for data analysis, and Paper writeups as HTML files and PDFs.


## How To Run This Code

This code requires R and performs best in RStudio with the RMarkdown and ggplot2 packages installed. 

Open the R markdown files (.Rmd) in RStudio and use the "knit" command.

## Data Files

### Excel Files

* [All_Player_Import.csv](All_Player_Import.csv): All raw attribute ratings for all players in Madden 2016 - REQUIRED FOR ALL OTHER FILES
* [AllScores.xlsx](AllScores.xlsx): All ratings for all players on archetypes
* [CenterScores.xls](CenterScores.xls): Ratings on each archetype for Centers
* [CornerbackScores.xls](CornerbackScores.xls): Ratings on each archetype for Cornerbacks
* [DefensiveEndScores.xls](DefensiveEndScores.xls): Ratings on each archetype for Defensive Ends
* [DefensiveTackleScores.xls](DefensiveTackleScores.xls): Ratings on each archetype for Defensive Tackles
* [FullbackScores.xls](FullbackScores.xls): Ratings on each archetype for Fullbacks
* [HalfbackScores.xls](HalfbackScores.xls): Ratings on each archetype for Halfbacks
* [InsideLinebackerScores.xls](InsideLinebackerScores.xls): Ratings on each archetype for Inside Linebackers
* [OffensiveGuardScores.xls](OffensiveGuardScores.xls): Ratings on each archetype for Guards
* [OffensiveTackleScores.xls](OffensiveTackleScores.xls): Ratings on each archetype for Offensive Tackles
* [OutsideLinebackerScores.xls](OutsideLinebackerScores.xls): Ratings on each archetype for Outside Linebackers
* [PlacekickerScores.xls](PlacekickerScores.xls): Ratings on each archetype for Kickers
* [PunterScores.xls](PunterScores.xls): Ratings on each archetype for Punters
* [QuarterbackScores.xls](QuarterbackScores.xls): Ratings on each archetype for Quarterbacks
* [SafetyScores.xls](SafetyScores.xls): Ratings on each archetype for Safeties
* [TightEndScores.xls](TightEndScores.xls): Ratings on each archetype for Tight Ends
* [WideReceiverScores.xls](WideReceiverScores.xls): Ratings on each archetype for Wide Receivers

### R Files

* [Centers_With_Overall.Rmd](Centers_With_Overall.Rmd): Rmarkdown document for Center analysis
* [Cornerbacks_With_Overall.Rmd](Cornerbacks_With_Overall.Rmd): Rmarkdown document for Cornerback analysis
* [Defensive_Ends_With_Overall.Rmd](Defensive_Ends_With_Overall.Rmd): Rmarkdown document for Defensive End analysis
* [Defensive_Tackles_With_Overall.Rmd](Defensive_Tackles_With_Overall.Rmd): Rmarkdown document for Defensive Tackle analysis
* [Fullbacks_With_Overall.Rmd](Fullbacks_With_Overall.Rmd): Rmarkdown document for Fullback analysis
* [Halfbacks_With_Overall.Rmd](Halfbacks_With_Overall.Rmd): Rmarkdown document for Halfback analysis
* [Inside_Linebackers_With_Overall.Rmd](Inside_Linebackers_With_Overall.Rmd): Rmarkdown document for Inside Linebacker analysis
* [Offensive_Guards_With_Overall.Rmd](Offensive_Guards_With_Overall.Rmd): Rmarkdown document for Guard analysis
* [Offensive_Tackles_With_Overall.Rmd](Offensive_Tackles_With_Overall.Rmd): Rmarkdown document for Offensive Tackle analysis
* [Outside_Linebackers_With_Overall.Rmd](Outside_Linebackers_With_Overall.Rmd): Rmarkdown document for Outside Linebacker analysis
* [Kickers_With_Overall.Rmd](Kickers_With_Overall.Rmd): Rmarkdown document for Kicker analysis
* [Punters_With_Overall.Rmd](Punters_With_Overall.Rmd): Rmarkdown document for Punter analysis
* [Quarterbacks_With_Overall.Rmd](Quarterbacks_With_Overall.Rmd): Rmarkdown document for Quarterback analysis
* [Safeties_With_Overall.Rmd](Safeties_With_Overall.Rmd): Rmarkdown document for Safety analysis
* [Tight_Ends_With_Overall.Rmd](Tight_Ends_With_Overall.Rmd): Rmarkdown document for Tight End analysis
* [Wide_Receivers_With_Overall.Rmd](Wide_Receivers_With_Overall.Rmd): Rmarkdown document for Wide Receiver analysis


## Writeups

### HTML Files

* [Centers_With_Overall.html](Centers_With_Overall.html): HTML document for Center analysis
* [Cornerbacks_With_Overall.html](Cornerbacks_With_Overall.html): HTML document for Cornerback analysis
* [Defensive_Ends_With_Overall.html](Defensive_Ends_With_Overall.html): HTML document for Defensive End analysis
* [Defensive_Tackles_With_Overall.html](Defensive_Tackles_With_Overall.html): HTML document for Defensive Tackle analysis
* [Fullbacks_With_Overall.html](Fullbacks_With_Overall.html): HTML document for Fullback analysis
* [Halfbacks_With_Overall.html](Halfbacks_With_Overall.html): HTML document for Halfback analysis
* [Inside_Linebackers_With_Overall.html](Inside_Linebackers_With_Overall.html): HTML document for Inside Linebacker analysis
* [Offensive_Guards_With_Overall.html](Offensive_Guards_With_Overall.html): HTML document for Guard analysis
* [Offensive_Tackles_With_Overall.html](Offensive_Tackles_With_Overall.html): HTML document for Offensive Tackle analysis
* [Outside_Linebackers_With_Overall.html](Outside_Linebackers_With_Overall.html): HTML document for Outside Linebacker analysis
* [Kickers_With_Overall.html](Kickers_With_Overall.html): HTML document for Kicker analysis
* [Punters_With_Overall.html](Punters_With_Overall.html): HTML document for Punter analysis
* [Quarterbacks_With_Overall.html](Quarterbacks_With_Overall.html): HTML document for Quarterback analysis
* [Safeties_With_Overall.html](Safeties_With_Overall.html): HTML document for Safety analysis
* [Tight_Ends_With_Overall.html](Tight_Ends_With_Overall.html): HTML document for Tight End analysis
* [Wide_Receivers_With_Overall.html](Wide_Receivers_With_Overall.html): HTML document for Wide Receiver analysis

### Papers

* [MaddenWriteup.pdf](MaddenWriteup.pdf): Categorization and Evaluation of players based on clustering analysis at all positions (Paper written in LaTeX)
* [Quarterbacks_Cluster_Paper.pdf](Quarterbacks_Cluster_Paper.pdf): Paper (written in LaTeX) about cluster analysis on quarterbacks

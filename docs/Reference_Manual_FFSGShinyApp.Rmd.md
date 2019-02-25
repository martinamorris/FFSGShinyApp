#Rd2md::ReferenceManual(pkg=getwd(), outdir = getwd(), verbose=FALSE)

<!-- toc -->

February 25, 2019

# DESCRIPTION

```
Package: FFSGShinyAppP
Type: Package
Title: Provides tools including an interactable shiny app to understand fatal encounters with police
Version: 0.1.0
Author: Madeline Cummins, Martina Morris
Maintainer: Madeline Cummins <maddic9@uw.edu>
Description: More about what it does (maybe more than one line)
    Use four spaces when indenting paragraphs within the Description.
License: What license is it under?
Encoding: UTF-8
LazyData: true
RoxygenNote: 6.1.0
Depends:
  shiny
Imports:
  cartogram,
  devtools,
  dplyr,
  DT,
  ggplot2,
  here,
  leaflet,
  maps,
  maptools,
  plotly,
  sp,
  stringr,
  tmap,
  tidyverse
Suggests: 
    knitr,
    rmarkdown
VignetteBuilder: knitr```


# `choroplethmap`: choroplethMap

## Description


 Creates a choropleth map of fatal encounters for the given year


## Usage

```r
choroplethmap(yeart = "mean")
```


## Arguments

Argument      |Description
------------- |----------------
```yeart```     |     an integer year between 2000 and 2017 or "mean", if blank calculates mean

## Value


 a chloropleth for the entered year


## Seealso


 [`plot_geo`](plot_geo.html) 


# `descstat`: descStat

## Description


 Stratifies a data set based on a given demographic
 Used within dstable and ds plot


## Usage

```r
descstat(dem, ds = fatalencounters)
```


## Arguments

Argument      |Description
------------- |----------------
```dem```     |     a demographic, the demographic the data is to be stratified for (Age, Gender, or Race)
```ds```     |     a data frame, data frame you want to be stratified, if no input uses fatalencounters

## Value


 stratified data frame


## Seealso


 [`dstable`](dstable.html) and [`dsplot`](dsplot.html) 


# `dsplot`: dsPlot

## Description


 Makes a table based off stratified data


## Usage

```r
dsplot(dem)
```


## Arguments

Argument      |Description
------------- |----------------
```dem```     |     a demographic, the demographic the data is to be stratified for (Age, Gender, or Race)

## Value


 ggplot of the resulting data from an in-method descstat call


## Seealso


 [`descstat`](descstat.html) and [`dstable`](dstable.html) and [`ggplot2`](ggplot2.html) 


# `dstable`: dsTable

## Description


 Makes a table based off stratified data


## Usage

```r
dstable(dem)
```


## Arguments

Argument      |Description
------------- |----------------
```dem```     |     a demographic, the demographic the data is to be stratified for (Age, Gender, or Race)

## Value


 data table of the resulting data from an in-method descstat call


## Seealso


 [`descstat`](descstat.html) and [`dsplot`](dsplot.html) 


# `ffcartogram`: ffCartogram

## Description


 Creates a cartogram of fatal encounters for the given year


## Usage

```r
ffcartogram(year)
```


## Arguments

Argument      |Description
------------- |----------------
```year```     |     an integer year between 2000 and 2017

## Value


 a cartogram for the entered year


## Seealso


 [`cartogram_cont`](cartogram_cont.html) 


# `permillcalc`: PerMillCalc

## Description


 Calculates the fatal encounters (per million population or total) for each state


## Usage

```r
permillcalc(x = fatalencounters, capita = TRUE)
```


## Arguments

Argument      |Description
------------- |----------------
```x```     |     a data frame of individual fatal encounter cases, default uses fatalencounters
```capita```     |     a boolean, if TRUE evaluates cases per million population of each state, if FALSE just calculates total cases, default is TRUE

## Value


 table a data frame of fatalencounter per state (evaluated per capita or as totals based on capita param)


# `permillgraph`: perMillGraph

## Description


 Creates a graph of fatal encounters by state


## Usage

```r
permillgraph(state, all, capita)
```


## Arguments

Argument      |Description
------------- |----------------
```state```     |     a state name, the state that is graphed or highlighted
```all```     |     a boolean, if TRUE graphs state over the data of other states, if FALSE graphs just the given state
```capita```     |     a boolean, if TRUE evaluates cases per million population of each state, if FALSE just calculates total cases

## Seealso


 [`permillcalc`](permillcalc.html) and [`permilltable`](permilltable.html) 


# `permilltable`: perMillTable

## Description


 Creates a table of fatal encounters by state


## Usage

```r
permilltable(statenm, all, capita)
```


## Arguments

Argument      |Description
------------- |----------------
```statenm```     |     a state name, the state that is displayed or highlighted
```all```     |     a boolean, if TRUE table includes all states, if FALSE table displays just the given state
```capita```     |     a boolean, if TRUE evaluates cases per million population of each state, if FALSE just calculates total cases

## Seealso


 [`permillcalc`](permillcalc.html) and [`permilltable`](permilltable.html) 



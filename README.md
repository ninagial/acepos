# ACEPOS: Explore Wikidata's Representation of Scientific Methods

Companion package to the study "LLM-Enhanced Sub-Ontology Development for Improved Interdisciplinary Discoverability in Scientific Investigation Methods and Tooling" (Giallousi, Maratsi, Alexopoulos, and Charalampidis, under review).
    
## What it does

- Climb up Wikidata's hierarchy, starting from arbitrary seed-words
- Convert the results to a graph
- Calculate descriptive and graph statistics on the results

## Interactive Plot

[!View Interactive Plot](https://ninagial.github.io/acepos.github.io/plot.html)

Using the interactive plot, the user can visualize the hierarchical depth and degree of Wikidata codes under which scientific techiques are classed. 
The size of the data points maps the nodes' (ie Wikidata terms') degree, in the resulting graph.

# Use case: Optimal Wikidata Code for a seed word


|     |TermStr                                           | Level|TermWD     |Node                        |URI                                      | Degree| Betweenness|
|:----|:-------------------------------------------------|-----:|:----------|:---------------------------|:----------------------------------------|------:|-----------:|
|6046 |Descriptive Phenomenological Method in Psychology |     1|Q5263799   |phenomenological psychology |http://www.wikidata.org/entity/Q5371079  |      7|     0.00000|
|5617 |Electroencephalography (EEG)                      |     2|Q179965    |medical imaging             |http://www.wikidata.org/entity/Q1347367  |    474|   314.94938|
|670  |Magnetic resonance imaging (MRI)                  |     3|Q161238    |physical examination        |http://www.wikidata.org/entity/Q151885   |    330|   249.00000|
|344  |Magnetic resonance imaging (MRI)                  |     3|Q161238    |biomedicine                 |http://www.wikidata.org/entity/Q16686448 |     98|    41.07828|
|3884 |High-performance liquid chromatography (HPLC)     |     4|Q381233    |analytical technique        |http://www.wikidata.org/entity/Q1799072  |     20|   275.00000|
|1294 |Polymerase chain reaction (PCR)                   |     4|Q856198    |diagnosis                   |http://www.wikidata.org/entity/Q1791627  |    678|  1242.99762|
|2703 |Functional magnetic resonance imaging (fMRI)      |     4|Q903809    |physical examination        |http://www.wikidata.org/entity/Q26907166 |    330|   249.00000|
|2988 |Functional magnetic resonance imaging (fMRI)      |     4|Q903809    |medicine                    |http://www.wikidata.org/entity/Q336      |    152|    50.11598|
|3615 |Functional magnetic resonance imaging (fMRI)      |     4|Q903809    |medical test                |http://www.wikidata.org/entity/Q13582682 |    319|   178.00000|
|2785 |Functional magnetic resonance imaging (fMRI)      |     5|Q903809    |biomedicine                 |http://www.wikidata.org/entity/Q7991     |     98|    41.07828|
|4374 |Electroencephalography (EEG)                      |     5|Q179965    |medical diagnosis           |http://www.wikidata.org/entity/Q1047113  |    618|   971.99792|
|4658 |Electroencephalography (EEG)                      |     6|Q179965    |depicting object            |http://www.wikidata.org/entity/Q45025858 |    104|   129.00000|
|4246 |Electroencephalography (EEG)                      |     7|Q179965    |specialty                   |http://www.wikidata.org/entity/Q177719   |    250|   471.69104|
|2662 |Functional magnetic resonance imaging (fMRI)      |     8|Q903809    |work                        |http://www.wikidata.org/entity/Q16644043 |     36|     3.00000|
|3652 |Scanning electron microscopy (SEM)                |     8|Q115684492 |temporal entity             |http://www.wikidata.org/entity/Q21004260 |    129|   122.45910|
|3405 |Functional magnetic resonance imaging (fMRI)      |     8|Q903809    |information resource        |http://www.wikidata.org/entity/Q177719   |     86|   115.57058|
|342  |Magnetic resonance imaging (MRI)                  |     9|Q161238    |artificial object           |http://www.wikidata.org/entity/Q864601   |    159|    78.24192|
|6200 |Thematic analysis                                 |    10|Q7781188   |occurrent                   |http://www.wikidata.org/entity/Q193181   |     22|    59.00000|
|2377 |Functional magnetic resonance imaging (fMRI)      |    10|Q903809    |abstract entity             |http://www.wikidata.org/entity/Q551875   |    158|    60.71667|
|5450 |Electroencephalography (EEG)                      |    11|Q179965    |entity                      |http://www.wikidata.org/entity/Q2671652  |    166|     0.00000|

For a given Term, the query fetches the different super-terms under which the Term has been assigned.
This is repeated for up to 11 levels of hierarchy.

The graph properties result from examining all the returned paths as a graph.
At each Level of the hierarchy, the different possible super-classes can be compared by their graph properties.
This presentation is trivial, but in theory a variety of graph algorithms can be used on the resulting graph.
This can be done for optimization or sanitization of the ontology.

__Theory point__: In the paper we point out issues with humanly curated ontologies and hierarchies.
We lean in favor of a principled approach, which for lack of space, we more coherently present in the Wiki.
We discuss the Dewey Decimal System approach to scienticic methods, which is more sophisticated, but also less granular
than Wikidata's. We argue that LLM's having broader oversight of different fields, might overcome the constraints
of domain specificity, which guides how DDC deals with most domain-specific methods.
The constraints are reproduced in a folksonomy like Wikidata, which we argue might have a sociological component.

__LLM prompting technique__: The semantic ontology Framenet was used, the frames Scrutiny and Active Perception more specifically, which suitable "role playing" prompting for information extraction. The LLM returned names of techniques with erroneous Wikidata codes. We fact checked 28 of the methods returned, and assigned the proper Wikidata codes manually.
Most of the rest analyses and transformations found in the two studies in the paper, can be readily reproduced with
the contents of this library. This is done in observation of the principles of open and reproducible research.


|                                          |   1|  2|  3|  4|  5|   6|   7|  8|  9|  10|  11|
|:-----------------------------------------|---:|--:|--:|--:|--:|---:|---:|--:|--:|---:|---:|
|Q16644043  |   0|  0|  0|  0| 36| 105| 114| 66| 18|   0|   0|
|Q177719    |   0|  0|  0|  0|  0|  36| 105| 95| 55|  18|   0|
|Q931309    |   0|  0|  0|  0|  0|   0|   0|  0| 55| 159|  46|
|Q551875    |   0|  0|  0|  0|  0|   0|   0|  0|  0| 118| 110|
|Q105948247 |   1|  5| 48| 85| 52|  18|   7|  4|  1|   0|   0|
|Q3622126   |   5| 48| 85| 52| 18|   7|   4|  1|  0|   0|   0|
|Q35120     | 166|  0|  0|  0|  0|   0|   0|  0|  0|   0|   0|
| Q2671652    |    0 |   0 |   0 |   0 |   0 |    0 |    0 |  42 |  92 |   20 |   11 |
| Q835153     |    0 |   0 |   0 |   0 |   0 |    0 |   42 |  92 |  20 |   11 |    0 |
| Q336        |    0 |   1 |   5 |  40 |  60 |   28 |   12 |   4 |   2 |    0 |    0 |

The above table contains absolute frequencies of super-terms at each level of abstraction, across all seed-terms.

# Example use

```r
# R 4.3.3
# Not Run
library(acepos)

# `all_paths`, `all_parsed_responses`, and `RAWINSTRUMENTS` are data objects provided by the library, and explained in the next section
path_vec <- new("PathVector", paths=lapply(all_paths, list))
graph_obj1 <- paths_to_graph(path_vec)
analysis_obj1 <- wikidata_analysis(graph_obj1)
unified_data <- aggregate_path_metrics(graph_obj1, analysis_obj1, all_parsed_responses, RAWINSTRUMENTS)

# inspect the resulting objects
str(path_vec)
str(graph_obj1, max.level=2)
str(analysis_obj1, max.level=2)
str(unified_data, max.level=2)

# inspect the aggregate data.frame
str(unified_data$data)
head(unified_data$data)
tail(unified_data$data)

# map the fetched hierarchy
print(analysis_obj1$plots$p1)

```

# Requests against Wikidata endpoint

This briefly outlines how to reproduce the study's data acquisition, from within the library.

The script actually used in the November study, as well as the resulting objects are included in the package. 
(Those objects coincide with the ones available at `data(package='acepos')`.)

```
# Not Run
# All these objects are created within a new environment, just for the replication purposes

november_replication <- new.env()
with(november_replication, {
	baseurl = 'https://query.wikidata.org/sparql'
	useragent = paste("WDQS-Example", R.version.string)

	# default argument is a filename in both following functions
	querytemplate <- load_query_template(fn="data-raw/query_template")
	instruments_df <- load_instruments_file(fn="data-raw/instruments.csv")

	# relies internally on `prepare_query()`
        endpoint_response <- wikidata_sparql_query(instruments_df$Wikidata, baseurl, useragent, querytemplate)
	
	# the equivalents of the november script objects are
	all_responses = endpoint_response$fetched
	all_parsed_responses = endpoint_response$parsed
	all_paths = endpoint_response$paths

})
```

# Mini-Paper Replication (aka Study I)

In the first iteration the seed data were queried manually, and only three domains were used (Psychology, Neuroscience, Cultural Heritage).

The library functions can be applied, the only difference being the initial paths.

```
# Not Run

minipaper_replication <- new.env()
with(minipaper_replication, {


	split_paths <- process_raw_paths("data-raw/raw_paths.txt")

	all_paths <- new("PathVector", paths=split_paths)

})

```

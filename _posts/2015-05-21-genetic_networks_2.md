---
layout: lab
title: Genetic Networks In-depth
hidden: true
tags:
     - networks
---
## Day 2 Concepts

# Part II
## Graph Models
Nodes:

* abstract concept that can represent data or process
* examples of social and biological nodes

**(PersonA)**

**(PersonB)**

**(A)**    **(B)**    **(C)**

**(Gene1)**    **(Gene2)**    **(Gene3)**

Relationships:
* abstract concept that can represent data or process
* examples of social nodes

**(PersonA)--knows--(PersonB)**

**(PersonB)--doesnotknow--(PersonC)**

**(PersonC)--knows--(PersonB)**

Simplified:

**(A)--1--(B)**

**(A)--0--(C)**

**(B)--1--(C)**

# Concept Outline

### Relationships
* adjacency 
* corr based networks
* other weightings
* social networks examples

### Graphs
* intro to graphs
* igraph basics
* now code simple social network by hand
* ask question that requires following information along network

### Brief intro of shade avoidance and dataset we will be working with
* see how much Julin did this

### Gene co-expression networks and phenotype networks
* transition from social network to gene-gene interaction example
* code small shade avoidance network beforehand to play with
* ask biologically motivated question with simulated shade network

### Break into teams for network construction
* have each team (or set of) create networks for tissue types - need to double check time
* create adjacency network first- visualize with heatmap
* use either WGCNA or Network package to create full network - need to do speed comparisons

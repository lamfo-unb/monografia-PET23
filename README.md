# Term Paper Research Project: "Assessing Volatility Spillovers in the Aftermath of the 2022 Ukraine-Russia Conflict: A Multivariate GARCH-BEKK Analysis"

**Department of Economics / University of Brasília**

**Vítor Bandeira Borges**  
**Beatriz Woo Chang**  
**Rafael Oliveira Garcêz de Mendonça**  

**Advisor: Yaohao Peng**

**Brasília, Brazil**  
**July/2023**

## Motivation

The armed conflict between Russia and Ukraine has been one of the main events in international politics over recent months. Inducing deep impacts on the global economy, the roots of the belligerence between these two peoples trace back many centuries. Tensions hit a high point after Ukraine's political polarization culminated in the Euromaidan protests and the subsequent Crimean crisis in early 2014. This triggered a civil war in Eastern Ukraine that is still ongoing.

## Dataset

The main time series models will be implemented on the historical exchange rates between the Ukrainian hryvnia, the Belarusian ruble, the Russian ruble, the Euro, and the Dollar. Using the models described in section \ref{lineartsmodels} we will be able to untangle the dynamics of volatility flow between the countries that are involved in the conflict and how they affected "global markets". In the section of "Preliminary results" other time series techniques will be employed to describe structural changes, this section will also look into the price of commodities that are vital exports of this region, such as oil/gas, corn/wheat and potassium fertilizers. In order to describe macroeconomic trends, the inflation and interest rates will also be looked upon. 

## Methodology

This research will employ various time series analysis techniques combined with an extensive compilation of historical data that in order to retell the many phases of the Ukrainian question. It will assess how this phases scaled and led to the conflict, also some preliminary effects it had on the economies involved and in global markets. Section \ref{strucbreak} explains how structural break detection techniques will be used to split our series where relevant events influenced them, section \ref{lineartsmodels} dives into how volatility time series models are defined and how they can help retell the history of this conflict.

## Structure

The structure of the research is inspired by the structure of (\cite{dahlquist2000measuring}) and will be as follows:

1. Introduction
2. Historical background of the economy and geopolitics of Russia, Ukraine and the related regional actors
3. Description of methods and data
4. Preliminary results:
    1. In this section we will employ a vast exploratory data analysis on how the time series corroborate history;
    2. Here we will employ Structural change techniques described in section \ref{strucbreak}
5. Empirical analysis of the volatility Dynamics:
    1. In this section we will explore the volatility dynamics as described in section \ref{lineartsmodels};
    2. It is possible to repeat the implementation of GARCH-BEKK for every "section" of the data that got split in the Structural Break part. Like \cite{hung2019return} we will analyze the flow of volatility before and after certain key events. 
6. Conclusion and remarks
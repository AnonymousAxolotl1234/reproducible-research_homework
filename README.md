# Reproducible research: version control and R
ANSWERS FOR QUESTIONS ONE TO THREE:
https://github.com/AnonymousAxolotl1234/logistic_growth/blob/main/README.md


## QUESTION 4
a) Two side-by-side plots (produced from data1 and data2) are produced after execution of the code. Despite both codes using the same function and inputs, the outputs (path of 500 steps) are different. (Explained later). Time is illustrated using a gradient colour scheme, from darker blue to lighter blue, and this allows us to visualise how the random walks change over time (with earlier steps in darker blue and later steps in lighter blue). Colour is used to represent time (with more recent steps having a lighter blue colour - allowing us to determine how the path was taken over time). The graph illustrates two independent iterations of the function random_walk. Each step has a set distance (set to 0.25 units), but a random angle is created after each step (between 0 and 2pi) to generate a random path. This process is repeated for a set number of steps (set to 500). Thus, since the path relies on random number generation - each iteration of the function produces a different output, leading to the graph being different each time. This is a large issue during the process of data analysis as this function currently lacks reproducibility and therefore validity.

#### Output of random_walk function after two independent iterations
<img width="552" alt="image" src="https://github.com/user-attachments/assets/452693e2-76e9-4724-87b6-daef39dc7016">

b) Random number generation in R is based on a pseudo-random number generator (PRNG) - meaning the numbers generated are not truly random. Instead, they follow a predictable pattern determined by a seed. Using an inputted seed allows one to reproduce the same sequence of random numbers which can be useful for replicating results, allowing us to reproduce a random process.

c) To make the simulation reproducible, I incorporated the set.seed() function inside the random_walk function, and incorporated an arbitrary seed. This resulted in a reproducible simulation of Brownian motion, verified by the fact that independent iterations of the function (data1 and data2) produced identical graphs.


d) Edits I made to ensure the code is reproducible.
### Output showing commit history
<img width="1438" alt="image" src="https://github.com/user-attachments/assets/e242b217-98d8-4a21-af9b-af3553187394">


## QUESTION 5
a) Using nrow() and ncol() functions, the table has 33 rows and 13 columns:

```
virion_data <- read.csv("question-5-data/Cui_etal2014.csv")
ncol(virion_data)
nrow(virion_data)
```
<img width="157" alt="image" src="https://github.com/user-attachments/assets/1cc74b3b-f5d9-46f3-b6a3-a02d5f824b3d">




b) You can apply a log transformation so that: <br>
**$` Y = ax^B \rightarrow ln(Y) = ln(A) + Bln(X) `$** <br>
In this case: <br>
**$` ln(V) = ln(\alpha) + \beta ln(L) `$** <br>

This transforms the data so that it is suitable for a linear model which we can now apply (**$`y = mx + c`$**). 
```
#CLEANING AND TRANSFORMING DATA
virion_data$log_volume <- log(virion_data$Virion.volume..nm.nm.nm.)
virion_data$bases <- (virion_data$Genome.length..kb.)
virion_data$log_bases <- log(virion_data$bases)

#APPLYING LINEAR MODEL
model <- lm(log_volume ~ log_bases, data = virion_data)
summary(model)

```

c) The linear model shown above gives us the output for the transformed virion data - in the form of a constant and variable output.

#### Output of linear model 
<img width="391" alt="image" src="https://github.com/user-attachments/assets/69478dcd-1fbb-44fd-9c45-3e2d733a8fe5">

P-values shown above, both highly statistically significant.

As shown above **$` ln(V) = ln(\alpha) + \beta ln(L) `$** <br>

$\beta$ is equal to 1.5152
$\alpha$ is equal to **$` e^{7.07} `$** = 1181.807

<img width="1088" alt="image" src="https://github.com/user-attachments/assets/17af1e05-72f8-4a5d-8c4f-85fa96d688cf">


Therefore, the allometric exponent and scaling factor are the same as that found in the paper when rounded to three significant figures.


   
d) The code below was used to reproduce the figure:

```
ggplot(data = virion_data, aes(x=log_bases, y=log_volume)) + 
  geom_point() +
  xlab("log [Genome length (kb)]") + 
  ylab("log [Virion volume (nm3)]") +
  geom_smooth(method = 'lm') +
  theme_minimal() +
  theme(panel.border = element_rect(color = "black", fill = NA, size = 1))
```

#### Output of code shown above
  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  

e) As described above: **$` V = {\alpha} L^{\beta} `$** <br>
From work above, **$` \alpha = 1181.807, \beta = 1.5152 `$** <br>
Therefore, when L = 300: <br>
 V = (1181.807) x (300)^1.5152
   = 6700000 nm3 (3sf) 



## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \
   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \
   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\
   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \
   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 

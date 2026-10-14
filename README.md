# 20886 - Empirical Research Methods and Data Analysis

## Repository overview

This repository contains two assignments from Bocconi University's **20886 - Empirical Research Methods and Data Analysis** course (M.Sc. Economic and Social Sciences, 2025/26). The coursework covers missing-data handling, inference for group differences, cluster-randomized study design, and supervised text classification.

Each assignment has one authoritative analysis file. Assignment 1 also includes the synthetic dataset required to reproduce the Stata workflow. Course instructions, instructor notes, and other materials whose redistribution permissions have not been established are retained locally but excluded from Git.

## Assignment 1 - Stata

Assignment 1 uses a synthetic dataset of 444 fictional top-manager observations. Its variables describe ministry, demographic characteristics, education, career information, and income. Although some variable names resemble administrative data, the records are fictional and do not identify real people.

The empirical tasks are to:

1. estimate the mean and standard deviation of income after single imputation by the observed mean;
2. perform single regression imputation using demographic and education predictors;
3. compare mean income for managers below and above the 54.5-year threshold with a two-sample t-test; and
4. explain whether sampling error applies to gender under the assignment's population-data premise.

`assignment1/20_Ucropina_Giorgio.do` is the authoritative Stata script. It explores missingness, estimates several linear imputation models, imputes missing predictors by their modes in the final specification, and runs the age-group t-test. The script uses the repository-relative input path `Data_Public Managers.dta`; it contains no machine-specific path.

The embedded result note reports group means of approximately 141,515.0 and 167,374.6, a young-minus-old difference of -25,859.57, and a p-value close to zero. An independent Python reconstruction during repository preparation reproduced these figures, but the Stata script was not executed and no claim of Stata execution is made.

`assignment1/Data_Public Managers.dta` is the required synthetic input dataset. It is included to make Assignment 1 self-contained. Its inclusion is based on the confirmation that the observations are fictional; users should still follow any applicable course or dataset redistribution terms.

## Assignment 2 - Python and supervised text classification

Assignment 2 uses modified training and test subsets of a fake-news dataset. Each observation contains combined article title/text and a binary label (`0` for real and `1` for fake). The notebook:

- lowercases text, removes URLs and non-letter characters, filters English stop words, and tokenizes the remaining text;
- fits a TF-IDF vocabulary on the training set only and transforms both splits;
- trains logistic regression, an RBF support-vector classifier, and a random forest selected by three-fold grid search;
- evaluates accuracy, ROC-AUC, PR-AUC, and confusion matrices; and
- reports the random forest's 20 most important terms.

The stored outputs report a vocabulary of 12,058 terms and the following test-set results:

| Model | Accuracy | ROC-AUC | PR-AUC |
|---|---:|---:|---:|
| Logistic regression | 0.963 | 0.987 | 0.988 |
| RBF SVC | 0.967 | 0.989 | 0.989 |
| Tuned random forest | 0.960 | 0.993 | 0.994 |

The SVC has the highest recorded accuracy, while the tuned random forest has the highest recorded ROC-AUC and PR-AUC. The stored feature-importance output identifies `said`, `video`, `image`, and `featured` among the leading random-forest features.

`assignment2/code.ipynb` is the authoritative notebook. It uses repository-relative data paths, targets a generic Python 3 kernel, retains the submitted analytical cells and recorded outputs, and calls `plt.tight_layout()` correctly.

## Repository structure

```text
20886-empirical-research-methods-and-data-analysis-ps/
|-- .gitignore
|-- README.md
|-- requirements.txt
|-- assignment1/
|   |-- 20_Ucropina_Giorgio.do
|   `-- Data_Public Managers.dta
`-- assignment2/
    `-- code.ipynb
```

- `.gitignore` excludes machine state and specific local-only course materials; it does not blanket-ignore Stata, PDF, notebook, or dataset formats.
- `requirements.txt` lists the Python and Jupyter packages used by Assignment 2.
- `assignment1/20_Ucropina_Giorgio.do` is the single authoritative Stata analysis.
- `assignment1/Data_Public Managers.dta` is the included synthetic Assignment 1 input.
- `assignment2/code.ipynb` is the single authoritative Python analysis.

## Reproducibility

### Assignment 1

Assignment 1 requires a licensed Stata installation. The dataset is already included. In Stata, set the working directory to `assignment1/` and run:

```stata
do "20_Ucropina_Giorgio.do"
```

For example, from the repository root in Stata:

```stata
cd "assignment1"
do "20_Ucropina_Giorgio.do"
```

The script loads `Data_Public Managers.dta` through a relative path, displays results in Stata, and does not overwrite the source dataset. Stata was unavailable during repository preparation, so the code was inspected rather than executed. Its input schema, missingness logic, regression specifications, and documented t-test figures were cross-checked independently with Python.

### Assignment 2

Use Python 3.11 or newer. From the repository root, install the dependencies:

```bash
python -m pip install -r requirements.txt
```

Obtain the modified course datasets through an authorized source and place them at:

```text
assignment2/data/fake_news_train.csv
assignment2/data/fake_news_test.csv
```

Then start Jupyter from the repository root:

```bash
jupyter notebook assignment2/code.ipynb
```

The expected columns are `title_text` and `fake_news`; the recorded split sizes are 2,000 training rows and 300 test rows. The notebook format and Python syntax were validated, and its imports were verified with Python 3.13.5. End-to-end re-execution was not possible because the two Assignment 2 CSV inputs are not included or available at their former local paths. The recorded notebook outputs are preserved as evidence of the submitted run.

## Publication and provenance notes

- The included Assignment 1 dataset is synthetic and contains fictional observations rather than real personal data.
- Course instructions, instructor solution notes, and private study notes remain excluded pending confirmation of redistribution permission.
- The Assignment 2 input CSV files are not present and remain excluded unless their redistribution terms permit publication.
- No credentials, API keys, or authentication tokens were found.
- The locally preserved submitted versions are not tracked; the repository exposes one portable, authoritative code file per assignment.

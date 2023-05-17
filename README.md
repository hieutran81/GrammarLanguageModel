# How well do language model understand grammar
This repository contains the code and resources related to the paper "How well do language models understand long distance dependencies" by Kuan-Jung Huang, Mari Kugemoto, Hieu Tran, and Josh Viktorov.

## T5 model
This guide provides a step-by-step process of how to use the given code to fine-tune a T5 model for Natural Language Processing (NLP) tasks. The primary use case here is for masked word prediction and computing perplexity of a corpus.

### Prerequisites
Before you start, you'll need:

* Google Colab or a local Python environment set up with the required libraries.
* Access to Google Drive with the necessary data files, please upload them to Google Drive if want to run the project with Google Colab. After that, you can mount your Google drive to Colab using:
```
from google.colab import drive, files
drive.mount('/content/drive')
```

### Data synthesis
We modified Warstadt (2020)'s codes to create these codes and generate our sentences for the fine-tuning. These codes use the util functions from Warstadt (2020). 
To run these codes, download Warstadt's codes from here (https://github.com/alexwarstadt/data_generation) and put these codes under data_generation-master/generation_project/examples.

### Running

#### T5 model
The T5.ipynb file contains codes for fine-tuning T5 model, computing the surprisal, perplexity and evaluating the results is contained in the T5.ipynb file. You can execute this notebook on Google Colab or on a local Jupyter notebook server.




# How well do language model understand grammar
This repository contains the code and resources related to the paper "How well do language models understand long distance dependencies" by Kuan-Jung Huang, Mari Kugemoto, Hieu Tran, and Josh Viktorov.

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

#### T5.ipynb
The T5.ipynb file contains codes for fine-tuning T5 model, computing the surprisal, perplexity and evaluating the results is contained in the T5.ipynb file. You can execute this notebook on Google Colab or on a local Jupyter notebook server.

#### Perplexity.ipynb

This file was used for computing the perplexity of a dataset using multiple different models. To run it just fill in the root_dir and file_path variables with the path to the dataset, and the model_paths variable with all the models you would like to test. The code will then output the original dataset along with perplexities from each model in results_df.

#### Gpt.ipynb

This file was used for computing the surprisal of a dataset using a model. The expected format of the dataset is 2 columns: Prefix and Continuation. The continuation is one word which the surprisal will be computed for based on the prefix. To use your own model replace this line model = GPT2LMHeadModel.from_pretrained('gpt2') with your own. The output is the original dataset with an additional column for surprisal.

#### Gpt-finetuning.ipynb

This file was used for fine tuning gpt-2. It takes in a custom dataset to fine tune with. To use your own replace the root_dir and file_name variables with the path to the dataset. There are also several hyperparameters that can be changed: num_epochs, train_size, the optimizer, and the learning rate. The last cell saves the model locally, change the file path to the desired location. 




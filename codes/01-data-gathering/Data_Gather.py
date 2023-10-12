import os
from kaggle.api.kaggle_api_extended import KaggleApi

os.environ["KAGGLE_USERNAME"] = "qbs980818"
os.environ["KAGGLE_KEY"] = "c62c53db47003d38266d7bc3fd62af89"


# Initialize and authenticate the Kaggle API client
api = KaggleApi()
api.authenticate()

api.dataset_download_files(dataset_name, path='/Users/qbs/', unzip=True)


dataset_name = "mexwell/steamgames"
api.dataset_download_files(dataset_name, path='.', unzip=True)
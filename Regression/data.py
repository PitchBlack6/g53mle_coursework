import numpy as np
import tensorflow as tf
import math
import logging
from sklearn.preprocessing import MinMaxScaler
logging.basicConfig(level=logging.DEBUG)
import matplotlib.pyplot as plt
from pandas import DataFrame
import pandas as pd
from sklearn.model_selection import KFold

def normalize_coordinate(coordinate):
    #oordinate = np.reshape(coordinate, (-1, 1))
    scalar = MinMaxScaler(feature_range=(0, 1))
    scalar = scalar.fit(coordinate)
    normalized = scalar.transform(coordinate)
    #normalized = np.reshape(normalized, -1)
    return normalized

def obtain_data():
    # Data preprocessing
    x = pd.read_csv("predx_for_regression.csv", header=0)
    x_array = np.asarray(x, dtype = "float")
    x_arrayt=x_array
    y = pd.read_csv("predy_for_regression.csv", header=0)
    y_array = np.asarray(y, dtype = "float")
    y_arrayt=y_array
    whole_data=np.concatenate((x_arrayt, y_arrayt),axis=1)
    print("whole data: ", whole_data)
    angle = pd.read_csv("angle.csv", header=0)
    angle_array = np.asarray(angle, dtype = "float")
    #angle_arrayt=angle_array.transpose()
    label=angle_array#+1e-50-1e-50
    #temp=np.array([angle_array[:,0]])
    #features = (whole_data - 200) / 2000  # 367616, 98
    features = normalize_coordinate(whole_data)
    #labels = temp.transpose()  # 367616, 1
    return features, label


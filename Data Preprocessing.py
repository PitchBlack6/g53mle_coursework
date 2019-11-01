import h5py
import numpy as np
import os
import csv
from sklearn.utils import shuffle
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
import tensorflow as tf
features_directory = "2DFeatures"
labels_directory = "Labels/OCC"


def normalize_coordinate(coordinate):
    coordinate = np.reshape(coordinate, (-1, 1))
    scalar = MinMaxScaler(feature_range=(0, 1))
    scalar = scalar.fit(coordinate)
    normalized = scalar.transform(coordinate)
    normalized = np.reshape(normalized, -1)
    return normalized


def normalize_coordinates(coordinates):
    x_coordinates = []
    y_coordinates = []
    for coordinate in coordinates:
        x_coordinates.append(coordinate[0])
        y_coordinates.append(coordinate[1])
    x_coordinates = normalize_coordinate(x_coordinates)
    y_coordinates = normalize_coordinate(y_coordinates)
    normalized_coordinates = []
    for i in range(0, len(x_coordinates)):
        normalized_coordinates.append([x_coordinates[i], y_coordinates[i]])
    return normalized_coordinates


def feature_and_label_from_file(file_name):
    labels_file_name = os.path.join(labels_directory, file_name.replace(".mat", ".csv"))
    feature_file_name = os.path.join(features_directory, file_name)

    fh = h5py.File(feature_file_name, 'r')  # Initializing h5py file handler
    lms_obj = fh.get('fit/pred')  # Extracting the list of landmarks array objects from pred field
    feature_list = []
    label_list = []
    with open(labels_file_name, newline='') as csv_file:
        reader = csv.reader(csv_file)
        first = True
        for row in reader:
            if first:
                first = False
                continue
            if len(fh[lms_obj[int(row[0])][0]][()].transpose()) == 49:
                label_list.append(list(map(int, row[1:6])))
                normalized_coordinates = normalize_coordinates(fh[lms_obj[int(row[0])][0]][()].transpose())
                normalized_coordinates = np.reshape(normalized_coordinates, -1)
                feature_list.append(normalized_coordinates)

    return feature_list, label_list


def feature_and_label_from_directory(directory=features_directory):
    label_list = []
    feature_list = []
    for fileName in os.listdir(directory):
        if fileName.find('.mat') != -1:
            print(fileName)
            temp_feature, temp_label = feature_and_label_from_file(fileName)
            label_list.extend(temp_label)
            feature_list.extend(temp_feature)
    return feature_list, label_list


def generate_data():
    feature_list, label_list = feature_and_label_from_directory()
    feature_array = np.asarray(feature_list)
    label_array = np.asarray(label_list)
    feature_array, label_array = shuffle(feature_array, label_array)
    X_train, X_test, y_train, y_test = train_test_split(feature_array, label_array, test_size=0.20, random_state=42)
    print("Feature train shape: " + str(X_train.shape))
    print("Label train shape: " + str(y_train.shape))
    print("Feature test shape: " + str(X_test.shape))
    print("Label test shape: " + str(y_test.shape))
    np.savetxt('X_train.txt', X_train, fmt='%s')
    np.savetxt('X_test.txt', X_test, fmt='%s')
    np.savetxt('y_train.txt', y_train, fmt='%d')
    np.savetxt('y_test.txt', y_test, fmt='%d')


generate_data()

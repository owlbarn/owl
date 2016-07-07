clear; close all; clc;

load 'test_svm.data.tmp';
load 'test_svm.model.tmp';

scatter(test_svm_data(:,1),test_svm_data(:,2));
hold;
scatter(test_svm_model(:,1),test_svm_model(:,2));
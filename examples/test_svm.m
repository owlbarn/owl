clear; close all; clc;

load 'test_svm.data1.tmp';
load 'test_svm.data2.tmp';
load 'test_svm.model.tmp';

scatter(test_svm_model(:,1),test_svm_model(:,2));
hold;
scatter(test_svm_data1(:,1),test_svm_data1(:,2));
scatter(test_svm_data2(:,1),test_svm_data2(:,2));

clear; close all; clc;

load 'test_log.data1.tmp';
load 'test_log.data2.tmp';

scatter(test_log_data1(:,1),test_log_data1(:,2));
hold;
scatter(test_log_data2(:,1),test_log_data2(:,2));

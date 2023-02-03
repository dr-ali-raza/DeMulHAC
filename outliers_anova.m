m = mean(data);
out = isoutlier(data);
for j = 1:368
for i = 1:22411
if out(i)==1
data(i,j) = m(j);
end
end
end
features = data(:,1:368);
activity = data(:,369);
for k = 1:368
[p(k)] = anovan(features(:,k),{activity});
end
for l = 1:368
if p(l)<=0.05
x(l)=p(l);
end
end
num_pval = nnz(p)
rel_feature = nnz(x)

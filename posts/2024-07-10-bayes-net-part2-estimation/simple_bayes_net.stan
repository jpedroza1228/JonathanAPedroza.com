data {
  int<lower=1> J; // number of examinees
  int<lower=1> I; // number of items
  int<lower=1> K; // number of latent variables
  int<lower=1> C; // number of classes
  matrix[J, I] X; // response matrix
  matrix[I, K] Q; // Q matrix
  matrix[C, K] alpha; // attribute profile matrix
}
parameters {
  simplex[C] nu; // class probabilities
  vector<lower=0, upper=1>[I] false_pos;
  vector<lower=0, upper=1>[I] true_pos;
  real<lower=0, upper=1> lambda1;
  real<lower=0, upper=1> lambda20;
  real<lower=0, upper=1> lambda21;
  real<lower=0, upper=1> lambda30;
  real<lower=0, upper=1> lambda31;
}
transformed parameters{
  vector[C] log_nu;
  vector[2] theta_log1;
  vector[2] theta_log2;
  vector[2] theta_log3;
  vector[C] theta1;
  vector[C] theta2;
  vector[C] theta3;
  matrix[I, C] delta;

  log_nu = log(nu);

  theta_log1[1] = bernoulli_lpmf(1 | 1 - lambda1);
  theta_log1[2] = bernoulli_lpmf(1 | lambda1);
  
  theta_log2[1] = bernoulli_lpmf(1 | lambda20);
  theta_log2[2] = bernoulli_lpmf(1 | lambda21);
  
  theta_log3[1] = bernoulli_lpmf(1 | lambda30);
  theta_log3[2] = bernoulli_lpmf(1 | lambda31);
  
  for (c in 1 : C) {
    if (alpha[c, 1] > 0) {
      theta1[c] = theta_log1[2];
    } else {
      theta1[c] = theta_log1[1];
    }
    if (alpha[c, 2] > 0) {
      theta2[c] = theta_log2[2];
    } else {
      theta2[c] = theta_log2[1];
    }
    if (alpha[c, 3] > 0) {
      theta3[c] = theta_log3[2];
    } else {
      theta3[c] = theta_log3[1];
    }
  }

  for(c in 1:C){
    for(i in 1:I){
      delta[i, c] = pow(exp(theta1[c]), Q[i, 1]) * pow(exp(theta2[c]), Q[i, 2])
                      * pow(exp(theta3[c]), Q[i, 3]);
    }
  }
}
model {
  real pie;
  vector[I] log_item;
  vector[C] log_lik;
  
  // Priors
  lambda1 ~ beta(25, 5);
  lambda20 ~ beta(10, 20);
  lambda21 ~ beta(20, 10);
  lambda30 ~ beta(5, 25);
  lambda31 ~ beta(25, 5);
  
  for (i in 1 : I) {
    false_pos[i] ~ beta(4, 26);
    true_pos[i] ~ beta(26, 4);
  }
  
  //Likelihood
  for (j in 1 : J) {
    for (c in 1 : C) {
      for (i in 1 : I) {
        pie = pow(true_pos[i], delta[i, c]) * pow(false_pos[i], (1 - delta[i, c]));
        log_item[i] = X[j, i] * log(pie) + (1 - X[j, i]) * log(1 - pie);
      }
      log_lik[c] = log_nu[c] + sum(log_item);
    }
    target += log_sum_exp(log_lik);
  }
}
generated quantities {
  real pie;
  vector[I] log_item;
  matrix[J, C] prob_resp_class; // posterior probabilities of respondent j being in latent class c 
  matrix[J, K] prob_resp_attr; // posterior probabilities of respondent j being a master of attribute k 
  row_vector[C] prob_joint;
  vector[C] prob_attr_class;
  
  matrix[J, I] x_rep;
  
  for (j in 1 : J) {
    for (c in 1 : C) {
      for (i in 1 : I) {        
        pie = pow(true_pos[i], delta[i, c]) * pow(false_pos[i], (1 - delta[i, c]));
        log_item[i] = X[j, i] * log(pie) + (1 - X[j, i]) * log(1 - pie);
        }
      prob_joint[c] = nu[c] * exp(sum(log_item)); //here is where the problem starts with trying to correctly classify students with proficiency mastery
    }
    prob_resp_class[j] = prob_joint / sum(prob_joint);
  }
  
  for (j in 1 : J) {
    for (k in 1 : K) {
      for (c in 1 : C) {
        // Calculate the probability of mastering attribute k given class c
        prob_attr_class[c] = prob_resp_class[j, c] * alpha[c, k];
      }
      // Sum the probabilities to get the posterior probability of mastering attribute k
      prob_resp_attr[j, k] = sum(prob_attr_class);
    }
  }
  
  for (j in 1 : J) {
    for (c in 1 : C) {
      for (i in 1 : I) {
        x_rep[j, i] = X[j, i] * log(pie) + (1 - X[j, i]) * log(1 - pie);
      }
    }
  }
}
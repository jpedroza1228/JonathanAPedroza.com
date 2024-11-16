data {
  int<lower=0> J; // Number of observations/participants
  int y_cat; // Number of categories in outcome
  int expert_cat;
  int gender_cat;
  int age_cat;
  int cup_per_day_cat;
  int favorite_coffee_drink_cat;
  int roast_preference_cat;
  vector<lower=1, upper=y_cat>[J] Y; // Outcome variable
  vector<lower=1, upper=expert_cat>[J] expert;
  vector<lower=1, upper=gender_cat>[J] gender;
  vector<lower=1, upper=age_cat>[J] age;
  vector<lower=1, upper=cup_per_day_cat>[J] cup_per_day;
  vector<lower=1, upper=favorite_coffee_drink_cat>[J] favorite_coffee_drink;
  vector<lower=1, upper=roast_preference_cat>[J] roast_preference;
  vector<lower=0, upper=1>[J] home_brew_pourover;
  vector<lower=0, upper=1>[J] home_brew_french_press;
  vector<lower=0, upper=1>[J] home_brew_espresso;
  vector<lower=0, upper=1>[J] home_brew_mr_coffee;
  vector<lower=0, upper=1>[J] home_brew_pods;
  vector<lower=0, upper=1>[J] home_brew_instant;
  vector<lower=0, upper=1>[J] home_brew_bean2cup;
  vector<lower=0, upper=1>[J] home_brew_cold_brew;
  vector<lower=0, upper=1>[J] home_brew_cometeer;
  vector<lower=0, upper=1>[J] home_brew_other;
}
parameters{
  real a_home_pourover; //intercept for edge from age groups and gender groups to pourover home brewer
  //beta coefficients are written as the "from" node to the "to" node in an edge/relationship
  vector[gender_cat] b_gender_pourover;
  vector[age_cat] b_age_pourover;
//
  real a_home_frenchpress; //intercept for edge from age groups and gender groups to french press home brewer
  vector[gender_cat] b_gender_frenchpress;
  vector[age_cat] b_age_frenchpress;
//
  real a_home_espresso; //intercept for edge from age groups and gender groups to espresso home brewer
  vector[gender_cat] b_gender_espresso;
  vector[age_cat] b_age_espresso;
//
  real a_home_mrcoffee; //intercept for edge from age groups and gender groups to mrcoffee home brewer
  vector[gender_cat] b_gender_mrcoffee;
  vector[age_cat] b_age_mrcoffee;
//
  real a_home_pods; //intercept for edge from age groups and gender groups to pods home brewer
  vector[gender_cat] b_gender_pods;
  vector[age_cat] b_age_pods;
//
  real a_home_instant; //intercept for edge from age groups and gender groups to instan home brewer
  vector[gender_cat] b_gender_instant;
  vector[age_cat] b_age_instant;
//
  real a_home_bean2cup; //intercept for edge from age groups and gender groups to bean2cup home brewer
  vector[gender_cat] b_gender_bean2cup;
  vector[age_cat] b_age_bean2cup;
//
  real a_home_coldbrew; //intercept for edge from age groups and gender groups to coldbrew home brewer
  vector[gender_cat] b_gender_coldbrew;
  vector[age_cat] b_age_coldbrew;
//
  real a_home_cometeer; //intercept for edge from age groups and gender groups to cometeer home brewer
  vector[gender_cat] b_gender_cometeer;
  vector[age_cat] b_age_cometeer;
//
  real a_home_other; //intercept for edge from age groups and gender groups to other home brewer
  vector[gender_cat] b_gender_other;
  vector[age_cat] b_age_other;
//
  //vector[y_cat] a_y;
  //vector[expert_cat] a_expert;
  //vector[cup_per_day_cat] a_cup_per_day;
  //vector[favorite_coffee_drink_cat] a_favorite_coffee_drink;
  //vector[roast_preference_cat] a_roast_preference;
}
transformed parameters{
  vector[J] theta_home_pourover;
  vector[J] theta_home_frenchpress;
  vector[J] theta_home_espresso;
  vector[J] theta_home_mrcoffee;
  vector[J] theta_home_pods;
  vector[J] theta_home_instant;
  vector[J] theta_home_bean2cup;
  vector[J] theta_home_coldbrew;
  vector[J] theta_home_cometeer;
  vector[J] theta_home_other;

  matrix[J, 10] log_lik_matrix;

  for(j in 1:J){
    for(ac in 1:age_cat){
      for(gc in 1:gender_cat){
        theta_home_pourover[j] = inv_logit(
        a_home_pourover +
        b_gender_pourover[gc] * gender[j] +
        b_age_pourover[ac] * age[j]
      );

      theta_home_frenchpress[j] = inv_logit(
        a_home_frenchpress +
        b_gender_frenchpress[gc] * gender[j] +
        b_age_frenchpress[ac] * age[j]
      );
//
      theta_home_espresso[j] = inv_logit(
        a_home_espresso +
        b_gender_espresso[gc] * gender[j] +
        b_age_espresso[ac] * age[j]
      );
//
      theta_home_mrcoffee[j] = inv_logit(
        a_home_mrcoffee +
        b_gender_mrcoffee[gc] * gender[j] +
        b_age_mrcoffee[ac] * age[j]
      );
//
      theta_home_pods[j] = inv_logit(
        a_home_pods +
        b_gender_pods[gc] * gender[j] +
        b_age_pods[ac] * age[j]
      );
//
      theta_home_instant[j] = inv_logit(
        a_home_instant +
        b_gender_instant[gc] * gender[j] +
        b_age_instant[ac] * age[j]
      );
//
      theta_home_bean2cup[j] = inv_logit(
        a_home_bean2cup +
        b_gender_bean2cup[gc] * gender[j] +
        b_age_bean2cup[ac] * age[j]
      );
//
      theta_home_coldbrew[j] = inv_logit(
        a_home_coldbrew +
        b_gender_coldbrew[gc] * gender[j] +
        b_age_coldbrew[ac] * age[j]
      );
//
      theta_home_cometeer[j] = inv_logit(
        a_home_cometeer +
        b_gender_cometeer[gc] * gender[j] +
        b_age_cometeer[ac] * age[j]
      );
//
      theta_home_other[j] = inv_logit(
        a_home_other +
        b_gender_other[gc] * gender[j] +
        b_age_other[ac] * age[j]
      );
      }
    }
    log_lik_matrix[j, 1] = home_brew_pourover[j] * log(theta_home_pourover[j]) + (1 - home_brew_pourover[j]) * log(1 - theta_home_pourover[j]);
    log_lik_matrix[j, 2] = home_brew_french_press[j] * log(theta_home_frenchpress[j]) + (1 - home_brew_french_press[j]) * log(1 - theta_home_frenchpress[j]);
    log_lik_matrix[j, 3] = home_brew_espresso[j] * log(theta_home_espresso[j]) + (1 - home_brew_espresso[j]) * log(1 - theta_home_espresso[j]);
    log_lik_matrix[j, 4] = home_brew_mr_coffee[j] * log(theta_home_mrcoffee[j]) + (1 - home_brew_mr_coffee[j]) * log(1 - theta_home_mrcoffee[j]);
    log_lik_matrix[j, 5] = home_brew_pods[j] * log(theta_home_pods[j]) + (1 - home_brew_pods[j]) * log(1 - theta_home_pods[j]);
    log_lik_matrix[j, 6] = home_brew_instant[j] * log(theta_home_instant[j]) + (1 - home_brew_instant[j]) * log(1 - theta_home_instant[j]);
    log_lik_matrix[j, 7] = home_brew_bean2cup[j] * log(theta_home_bean2cup[j]) + (1 - home_brew_bean2cup[j]) * log(1 - theta_home_bean2cup[j]);
    log_lik_matrix[j, 8] = home_brew_cold_brew[j] * log(theta_home_coldbrew[j]) + (1 - home_brew_cold_brew[j]) * log(1 - theta_home_coldbrew[j]);
    log_lik_matrix[j, 9] = home_brew_cometeer[j] * log(theta_home_cometeer[j]) + (1 - home_brew_cometeer[j]) * log(1 - theta_home_cometeer[j]);
    log_lik_matrix[j, 10] = home_brew_other[j] * log(theta_home_other[j]) + (1 - home_brew_other[j]) * log(1 - theta_home_other[j]);
  }
}
model{
  a_home_pourover ~ normal(0, 1);
  a_home_frenchpress ~ normal(0, 1);
  a_home_espresso ~ normal(0, 1);
  a_home_mrcoffee ~ normal(0, 1);
  a_home_pods ~ normal(0, 1);
  a_home_instant ~ normal(0, 1);
  a_home_bean2cup ~ normal(0, 1);
  a_home_coldbrew ~ normal(0, 1);
  a_home_cometeer ~ normal(0, 1);
  a_home_other ~ normal(0, 1);

  for(gc in 1:gender_cat){
    b_gender_pourover[gc] ~ normal(0, 1);
    b_gender_frenchpress[gc] ~ normal(0, 1);
    b_gender_espresso[gc] ~ normal(0, 1);
    b_gender_mrcoffee[gc] ~ normal(0, 1);
    b_gender_pods[gc] ~ normal(0, 1);
    b_gender_instant[gc] ~ normal(0, 1);
    b_gender_bean2cup[gc] ~ normal(0, 1);
    b_gender_coldbrew[gc] ~ normal(0, 1);
    b_gender_cometeer[gc] ~ normal(0, 1);
    b_gender_other[gc] ~ normal(0, 1);
  }

  for(ac in 1:age_cat){
    b_age_pourover[ac] ~ normal(0, 1);
    b_age_frenchpress[ac] ~ normal(0, 1);
    b_age_espresso[ac] ~ normal(0, 1);
    b_age_mrcoffee[ac] ~ normal(0, 1);
    b_age_pods[ac] ~ normal(0, 1);
    b_age_instant[ac] ~ normal(0, 1);
    b_age_bean2cup[ac] ~ normal(0, 1);
    b_age_coldbrew[ac] ~ normal(0, 1);
    b_age_cometeer[ac] ~ normal(0, 1);
    b_age_other[ac] ~ normal(0, 1);
  }
  
  // Add the log likelihood contributions to the target
  for (i in 1:10) {
    target += sum(log_lik_matrix[, i]);
  }
}
generated quantities {

}
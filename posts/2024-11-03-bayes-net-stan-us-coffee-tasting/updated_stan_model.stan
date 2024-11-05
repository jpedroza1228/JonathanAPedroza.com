data {
  int<lower=0> J; // Number of observations/participants
  int I; // Number of Items/Columns (Dependent on Model)
  int K; // Number of categories in outcome
  vector[J] Y; // Outcome variable

  vector<lower=-1, upper=1>[J] expert7;
  vector<lower=-1, upper=1>[J] expert6;
  vector<lower=-1, upper=1>[J] expert8;
  vector<lower=-1, upper=1>[J] expert4;
  vector<lower=-1, upper=1>[J] expert3;
  vector<lower=-1, upper=1>[J] expert2;
  vector<lower=-1, upper=1>[J] expert1;
  vector<lower=-1, upper=1>[J] expert9;
  vector<lower=-1, upper=1>[J] expert10;

  vector<lower=-1, upper=1>[J] roast_light;
  vector<lower=-1, upper=1>[J] roast_dark;

  vector<lower=-1, upper=1>[J] cup_1orless;
  vector<lower=-1, upper=1>[J] cup_3ormore;

  vector<lower=-1, upper=1>[J] latte;
  vector<lower=-1, upper=1>[J] otherdrink;
  vector<lower=-1, upper=1>[J] drip;
  vector<lower=-1, upper=1>[J] cappuccino;
  vector<lower=-1, upper=1>[J] espresso;
  vector<lower=-1, upper=1>[J] cortado;
  vector<lower=-1, upper=1>[J] americano;

  vector<lower=-1, upper=1>[J] home_brew_french_press;
  vector<lower=-1, upper=1>[J] home_brew_espresso;
  vector<lower=-1, upper=1>[J] home_brew_mr_coffee;
  vector<lower=-1, upper=1>[J] home_brew_pods;
  vector<lower=-1, upper=1>[J] home_brew_instant;
  vector<lower=-1, upper=1>[J] home_brew_bean2cup;
  vector<lower=-1, upper=1>[J] home_brew_cold_brew;
  vector<lower=-1, upper=1>[J] home_brew_cometeer;
  vector<lower=-1, upper=1>[J] home_brew_other;

  vector<lower=-1, upper=1>[J] female;
  vector<lower=-1, upper=1>[J] gen_other;

  vector<lower=-1, upper=1>[J] thirty544;
  vector<lower=-1, upper=1>[J] over44;
  vector<lower=-1, upper=1>[J] under24;
}
parameters {
  // all explanations are in comparison to respective node reference groups

  real a_latte; //intercept for edge from age groups and gender groups to latte 
  real a_otherdrink; //intercept for edge from age groups and gender groups to drip coffee
  real a_drip; //intercept for edge from age groups and gender groups to drip
  real a_cappuccino; //intercept for edge from age groups and gender groups to cappuccino
  real a_espresso; //intercept for edge from age groups and gender groups to espresso
  real a_cortado; //intercept for edge from age groups and gender groups to cortado
  real a_americano; //intercept for edge from age groups and gender groups to americano
  
  real a_home_frenchpress; //intercept for edge from age groups and gender groups to french press home brewer
  real a_home_espresso; //intercept for edge from age groups and gender groups to espresso home brewer
  real a_home_mrcoffee; //intercept for edge from age groups and gender groups to mrcoffee home brewer
  real a_home_pods; //intercept for edge from age groups and gender groups to pods home brewer
  real a_home_instant; //intercept for edge from age groups and gender groups to instan home brewer
  real a_home_bean2cup; //intercept for edge from age groups and gender groups to bean2cup home brewer
  real a_home_coldbrew; //intercept for edge from age groups and gender groups to coldbrew home brewer
  real a_home_cometeer; //intercept for edge from age groups and gender groups to cometeer home brewer
  real a_home_other; //intercept for edge from age groups and gender groups to other home brewer

  real a_cup_1orless; //intercept for edge from age groups, gender, and favorite coffee drink to having 1 or less coffees
  real a_cup_3ormore; //intercept for edge from age groups, gender, and favorite coffee drink to having 3 or more coffees

  real a_roast_light; //intercept for edge from home brewers, favorite coffee drink, and cups of coffee per day to light roast
  real a_roast_dark; //intercept for edge from home brewers, favorite coffee drink, and cups of coffee per day to dark roast

  real a_expert1; //intercept for edge from roast preference to expert1
  real a_expert2; //intercept for edge from roast preference to expert2
  real a_expert3; //intercept for edge from roast preference to expert3
  real a_expert4; //intercept for edge from roast preference to expert4
  real a_expert6; //intercept for edge from roast preference to expert6
  real a_expert7; //intercept for edge from roast preference to expert7
  real a_expert8; //intercept for edge from roast preference to expert8
  real a_expert9; //intercept for edge from roast preference to expert9
  real a_expert10; //intercept for edge from roast preference to expert10

  vector[K] a_y; //intercept for edge from expertise level and roast preference to favorite coffee

  //beta coefficients are written as the "from" node to the "to" node in an edge/relationship
  real b_female_home_frenchpress;
  real b_gen_other_home_frenchpress;
  real b_thirty544_home_frenchpress;
  real b_over44_home_frenchpress;
  real b_under24_home_frenchpress;

  real b_female_home_espresso;
  real b_gen_other_home_espresso;
  real b_thirty544_home_espresso;
  real b_over44_home_espresso;
  real b_under24_home_espresso;

  real b_female_home_mrcoffee;
  real b_gen_other_home_mrcoffee;
  real b_thirty544_home_mrcoffee;
  real b_over44_home_mrcoffee;
  real b_under24_home_mrcoffee;

  real b_female_home_pods;
  real b_gen_other_home_pods;
  real b_thirty544_home_pods;
  real b_over44_home_pods;
  real b_under24_home_pods;

  real b_female_home_instant;
  real b_gen_other_home_instant;
  real b_thirty544_home_instant;
  real b_over44_home_instant;
  real b_under24_home_instant;

  real b_female_home_bean2cup;
  real b_gen_other_home_bean2cup;
  real b_thirty544_home_bean2cup;
  real b_over44_home_bean2cup;
  real b_under24_home_bean2cup;

  real b_female_home_coldbrew;
  real b_gen_other_home_coldbrew;
  real b_thirty544_home_coldbrew;
  real b_over44_home_coldbrew;
  real b_under24_home_coldbrew;

  real b_female_home_cometeer;
  real b_gen_other_home_cometeer;
  real b_thirty544_home_cometeer;
  real b_over44_home_cometeer;
  real b_under24_home_cometeer;

  real b_female_home_other;
  real b_gen_other_home_other;
  real b_thirty544_home_other;
  real b_over44_home_other;
  real b_under24_home_other;


  real b_female_latte;
  real b_gen_other_latte;
  real b_thirty544_latte;
  real b_over44_latte;
  real b_under24_latte;
  real b_home_frenchpress_latte;
  real b_home_espresso_latte;
  real b_home_mrcoffee_latte;
  real b_home_pods_latte;
  real b_home_instant_latte;
  real b_home_bean2cup_latte;
  real b_home_coldbrew_latte;
  real b_home_cometeer_latte;
  real b_home_other_latte;

  real b_female_otherdrink;
  real b_gen_other_otherdrink;
  real b_thirty544_otherdrink;
  real b_over44_otherdrink;
  real b_under24_otherdrink;
  real b_home_frenchpress_otherdrink;
  real b_home_espresso_otherdrink;
  real b_home_mrcoffee_otherdrink;
  real b_home_pods_otherdrink;
  real b_home_instant_otherdrink;
  real b_home_bean2cup_otherdrink;
  real b_home_coldbrew_otherdrink;
  real b_home_cometeer_otherdrink;
  real b_home_other_otherdrink;

  real b_female_drip;
  real b_gen_other_drip;
  real b_thirty544_drip;
  real b_over44_drip;
  real b_under24_drip;
  real b_home_frenchpress_drip;
  real b_home_espresso_drip;
  real b_home_mrcoffee_drip;
  real b_home_pods_drip;
  real b_home_instant_drip;
  real b_home_bean2cup_drip;
  real b_home_coldbrew_drip;
  real b_home_cometeer_drip;
  real b_home_other_drip;

  real b_female_cappuccino;
  real b_gen_other_cappuccino;
  real b_thirty544_cappuccino;
  real b_over44_cappuccino;
  real b_under24_cappuccino;
  real b_home_frenchpress_cappuccino;
  real b_home_espresso_cappuccino;
  real b_home_mrcoffee_cappuccino;
  real b_home_pods_cappuccino;
  real b_home_instant_cappuccino;
  real b_home_bean2cup_cappuccino;
  real b_home_coldbrew_cappuccino;
  real b_home_cometeer_cappuccino;
  real b_home_other_cappuccino;

  real b_female_espresso;
  real b_gen_other_espresso;
  real b_thirty544_espresso;
  real b_over44_espresso;
  real b_under24_espresso;
  real b_home_frenchpress_espresso;
  real b_home_espresso_espresso;
  real b_home_mrcoffee_espresso;
  real b_home_pods_espresso;
  real b_home_instant_espresso;
  real b_home_bean2cup_espresso;
  real b_home_coldbrew_espresso;
  real b_home_cometeer_espresso;
  real b_home_other_espresso;

  real b_female_cortado;
  real b_gen_other_cortado;
  real b_thirty544_cortado;
  real b_over44_cortado;
  real b_under24_cortado;
  real b_home_frenchpress_cortado;
  real b_home_espresso_cortado;
  real b_home_mrcoffee_cortado;
  real b_home_pods_cortado;
  real b_home_instant_cortado;
  real b_home_bean2cup_cortado;
  real b_home_coldbrew_cortado;
  real b_home_cometeer_cortado;
  real b_home_other_cortado;

  real b_female_americano;
  real b_gen_other_americano;
  real b_thirty544_americano;
  real b_over44_americano;
  real b_under24_americano;
  real b_home_frenchpress_americano;
  real b_home_espresso_americano;
  real b_home_mrcoffee_americano;
  real b_home_pods_americano;
  real b_home_instant_americano;
  real b_home_bean2cup_americano;
  real b_home_coldbrew_americano;
  real b_home_cometeer_americano;
  real b_home_other_americano;


  real b_latte_cup_1orless;
  real b_otherdrink_cup_1orless;
  real b_drip_cup_1orless;
  real b_cappuccino_cup_1orless;
  real b_espresso_cup_1orless;
  real b_cortado_cup_1orless;
  real b_americano_cup_1orless;
  real b_thirty544_cup_1orless;
  real b_over44_cup_1orless;
  real b_under24_cup_1orless;

  real b_latte_cup_3ormore;
  real b_otherdrink_cup_3ormore;
  real b_drip_cup_3ormore;
  real b_cappuccino_cup_3ormore;
  real b_espresso_cup_3ormore;
  real b_cortado_cup_3ormore;
  real b_americano_cup_3ormore;
  real b_thirty544_cup_3ormore;
  real b_over44_cup_3ormore;
  real b_under24_cup_3ormore;


  real b_home_frenchpress_roast_light;
  real b_home_espresso_roast_light;
  real b_home_mrcoffee_roast_light;
  real b_home_pods_roast_light;
  real b_home_instant_roast_light;
  real b_home_bean2cup_roast_light;
  real b_home_coldbrew_roast_light;
  real b_home_cometeer_roast_light;
  real b_home_other_roast_light;
  real b_latte_roast_light;
  real b_otherdrink_roast_light;
  real b_drip_roast_light;
  real b_cappuccino_roast_light;
  real b_espresso_roast_light;
  real b_cortado_roast_light;
  real b_americano_roast_light;
  real b_cup_1orless_roast_light;
  real b_cup_3ormore_roast_light;

  real b_home_frenchpress_roast_dark;
  real b_home_espresso_roast_dark;
  real b_home_mrcoffee_roast_dark;
  real b_home_pods_roast_dark;
  real b_home_instant_roast_dark;
  real b_home_bean2cup_roast_dark;
  real b_home_coldbrew_roast_dark;
  real b_home_cometeer_roast_dark;
  real b_home_other_roast_dark;
  real b_latte_roast_dark;
  real b_otherdrink_roast_dark;
  real b_drip_roast_dark;
  real b_cappuccino_roast_dark;
  real b_espresso_roast_dark;
  real b_cortado_roast_dark;
  real b_americano_roast_dark;
  real b_cup_1orless_roast_dark;
  real b_cup_3ormore_roast_dark;


  real b_roast_light_expert1;
  real b_roast_dark_expert1;

  real b_roast_light_expert2;
  real b_roast_dark_expert2;

  real b_roast_light_expert3;
  real b_roast_dark_expert3;

  real b_roast_light_expert4;
  real b_roast_dark_expert4;

  real b_roast_light_expert6;
  real b_roast_dark_expert6;

  real b_roast_light_expert7;
  real b_roast_dark_expert7;

  real b_roast_light_expert8;
  real b_roast_dark_expert8;

  real b_roast_light_expert9;
  real b_roast_dark_expert9;

  real b_roast_light_expert10;
  real b_roast_dark_expert10;


  real b_roast_light_y;
  real b_roast_dark_y;
  real b_expert1_y;
  real b_expert2_y;
  real b_expert3_y;
  real b_expert4_y;
  real b_expert6_y;
  real b_expert7_y;
  real b_expert8_y;
  real b_expert9_y;
  real b_expert10_y;
}
transformed parameters{
  vector[J] theta_home_frenchpress;
  vector[J] theta_home_espresso;
  vector[J] theta_home_mrcoffee;
  vector[J] theta_home_pods;
  vector[J] theta_home_instant;
  vector[J] theta_home_bean2cup;
  vector[J] theta_home_coldbrew;
  vector[J] theta_home_cometeer;
  vector[J] theta_home_other;

  vector[J] theta_latte;
  vector[J] theta_drip;
  vector[J] theta_otherdrink;
  vector[J] theta_cappuccino;
  vector[J] theta_espresso;
  vector[J] theta_cortado;
  vector[J] theta_americano;

  vector[J] theta_cup_1orless;
  vector[J] theta_cup_3ormore;

  vector[J] theta_roast_light;
  vector[J] theta_roast_dark;

  vector[J] theta_expert1;
  vector[J] theta_expert2;
  vector[J] theta_expert3;
  vector[J] theta_expert4;
  vector[J] theta_expert6;
  vector[J] theta_expert7;
  vector[J] theta_expert8;
  vector[J] theta_expert9;
  vector[J] theta_expert10;
  matrix[J, K] theta_y;
  vector[K] predictors;
  vector[K] probs;
  matrix[J, 30] log_lik_matrix;

  for (j in 1:J) {
  
theta_home_frenchpress[j] = inv_logit(
  a_home_frenchpress +
  b_female_home_frenchpress * female[j] +
  b_gen_other_home_frenchpress * gen_other[j] + 
  b_thirty544_home_frenchpress * thirty544[j] +
  b_over44_home_frenchpress * over44[j] +
  b_under24_home_frenchpress * under24[j]
); 

theta_home_espresso[j] = inv_logit(
  a_home_espresso +
  b_female_home_espresso * female[j] +
  b_gen_other_home_espresso * gen_other[j] + 
  b_thirty544_home_espresso * thirty544[j] +
  b_over44_home_espresso * over44[j] +
  b_under24_home_espresso * under24[j]
); 

theta_home_mrcoffee[j] = inv_logit(
  a_home_mrcoffee +
  b_female_home_mrcoffee * female[j] +
  b_gen_other_home_mrcoffee * gen_other[j] + 
  b_thirty544_home_mrcoffee * thirty544[j] +
  b_over44_home_mrcoffee * over44[j] +
  b_under24_home_mrcoffee * under24[j]
); 

theta_home_pods[j] = inv_logit(
  a_home_pods +
  b_female_home_pods * female[j] +
  b_gen_other_home_pods * gen_other[j] + 
  b_thirty544_home_pods * thirty544[j] +
  b_over44_home_pods * over44[j] +
  b_under24_home_pods * under24[j]
); 

theta_home_instant[j] = inv_logit(
  a_home_instant +
  b_female_home_instant * female[j] +
  b_gen_other_home_instant * gen_other[j] + 
  b_thirty544_home_instant * thirty544[j] +
  b_over44_home_instant * over44[j] +
  b_under24_home_instant * under24[j]
); 

theta_home_bean2cup[j] = inv_logit(
  a_home_bean2cup +
  b_female_home_bean2cup * female[j] +
  b_gen_other_home_bean2cup * gen_other[j] + 
  b_thirty544_home_bean2cup * thirty544[j] +
  b_over44_home_bean2cup * over44[j] +
  b_under24_home_bean2cup * under24[j]
); 

theta_home_coldbrew[j] = inv_logit(
  a_home_coldbrew +
  b_female_home_coldbrew * female[j] +
  b_gen_other_home_coldbrew * gen_other[j] + 
  b_thirty544_home_coldbrew * thirty544[j] +
  b_over44_home_coldbrew * over44[j] +
  b_under24_home_coldbrew * under24[j]
); 

theta_home_cometeer[j] = inv_logit(
  a_home_cometeer +
  b_female_home_cometeer * female[j] +
  b_gen_other_home_cometeer * gen_other[j] + 
  b_thirty544_home_cometeer * thirty544[j] +
  b_over44_home_cometeer * over44[j] +
  b_under24_home_cometeer * under24[j]
); 

theta_home_other[j] = inv_logit(
  a_home_other +
  b_female_home_other * female[j] +
  b_gen_other_home_other * gen_other[j] + 
  b_thirty544_home_other * thirty544[j] +
  b_over44_home_other * over44[j] +
  b_under24_home_other * under24[j]
); 

theta_latte[j] = inv_logit(
  a_latte +
  b_female_latte * female[j] +
  b_gen_other_latte * gen_other[j] +
  b_thirty544_latte * thirty544[j] +
  b_over44_latte * over44[j] +
  b_under24_latte * under24[j] +
  b_home_frenchpress_latte * home_brew_french_press[j] +
  b_home_espresso_latte * home_brew_espresso[j] +
  b_home_mrcoffee_latte * home_brew_mr_coffee[j] +
  b_home_pods_latte * home_brew_pods[j] +
  b_home_instant_latte * home_brew_instant[j] +
  b_home_bean2cup_latte * home_brew_bean2cup[j] +
  b_home_coldbrew_latte * home_brew_cold_brew[j] +
  b_home_cometeer_latte * home_brew_cometeer[j] +
  b_home_other_latte * home_brew_other[j]
);

theta_otherdrink[j] = inv_logit(
  a_otherdrink +
  b_female_otherdrink * female[j] + 
  b_gen_other_otherdrink * gen_other[j] + 
  b_thirty544_otherdrink * thirty544[j] + 
  b_over44_otherdrink * over44[j] + 
  b_under24_otherdrink * under24[j] + 
  b_home_frenchpress_otherdrink * home_brew_french_press[j] + 
  b_home_espresso_otherdrink * home_brew_espresso[j] + 
  b_home_mrcoffee_otherdrink * home_brew_mr_coffee[j] + 
  b_home_pods_otherdrink * home_brew_pods[j] + 
  b_home_instant_otherdrink * home_brew_instant[j] + 
  b_home_bean2cup_otherdrink * home_brew_bean2cup[j] + 
  b_home_coldbrew_otherdrink * home_brew_cold_brew[j] + 
  b_home_cometeer_otherdrink * home_brew_cometeer[j] + 
  b_home_other_otherdrink * home_brew_other[j]
);

theta_drip[j] = inv_logit(
  a_drip +
  b_female_drip * female[j] + 
  b_gen_other_drip * gen_other[j] + 
  b_thirty544_drip * thirty544[j] + 
  b_over44_drip * over44[j] + 
  b_under24_drip * under24[j] + 
  b_home_frenchpress_drip * home_brew_french_press[j] + 
  b_home_espresso_drip * home_brew_espresso[j] + 
  b_home_mrcoffee_drip * home_brew_mr_coffee[j] + 
  b_home_pods_drip * home_brew_pods[j] + 
  b_home_instant_drip * home_brew_instant[j] + 
  b_home_bean2cup_drip * home_brew_bean2cup[j] + 
  b_home_coldbrew_drip * home_brew_cold_brew[j] + 
  b_home_cometeer_drip * home_brew_cometeer[j] + 
  b_home_other_drip * home_brew_other[j]
);

theta_cappuccino[j] = inv_logit(
  a_cappuccino +
  b_female_cappuccino * female[j] +
  b_gen_other_cappuccino * gen_other[j] +
  b_thirty544_cappuccino * thirty544[j] +
  b_over44_cappuccino * over44[j] +
  b_under24_cappuccino * under24[j] +
  b_home_frenchpress_cappuccino * home_brew_french_press[j] +
  b_home_espresso_cappuccino * home_brew_espresso[j] +
  b_home_mrcoffee_cappuccino * home_brew_mr_coffee[j] +
  b_home_pods_cappuccino * home_brew_pods[j] +
  b_home_instant_cappuccino * home_brew_instant[j] +
  b_home_bean2cup_cappuccino * home_brew_bean2cup[j] +
  b_home_coldbrew_cappuccino * home_brew_cold_brew[j] +
  b_home_cometeer_cappuccino * home_brew_cometeer[j] +
  b_home_other_cappuccino * home_brew_other[j]
);

theta_espresso[j] = inv_logit(
  a_espresso +
  b_female_espresso * female[j] +
  b_gen_other_espresso * gen_other[j] +
  b_thirty544_espresso * thirty544[j] +
  b_over44_espresso * over44[j] +
  b_under24_espresso * under24[j] +
  b_home_frenchpress_espresso * home_brew_french_press[j] +
  b_home_espresso_espresso * home_brew_espresso[j] +
  b_home_mrcoffee_espresso * home_brew_mr_coffee[j] +
  b_home_pods_espresso * home_brew_pods[j] +
  b_home_instant_espresso * home_brew_instant[j] +
  b_home_bean2cup_espresso * home_brew_bean2cup[j] +
  b_home_coldbrew_espresso * home_brew_cold_brew[j] +
  b_home_cometeer_espresso * home_brew_cometeer[j] +
  b_home_other_espresso * home_brew_other[j]
);

theta_cortado[j] = inv_logit(
  a_cortado +
  b_female_cortado * female[j] +
  b_gen_other_cortado * gen_other[j] +
  b_thirty544_cortado * thirty544[j] +
  b_over44_cortado * over44[j] +
  b_under24_cortado * under24[j] +
  b_home_frenchpress_cortado * home_brew_french_press[j] +
  b_home_espresso_cortado * home_brew_espresso[j] +
  b_home_mrcoffee_cortado * home_brew_mr_coffee[j] +
  b_home_pods_cortado * home_brew_pods[j] +
  b_home_instant_cortado * home_brew_instant[j] +
  b_home_bean2cup_cortado * home_brew_bean2cup[j] +
  b_home_coldbrew_cortado * home_brew_cold_brew[j] +
  b_home_cometeer_cortado * home_brew_cometeer[j] +
  b_home_other_cortado * home_brew_other[j]
);

theta_americano[j] = inv_logit(
  a_americano +
  b_female_americano * female[j] +
  b_gen_other_americano * gen_other[j] +
  b_thirty544_americano * thirty544[j] +
  b_over44_americano * over44[j] +
  b_under24_americano * under24[j] +
  b_home_frenchpress_americano * home_brew_french_press[j] +
  b_home_espresso_americano * home_brew_espresso[j] +
  b_home_mrcoffee_americano * home_brew_mr_coffee[j] +
  b_home_pods_americano * home_brew_pods[j] +
  b_home_instant_americano * home_brew_instant[j] +
  b_home_bean2cup_americano * home_brew_bean2cup[j] +
  b_home_coldbrew_americano * home_brew_cold_brew[j] +
  b_home_cometeer_americano * home_brew_cometeer[j] +
  b_home_other_americano * home_brew_other[j]
);

theta_cup_1orless[j] = inv_logit(
  a_cup_1orless +
  b_latte_cup_1orless * latte[j] + 
  b_otherdrink_cup_1orless * otherdrink[j] + 
  b_drip_cup_1orless * drip[j] + 
  b_cappuccino_cup_1orless * cappuccino[j] + 
  b_espresso_cup_1orless * espresso[j] + 
  b_cortado_cup_1orless * cortado[j] + 
  b_americano_cup_1orless * americano[j] + 
  b_thirty544_cup_1orless * thirty544[j] +
  b_over44_cup_1orless * over44[j] +
  b_under24_cup_1orless * under24[j]
);

theta_cup_3ormore[j] = inv_logit(
  a_cup_3ormore +
  b_latte_cup_3ormore * latte[j] +
  b_otherdrink_cup_3ormore * otherdrink[j] +
  b_drip_cup_3ormore * drip[j] +
  b_cappuccino_cup_3ormore * cappuccino[j] +
  b_espresso_cup_3ormore * espresso[j] +
  b_cortado_cup_3ormore * cortado[j] +
  b_americano_cup_3ormore * americano[j] +
  b_thirty544_cup_3ormore * thirty544[j] +
  b_over44_cup_3ormore * over44[j] +
  b_under24_cup_3ormore * under24[j]
);

theta_roast_light[j] = inv_logit(
  a_roast_light +
  b_home_frenchpress_roast_light * home_brew_french_press[j] +
  b_home_espresso_roast_light * home_brew_espresso[j] +
  b_home_mrcoffee_roast_light * home_brew_mr_coffee[j] +
  b_home_pods_roast_light * home_brew_pods[j] +
  b_home_instant_roast_light * home_brew_instant[j] +
  b_home_bean2cup_roast_light * home_brew_bean2cup[j] +
  b_home_coldbrew_roast_light * home_brew_cold_brew[j] +
  b_home_cometeer_roast_light * home_brew_cometeer[j] +
  b_home_other_roast_light * home_brew_other[j] +
  b_latte_roast_light * latte[j] +
  b_otherdrink_roast_light * otherdrink[j] +
  b_drip_roast_light * drip[j] +
  b_cappuccino_roast_light * cappuccino[j] +
  b_espresso_roast_light * espresso[j] +
  b_cortado_roast_light * cortado[j] +
  b_americano_roast_light * americano[j] +
  b_cup_1orless_roast_light * cup_1orless[j] +
  b_cup_3ormore_roast_light * cup_3ormore[j]
);

theta_roast_dark[j] = inv_logit(
  a_roast_dark +
  b_home_frenchpress_roast_dark * home_brew_french_press[j] +
  b_home_espresso_roast_dark * home_brew_espresso[j] +
  b_home_mrcoffee_roast_dark * home_brew_mr_coffee[j] +
  b_home_pods_roast_dark * home_brew_pods[j] +
  b_home_instant_roast_dark * home_brew_instant[j] +
  b_home_bean2cup_roast_dark * home_brew_bean2cup[j] +
  b_home_coldbrew_roast_dark * home_brew_cold_brew[j] +
  b_home_cometeer_roast_dark * home_brew_cometeer[j] +
  b_home_other_roast_dark * home_brew_other[j] +
  b_latte_roast_dark * latte[j] +
  b_otherdrink_roast_dark * otherdrink[j] +
  b_drip_roast_dark * drip[j] +
  b_cappuccino_roast_dark * cappuccino[j] +
  b_espresso_roast_dark * espresso[j] +
  b_cortado_roast_dark * cortado[j] +
  b_americano_roast_dark * americano[j] +
  b_cup_1orless_roast_dark * cup_1orless[j] +
  b_cup_3ormore_roast_dark * cup_3ormore[j]
);

theta_expert1[j] = inv_logit(
  a_expert1 +
  b_roast_light_expert1 * roast_light[j] +
  b_roast_dark_expert1 * roast_dark[j]
);

theta_expert2[j] = inv_logit(
  a_expert2 +
  b_roast_light_expert2 * roast_light[j] +
  b_roast_dark_expert2 * roast_dark[j]
);

theta_expert3[j] = inv_logit(
  a_expert3 +
  b_roast_light_expert3 * roast_light[j] +
  b_roast_dark_expert3 * roast_dark[j]
);

theta_expert4[j] = inv_logit(
  a_expert4 +
  b_roast_light_expert4 * roast_light[j] +
  b_roast_dark_expert4 * roast_dark[j]
);

theta_expert6[j] = inv_logit(
  a_expert6 +
  b_roast_light_expert6 * roast_light[j] +
  b_roast_dark_expert6 * roast_dark[j]
);

theta_expert7[j] = inv_logit(
  a_expert7 +
  b_roast_light_expert7 * roast_light[j] +
  b_roast_dark_expert7 * roast_dark[j]
);

theta_expert8[j] = inv_logit(
  a_expert8 +
  b_roast_light_expert8 * roast_light[j] +
  b_roast_dark_expert8 * roast_dark[j]
);

theta_expert9[j] = inv_logit(
  a_expert9 +
  b_roast_light_expert9 * roast_light[j] +
  b_roast_dark_expert9 * roast_dark[j]
);

theta_expert10[j] = inv_logit(
  a_expert10 +
  b_roast_light_expert10 * roast_light[j] +
  b_roast_dark_expert10 * roast_dark[j]
);

// Define the probability of the reference category as the remaining probability after summing up the probabilities of the other categories
//theta_y[j, K] = 1 - sum(theta_y[j, 1:(K - 1)]);

  // Define the linear predictors for each category
  for (k in 1:K) {
   predictors[k] = a_y[k] + 
    b_roast_light_y * roast_light[j] +
    b_roast_dark_y * roast_dark[j] +
    b_expert1_y * expert1[j] +
    b_expert2_y * expert2[j] +
    b_expert3_y * expert3[j] +
    b_expert4_y * expert4[j] +
    b_expert6_y * expert6[j] +
    b_expert7_y * expert7[j] +
    b_expert8_y * expert8[j] +
    b_expert9_y * expert9[j] +
    b_expert10_y * expert10[j];
    }

    // Calculate softmax probabilities and store in theta_y
    probs = softmax(predictors);  // Calculate softmax probabilities

    // Assign each probability to the corresponding entry in theta_y
    for (k in 1:K) {
      theta_y[j, k] = probs[k];  // Store each category probability for respondent j

      log_lik_matrix[j, 1] = home_brew_french_press[j] * log(theta_home_frenchpress[j]) + (1 - home_brew_french_press[j]) * log(1 - theta_home_frenchpress[j]);
      log_lik_matrix[j, 2] = home_brew_espresso[j] * log(theta_home_espresso[j]) + (1 - home_brew_espresso[j]) * log(1 - theta_home_espresso[j]);
      log_lik_matrix[j, 3] = home_brew_mr_coffee[j] * log(theta_home_mrcoffee[j]) + (1 - home_brew_mr_coffee[j]) * log(1 - theta_home_mrcoffee[j]);
      log_lik_matrix[j, 4] = home_brew_pods[j] * log(theta_home_pods[j]) + (1 - home_brew_pods[j]) * log(1 - theta_home_pods[j]);
      log_lik_matrix[j, 5] = home_brew_instant[j] * log(theta_home_instant[j]) + (1 - home_brew_instant[j]) * log(1 - theta_home_instant[j]);
      log_lik_matrix[j, 6] = home_brew_bean2cup[j] * log(theta_home_bean2cup[j]) + (1 - home_brew_bean2cup[j]) * log(1 - theta_home_bean2cup[j]);
      log_lik_matrix[j, 7] = home_brew_cold_brew[j] * log(theta_home_coldbrew[j]) + (1 - home_brew_cold_brew[j]) * log(1 - theta_home_coldbrew[j]);
      log_lik_matrix[j, 8] = home_brew_cometeer[j] * log(theta_home_cometeer[j]) + (1 - home_brew_cometeer[j]) * log(1 - theta_home_cometeer[j]);
      log_lik_matrix[j, 9] = home_brew_other[j] * log(theta_home_other[j]) + (1 - home_brew_other[j]) * log(1 - theta_home_other[j]);
      log_lik_matrix[j, 10] = latte[j] * log(theta_latte[j]) + (1 - latte[j]) * log(1 - theta_latte[j]);
      log_lik_matrix[j, 11] = otherdrink[j] * log(theta_drip[j]) + (1 - otherdrink[j]) * log(1 - theta_drip[j]);
      log_lik_matrix[j, 12] = drip[j] * log(theta_otherdrink[j]) + (1 - drip[j]) * log(1 - theta_otherdrink[j]);
      log_lik_matrix[j, 13] = cappuccino[j] * log(theta_cappuccino[j]) + (1 - cappuccino[j]) * log(1 - theta_cappuccino[j]);
      log_lik_matrix[j, 14] = espresso[j] * log(theta_espresso[j]) + (1 - espresso[j]) * log(1 - theta_espresso[j]);
      log_lik_matrix[j, 15] = cortado[j] * log(theta_cortado[j]) + (1 - cortado[j]) * log(1 - theta_cortado[j]);
      log_lik_matrix[j, 16] = americano[j] * log(theta_americano[j]) + (1 - americano[j]) * log(1 - theta_americano[j]);
      log_lik_matrix[j, 17] = cup_1orless[j] * log(theta_cup_1orless[j]) + (1 - cup_1orless[j]) * log(1 - theta_cup_1orless[j]);
      log_lik_matrix[j, 18] = cup_3ormore[j] * log(theta_cup_3ormore[j]) + (1 - cup_3ormore[j]) * log(1 - theta_cup_3ormore[j]);
      log_lik_matrix[j, 19] = roast_light[j] * log(theta_roast_light[j]) + (1 - roast_light[j]) * log(1 - theta_roast_light[j]);
      log_lik_matrix[j, 20] = roast_dark[j] * log(theta_roast_dark[j]) + (1 - roast_dark[j]) * log(1 - theta_roast_dark[j]);
      log_lik_matrix[j, 21] = expert1[j] *log(theta_expert1[j]) + (1 - expert1)[j] * log(1 - theta_expert1[j]);
      log_lik_matrix[j, 22] = expert2[j] *log(theta_expert2[j]) + (1 - expert2)[j] * log(1 - theta_expert2[j]);
      log_lik_matrix[j, 23] = expert3[j] *log(theta_expert3[j]) + (1 - expert3)[j] * log(1 - theta_expert3[j]);
      log_lik_matrix[j, 24] = expert4[j] *log(theta_expert4[j]) + (1 - expert4)[j] * log(1 - theta_expert4[j]);
      log_lik_matrix[j, 25] = expert6[j] *log(theta_expert6[j]) + (1 - expert6)[j] * log(1 - theta_expert6[j]);
      log_lik_matrix[j, 26] = expert7[j] *log(theta_expert7[j]) + (1 - expert7)[j] * log(1 - theta_expert7[j]);
      log_lik_matrix[j, 27] = expert8[j] *log(theta_expert8[j]) + (1 - expert8)[j] * log(1 - theta_expert8[j]);
      log_lik_matrix[j, 28] = expert9[j] *log(theta_expert9[j]) + (1 - expert9)[j] * log(1 - theta_expert9[j]);
      log_lik_matrix[j, 29] = expert10[j] *log(theta_expert10[j]) + (1 - expert10)[j] * log(1 - theta_expert10[j]);
      log_lik_matrix[j, 30] = Y[j] * log(theta_y[j, k]) + (1 - Y[j]) * log(1 - theta_y[j, k]);
    }
  }
}
model {
  // Priors
  for (k in 1:K) {
    a_y[k] ~ normal(0, 10); // Example: Normal prior with mean 0 and sd 1
  }
  a_latte ~ normal(0, 10);
  a_otherdrink ~ normal(0, 10);
  a_drip ~ normal(0, 10);
  a_cappuccino ~ normal(0, 10);
  a_espresso ~ normal(0, 10);
  a_cortado ~ normal(0, 10);
  a_americano ~ normal(0, 10);
  a_home_frenchpress ~ normal(0, 10);
  a_home_espresso ~ normal(0, 10);
  a_home_mrcoffee ~ normal(0, 10);
  a_home_pods ~ normal(0, 10);
  a_home_instant ~ normal(0, 10);
  a_home_bean2cup ~ normal(0, 10);
  a_home_coldbrew ~ normal(0, 10);
  a_home_cometeer ~ normal(0, 10);
  a_home_other ~ normal(0, 10);
  a_cup_1orless ~ normal(0, 10);
  a_cup_3ormore ~ normal(0, 10);
  a_roast_light ~ normal(0, 10);
  a_roast_dark ~ normal(0, 10);
  a_expert1 ~ normal(0, 10);
  a_expert2 ~ normal(0, 10);
  a_expert3 ~ normal(0, 10);
  a_expert4 ~ normal(0, 10);
  a_expert6 ~ normal(0, 10);
  a_expert7 ~ normal(0, 10);
  a_expert8 ~ normal(0, 10);
  a_expert9 ~ normal(0, 10);
  a_expert10 ~ normal(0, 10);
  b_female_home_frenchpress ~ normal(0, 1);
  b_gen_other_home_frenchpress ~ normal(0, 1);
  b_thirty544_home_frenchpress ~ normal(0, 1);
  b_over44_home_frenchpress ~ normal(0, 1);
  b_under24_home_frenchpress ~ normal(0, 1);
  b_female_home_espresso ~ normal(0, 1);
  b_gen_other_home_espresso ~ normal(0, 1);
  b_thirty544_home_espresso ~ normal(0, 1);
  b_over44_home_espresso ~ normal(0, 1);
  b_under24_home_espresso ~ normal(0, 1);
  b_female_home_mrcoffee ~ normal(0, 1);
  b_gen_other_home_mrcoffee ~ normal(0, 1);
  b_thirty544_home_mrcoffee ~ normal(0, 1);
  b_over44_home_mrcoffee ~ normal(0, 1);
  b_under24_home_mrcoffee ~ normal(0, 1);
  b_female_home_pods ~ normal(0, 1);
  b_gen_other_home_pods ~ normal(0, 1);
  b_thirty544_home_pods ~ normal(0, 1);
  b_over44_home_pods ~ normal(0, 1);
  b_under24_home_pods ~ normal(0, 1);
  b_female_home_instant ~ normal(0, 1);
  b_gen_other_home_instant ~ normal(0, 1);
  b_thirty544_home_instant ~ normal(0, 1);
  b_over44_home_instant ~ normal(0, 1);
  b_under24_home_instant ~ normal(0, 1);
  b_female_home_bean2cup ~ normal(0, 1);
  b_gen_other_home_bean2cup ~ normal(0, 1);
  b_thirty544_home_bean2cup ~ normal(0, 1);
  b_over44_home_bean2cup ~ normal(0, 1);
  b_under24_home_bean2cup ~ normal(0, 1);
  b_female_home_coldbrew ~ normal(0, 1);
  b_gen_other_home_coldbrew ~ normal(0, 1);
  b_thirty544_home_coldbrew ~ normal(0, 1);
  b_over44_home_coldbrew ~ normal(0, 1);
  b_under24_home_coldbrew ~ normal(0, 1);
  b_female_home_cometeer ~ normal(0, 1);
  b_gen_other_home_cometeer ~ normal(0, 1);
  b_thirty544_home_cometeer ~ normal(0, 1);
  b_over44_home_cometeer ~ normal(0, 1);
  b_under24_home_cometeer ~ normal(0, 1);
  b_female_home_other ~ normal(0, 1);
  b_gen_other_home_other ~ normal(0, 1);
  b_thirty544_home_other ~ normal(0, 1);
  b_over44_home_other ~ normal(0, 1);
  b_under24_home_other ~ normal(0, 1);
  b_female_latte ~ normal(0, 1);
  b_gen_other_latte ~ normal(0, 1);
  b_thirty544_latte ~ normal(0, 1);
  b_over44_latte ~ normal(0, 1);
  b_under24_latte ~ normal(0, 1);
  b_home_frenchpress_latte ~ normal(0, 1);
  b_home_espresso_latte ~ normal(0, 1);
  b_home_mrcoffee_latte ~ normal(0, 1);
  b_home_pods_latte ~ normal(0, 1);
  b_home_instant_latte ~ normal(0, 1);
  b_home_bean2cup_latte ~ normal(0, 1);
  b_home_coldbrew_latte ~ normal(0, 1);
  b_home_cometeer_latte ~ normal(0, 1);
  b_home_other_latte ~ normal(0, 1);
  b_female_otherdrink ~ normal(0, 1);
  b_gen_other_otherdrink ~ normal(0, 1);
  b_thirty544_otherdrink ~ normal(0, 1);
  b_over44_otherdrink ~ normal(0, 1);
  b_under24_otherdrink ~ normal(0, 1);
  b_home_frenchpress_otherdrink ~ normal(0, 1);
  b_home_espresso_otherdrink ~ normal(0, 1);
  b_home_mrcoffee_otherdrink ~ normal(0, 1);
  b_home_pods_otherdrink ~ normal(0, 1);
  b_home_instant_otherdrink ~ normal(0, 1);
  b_home_bean2cup_otherdrink ~ normal(0, 1);
  b_home_coldbrew_otherdrink ~ normal(0, 1);
  b_home_cometeer_otherdrink ~ normal(0, 1);
  b_home_other_otherdrink ~ normal(0, 1);
  b_female_drip ~ normal(0, 1);
  b_gen_other_drip ~ normal(0, 1);
  b_thirty544_drip ~ normal(0, 1);
  b_over44_drip ~ normal(0, 1);
  b_under24_drip ~ normal(0, 1);
  b_home_frenchpress_drip ~ normal(0, 1);
  b_home_espresso_drip ~ normal(0, 1);
  b_home_mrcoffee_drip ~ normal(0, 1);
  b_home_pods_drip ~ normal(0, 1);
  b_home_instant_drip ~ normal(0, 1);
  b_home_bean2cup_drip ~ normal(0, 1);
  b_home_coldbrew_drip ~ normal(0, 1);
  b_home_cometeer_drip ~ normal(0, 1);
  b_home_other_drip ~ normal(0, 1);
  b_female_cappuccino ~ normal(0, 1);
  b_gen_other_cappuccino ~ normal(0, 1);
  b_thirty544_cappuccino ~ normal(0, 1);
  b_over44_cappuccino ~ normal(0, 1);
  b_under24_cappuccino ~ normal(0, 1);
  b_home_frenchpress_cappuccino ~ normal(0, 1);
  b_home_espresso_cappuccino ~ normal(0, 1);
  b_home_mrcoffee_cappuccino ~ normal(0, 1);
  b_home_pods_cappuccino ~ normal(0, 1);
  b_home_instant_cappuccino ~ normal(0, 1);
  b_home_bean2cup_cappuccino ~ normal(0, 1);
  b_home_coldbrew_cappuccino ~ normal(0, 1);
  b_home_cometeer_cappuccino ~ normal(0, 1);
  b_home_other_cappuccino ~ normal(0, 1);
  b_female_espresso ~ normal(0, 1);
  b_gen_other_espresso ~ normal(0, 1);
  b_thirty544_espresso ~ normal(0, 1);
  b_over44_espresso ~ normal(0, 1);
  b_under24_espresso ~ normal(0, 1);
  b_home_frenchpress_espresso ~ normal(0, 1);
  b_home_espresso_espresso ~ normal(0, 1);
  b_home_mrcoffee_espresso ~ normal(0, 1);
  b_home_pods_espresso ~ normal(0, 1);
  b_home_instant_espresso ~ normal(0, 1);
  b_home_bean2cup_espresso ~ normal(0, 1);
  b_home_coldbrew_espresso ~ normal(0, 1);
  b_home_cometeer_espresso ~ normal(0, 1);
  b_home_other_espresso ~ normal(0, 1);
  b_female_cortado ~ normal(0, 1);
  b_gen_other_cortado ~ normal(0, 1);
  b_thirty544_cortado ~ normal(0, 1);
  b_over44_cortado ~ normal(0, 1);
  b_under24_cortado ~ normal(0, 1);
  b_home_frenchpress_cortado ~ normal(0, 1);
  b_home_espresso_cortado ~ normal(0, 1);
  b_home_mrcoffee_cortado ~ normal(0, 1);
  b_home_pods_cortado ~ normal(0, 1);
  b_home_instant_cortado ~ normal(0, 1);
  b_home_bean2cup_cortado ~ normal(0, 1);
  b_home_coldbrew_cortado ~ normal(0, 1);
  b_home_cometeer_cortado ~ normal(0, 1);
  b_home_other_cortado ~ normal(0, 1);
  b_female_americano ~ normal(0, 1);
  b_gen_other_americano ~ normal(0, 1);
  b_thirty544_americano ~ normal(0, 1);
  b_over44_americano ~ normal(0, 1);
  b_under24_americano ~ normal(0, 1);
  b_home_frenchpress_americano ~ normal(0, 1);
  b_home_espresso_americano ~ normal(0, 1);
  b_home_mrcoffee_americano ~ normal(0, 1);
  b_home_pods_americano ~ normal(0, 1);
  b_home_instant_americano ~ normal(0, 1);
  b_home_bean2cup_americano ~ normal(0, 1);
  b_home_coldbrew_americano ~ normal(0, 1);
  b_home_cometeer_americano ~ normal(0, 1);
  b_home_other_americano ~ normal(0, 1);
  b_latte_cup_1orless ~ normal(0, 1);
  b_otherdrink_cup_1orless ~ normal(0, 1);
  b_drip_cup_1orless ~ normal(0, 1);
  b_cappuccino_cup_1orless ~ normal(0, 1);
  b_espresso_cup_1orless ~ normal(0, 1);
  b_cortado_cup_1orless ~ normal(0, 1);
  b_americano_cup_1orless ~ normal(0, 1);
  b_thirty544_cup_1orless ~ normal(0, 1);
  b_over44_cup_1orless ~ normal(0, 1);
  b_under24_cup_1orless ~ normal(0, 1);
  b_latte_cup_3ormore ~ normal(0, 1);
  b_otherdrink_cup_3ormore ~ normal(0, 1);
  b_drip_cup_3ormore ~ normal(0, 1);
  b_cappuccino_cup_3ormore ~ normal(0, 1);
  b_espresso_cup_3ormore ~ normal(0, 1);
  b_cortado_cup_3ormore ~ normal(0, 1);
  b_americano_cup_3ormore ~ normal(0, 1);
  b_thirty544_cup_3ormore ~ normal(0, 1);
  b_over44_cup_3ormore ~ normal(0, 1);
  b_under24_cup_3ormore ~ normal(0, 1);
  b_home_frenchpress_roast_light ~ normal(0, 1);
  b_home_espresso_roast_light ~ normal(0, 1);
  b_home_mrcoffee_roast_light ~ normal(0, 1);
  b_home_pods_roast_light ~ normal(0, 1);
  b_home_instant_roast_light ~ normal(0, 1);
  b_home_bean2cup_roast_light ~ normal(0, 1);
  b_home_coldbrew_roast_light ~ normal(0, 1);
  b_home_cometeer_roast_light ~ normal(0, 1);
  b_home_other_roast_light ~ normal(0, 1);
  b_latte_roast_light ~ normal(0, 1);
  b_otherdrink_roast_light ~ normal(0, 1);
  b_drip_roast_light ~ normal(0, 1);
  b_cappuccino_roast_light ~ normal(0, 1);
  b_espresso_roast_light ~ normal(0, 1);
  b_cortado_roast_light ~ normal(0, 1);
  b_americano_roast_light ~ normal(0, 1);
  b_cup_1orless_roast_light ~ normal(0, 1);
  b_cup_3ormore_roast_light ~ normal(0, 1);
  b_home_frenchpress_roast_dark ~ normal(0, 1);
  b_home_espresso_roast_dark ~ normal(0, 1);
  b_home_mrcoffee_roast_dark ~ normal(0, 1);
  b_home_pods_roast_dark ~ normal(0, 1);
  b_home_instant_roast_dark ~ normal(0, 1);
  b_home_bean2cup_roast_dark ~ normal(0, 1);
  b_home_coldbrew_roast_dark ~ normal(0, 1);
  b_home_cometeer_roast_dark ~ normal(0, 1);
  b_home_other_roast_dark ~ normal(0, 1);
  b_latte_roast_dark ~ normal(0, 1);
  b_otherdrink_roast_dark ~ normal(0, 1);
  b_drip_roast_dark ~ normal(0, 1);
  b_cappuccino_roast_dark ~ normal(0, 1);
  b_espresso_roast_dark ~ normal(0, 1);
  b_cortado_roast_dark ~ normal(0, 1);
  b_americano_roast_dark ~ normal(0, 1);
  b_cup_1orless_roast_dark ~ normal(0, 1);
  b_cup_3ormore_roast_dark ~ normal(0, 1);
  b_roast_light_expert1 ~ normal(0, 1);
  b_roast_dark_expert1 ~ normal(0, 1);
  b_roast_light_expert2 ~ normal(0, 1);
  b_roast_dark_expert2 ~ normal(0, 1);
  b_roast_light_expert3 ~ normal(0, 1);
  b_roast_dark_expert3 ~ normal(0, 1);
  b_roast_light_expert4 ~ normal(0, 1);
  b_roast_dark_expert4 ~ normal(0, 1);
  b_roast_light_expert6 ~ normal(0, 1);
  b_roast_dark_expert6 ~ normal(0, 1);
  b_roast_light_expert7 ~ normal(0, 1);
  b_roast_dark_expert7 ~ normal(0, 1);
  b_roast_light_expert8 ~ normal(0, 1);
  b_roast_dark_expert8 ~ normal(0, 1);
  b_roast_light_expert9 ~ normal(0, 1);
  b_roast_dark_expert9 ~ normal(0, 1);
  b_roast_light_expert10 ~ normal(0, 1);
  b_roast_dark_expert10 ~ normal(0, 1);
  b_roast_light_y ~ normal(0, 1);
  b_roast_dark_y ~ normal(0, 1);
  b_expert1_y ~ normal(0, 1);
  b_expert2_y ~ normal(0, 1);
  b_expert3_y ~ normal(0, 1);
  b_expert4_y ~ normal(0, 1);
  b_expert6_y ~ normal(0, 1);
  b_expert7_y ~ normal(0, 1);
  b_expert8_y ~ normal(0, 1);
  b_expert9_y ~ normal(0, 1);
  b_expert10_y ~ normal(0, 1);

  // Likelihood
  for (i in 1:30) {
    target += sum(log_lik_matrix[, i]);
  }
}

/*
    Title: Recipe Project Data Manipulation Queries
    Author: Mark Piccirilli
    Date: 7/19/2015
    Course/Assignment: cs340/Project
    Description: This file contains the data Manipulation queries to search or filter the database,
    insert new information into the database, and gather any necessary information needed for
    pages in the website.
*/

-- SEARCH/FILTER RECIPE QUERIES
-- keyword search
SELECT id FROM recipes where name=[name];

-- search based on meal_type and/or ethnic_cuisine
SELECT id FROM recipes WHERE meal_type=[meal_type] AND ethnic_cuisine=[ethnic_cuisine];

-- search based on meal_type and/or ethnic_cuisine where low cal is selected
SELECT id FROM recipes WHERE meal_type=[meal_type] AND ethnic_cuisine=[ethnic_cuisine] AND low_calorie=1;

-- search based on meal_type and/or ethnic_cuisine when low sodium is selected
SELECT id FROM recipes WHERE meal_type=[meal_type] AND ethnic_cuisine=[ethnic_cuisine] AND low_sodium=1;

-- search based on meal_type and/or ethnic_cuisine when low_sodium and low cal are selected
SELECT id FROM recipes WHERE meal_type=[meal_type] AND ethnic_cuisine=[ethnic_cuisine] AND low_calorie=1 AND low_sodium=1;

-- SEARCH FOR INGREDIENTS AND COOKWARE
-- search ingredients
SELECT id FROM ingredients WHERE name=[ingredient_name];
-- after user select ingredient find serving_size_unit with this query
SELECT serving_size_unit FROM ingredients WHERE id=[id];
-- the prompt user to update the quantity feild(in serving size unit) of the recipe_ingredient table
UPDATE recipe_ingredients SET ingredient_quantity=[quantity] WHERE id=[id];

-- search cookware
SELECT id FROM cookware WHERE name=[item_name];


-- FIND HEALTH INFORMATION ABOUT A RECIPE
-- calories
SELECT (sum(i.calories*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- fat_g
SELECT (sum(i.fat_g*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- sodium_mg
SELECT (sum(i.sodium_mg*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- sugar_g
SELECT (sum(i.sugar_g*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- protein_g
SELECT (sum(i.protein_g*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- vitaminA_pdv
SELECT (sum(i.vitaminA_pdv*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];
-- vitaminC_pdv
SELECT (sum(i.vitaminC_pdv*(ri.ingredient_quantity/i.serving_size)))/r.servings FROM ingredients i INNER JOIN recipe_ingredients ri ON i.id=ri.ingredient_id
INNER JOIN recipes r ON r.id=ri.recipe_id AND r.id=[recipe_id];

--INSERT QUERIES
-- insert an ingredient (user adds a new ingredient)
INSERT INTO ingredients (name, serving_size, serving_size_unit, calories, fat_g, sodium_mg, sugar_g, protein_g, vitaminA_pdv, vitaminC_pdv)
VALUES ([name], [serving_size], [serving_size_unit], [calories], [fat_g], [sodium_mg], [sugar_g], [protein_g], [vitaminA_pdv], [vitaminC_pdv]);

-- insert cookware (user adds a new cookware item)
INSERT INTO cookware (name, price) VALUES ([name], [price]);

-- insert a recipe
-- recipe table (new recipe added by user)
INSERT INTO recipes (name, instructions, meal_type, ethnic_cuisine, low_cal, low_sodium, servings, contributor, date_contributed) VALUES
([name], [instructions], [meal_type], [ethnic_cuisine], [low_cal], [low_sodium], [servings], [contributor], [date_contributed]);
-- recipe_ingredients table (ingredients for user recipe)
INSERT INTO recipe_ingredients (recipe_id, ingredient_id) VALUES ([recipe_id], [ingredient_id]);
-- recipe_cookware table (cookware for user recipe)
INSERT INTO recipe_cookware (recipe_id, cookware_id) VALUES ([recipe_id, cookware_id]);

-- insert a user (new user created)
INSERT INTO users (first_name, last_name, user_name, user_password, email, cooking_experience) VALUES
([first_name], [last_name], [user_name], [user_password], [email], [cooking_experience]);

-- insert new saved recipe (user saves a recipe)
INSERT INTO saved_recipes (user_id, recipe_id) VALUES ([user_id], [recipe_id]);

-- insert new followed user (user follows another user)
INSERT INTO user_contributor (follower_id, contributor_id) VALUES ([follower_id], [contributor_id]);


-- EDIT RECIPE QUERIES
-- update recipes
UPDATE recipes SET name=[name], instructions=[instructions], meal_type=[meal_type],
ethnic_cuisine=[ethnic_cuisine] WHERE id=[recipe_id];

-- delete recipe
DELETE FROM recipes WHERE id=[recipe_id];


-- CONTRIBUTOR PAGE QUERIES(can be viewed by all)
-- find the appropriate account information to display on the page (name, user name, cooking experience)
SELECT first_name, last_name, user_name, cooking_experience FROM users WHERE id=[id]
-- find all recipes from a certain contributor
SELECT id, name FROM recipes WHERE contributor=[contributor_id];


-- ACCOUNT PAGE QUERIES(only viewed by user of that account)
-- find all account information except password to display on page
SELECT first_name, last_name, user_name, email, cooking_experience FROM users WHERE id=[id];

-- find recipes contributed to
SELECT id, name FROM recipes WHERE contributor = [contributor_id];

-- update account info
UPDATE users SET first_name=[first_name], last_name=[last_name], user_name=[user_name], password=[password],
 email=[email], cooking_experience=[cooking_experience] WHERE id=[id];

-- delete Account
DELETE FROM users WHERE id=[user_id];

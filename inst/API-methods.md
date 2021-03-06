REST API Method Reference
---

All the available REST API methods are grouped into nine categories.

Below are all the available methods organised into the relevant categories. The corresponding `Implemented as` is the available function in `fatsecretR` which matches the API method. Where `Implemented as` is `NULL`, this indicates that the API method has not yet been implemented in `fatsecretR`.

##### 1. Foods
API Method         | Implemented as
-------------------|-------
food.add_favourite | NULL
food.delete_favourite| NULL
food.get|getFoodID
foods.get_favourites|NULL
foods.get_most_eaten|NULL
foods.get_recently_eaten|NULL
foods.search|getFood

##### 2. Recipes
API Method         | Implemented as
-------------------|-------
recipe.add_favourite | NULL
recipe.delete_favourite| NULL
recipe.get|NULL
recipes.get_favourites|NULL
recipes.search|NULL

##### 3. Recipe Types
API Method         | Implemented as
-------------------|-------
recipe_types.get | NULL

##### 4. Saved Meals
API Method         | Implemented as
-------------------|-------
saved_meal.create| NULL
saved_meal.delete| NULL
saved_meal.edit|NULL
saved_meals.get|NULL
saved_meal_item.add|NULL
saved_meal_item.delete|NULL
saved_meal_item.edit|NULL
saved_meal_item.get|NULL

##### 5. Exercises
API Method         | Implemented as
-------------------|-------
exercises.get | NULL

##### 6. Profile Management
API Method         | Implemented as
-------------------|-------
profile.create | makeProfile
profile.get| getProfile / getUserProfile *
profile.get_auth|getAuth
profile.request_script_session_key|NULL

##### 7. Profile Food Diary
API Method         | Implemented as
-------------------|-------
food_entries.copy | NULL
food_entries.copy_saved_meal| NULL
food_entries.get|getFoodEntry
food_entries.get_month|getFoodEntryMonth
food_entry.create|NULL
food_entry.delete|NULL
food_entry.edit|NULL

##### 8. Profile Exercise Diary
API Method         | Implemented as
-------------------|-------
exercise_entries.commit_day | NULL
exercise_entries.get| NULL
exercise_entries.get_month|NULL
exercise_entries.save_template|NULL
exercise_entry.edit|NULL

##### 9. Profile Weight Diary
API Method         | Implemented as
-------------------|-------
weight.update | NULL
weight.get_month| NULL

# README

Project of the week, Week 2

# Ingredient Conversion

The intent behind this service is to, given an array of ingredients and a servings size, return a payload of the ingredients and calculated measurements for the serving size.

# How to install
1. Clone the repository
2. `bundle install`

# How to run
1. rails s

# Example usage

```
curl -X PUT http://localhost:3000/v1/ingredients \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
    "serving_size": 2,
    "ingredients": [
        { "ingredient": "1/2 cup of flour" },
        { "ingredient": "3/4 cup of flour" }
    ]
}'
```

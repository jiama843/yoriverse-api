# Overview

## Routes

```
api_character_relationships POST   /api/characters/:character_id/relationships(.:format)     api/relationships#create
 api_character_relationship DELETE /api/characters/:character_id/relationships/:id(.:format) api/relationships#destroy
   api_character_appearance GET    /api/characters/:character_id/appearance(.:format)        api/characters#appearance
       api_character_traits GET    /api/characters/:character_id/traits(.:format)            api/characters#traits
                            GET    /api/characters/:character_id/relationships(.:format)     api/characters#relationships
             api_characters GET    /api/characters(.:format)                                 api/characters#index
                            POST   /api/characters(.:format)                                 api/characters#create
              api_character GET    /api/characters/:id(.:format)                             api/characters#show
                            PATCH  /api/characters/:id(.:format)                             api/characters#update
                            PUT    /api/characters/:id(.:format)                             api/characters#update
                            DELETE /api/characters/:id(.:format)                             api/characters#destroy
                       root GET    /                                                         characters#index
```


## Characters

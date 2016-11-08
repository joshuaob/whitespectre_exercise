# Whitespectre Exercise  
This API requires PostgreSQL running of its default port and ruby 2.3.1. PostgresSQL is setup to use the deafault user configured during installation, to edit this configuration, checkout config/database.yml  

### Setup  
1. clone/unzip project and cd into project directory - ```$ cd whitespectre_exercise```
2. create databases - ```$ rake db:create```
3. run migrations - ```$ rake db:migrate```
4. ceate seed data - ```$ rake db:seed```
5. run specs - ```$ rake```  
6. run the API - ``` $ rails s -p 9292 ```  

### API endpoints  
This API is compliant with the JSON api spec and expects all attributes to be nested under a root data key as shown below
```
    {
        "data": {
            "type": "group events",
            "attributes": {
            }
        }
    }
```
- GET /api/group_events - get publsihed non deleted group events
- GET /api/group_events/id - get a group event
- POST /api/group_events - create a group event
- PATCH /api/group_events/id - update a group event
- POST /api/group_events/id/publish - publish a group event
- DELETE /api/group_events/id - delete a group event (mark as deleted)

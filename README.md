### iam puls TODO

A simple TODO list application which meets the following requirements: 

* A user can create a ToDo
* A user can list ToDos
* A user can mark a ToDo as complete - ( Mark the checkbox )
* A user can delete a ToDo
 ** The delete functionality should not permanently delete the ToDo from the DB.

### Scopes

* Todo model has 2 scopes

* Find all records that are not deleted
````
	Todo.all_todos

````

* Find only the deleted record
````
	Todo.only_deleted

````

* Specs can be found at app/spec directory for both model and controllers. 
* Used factories for creating models for the specs. 
* Used forgery gem to create random data for the models. 
* Used scaffolding for generating controllers, models and views. 
* Used twitter bootstrap and it's generators for quickly making the pages minimally pretty/readable.

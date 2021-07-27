# Groupomania

## OpenClassrooms - Web Developper path - Project 7


### Aim
- Build the MVP for an internal social network for the employees of Groupomania. The social network should include two forums; one where employees can share multimdedia content and one where they can share articles.
- Only one of these two functionnalities will be developped.
- The project should be written in JavaScript and work with an SQL database.
- The API should be secured.
- WCAG standards should be respected.

For more details, see the functional specification.


### How to install the app

- Clone this repo.

#### Database
- Connect to a MySQL client.
- Run `CREATE DATABASE groupomania;`.
- Import the file groupomania.sql.
- To connect to the database change the USER and PASSWORD in the file config/db.config.js so they match your MySQL configuration.

#### Back-end
- Install nodemon.
- Run `npm install`.
- Run `npm start``. The server should run on localhost:3000.

#### Front-end
- Install Node.js version 14.0.
- Install Vue.
- Run `npm install`.
- Run `npm start`.
- Go to http://localhost:8080/


### Technologies used
- Database: MySQL
- Server: Node.js, Express, Sequelize
- Frontend: Vue.js, Sass


### API Guidelines
xxxxxxxxx


### How to use the app

#### Create an account
You need to provide your name, an email address and a password. You can also add a photo, pseudo and bio to your profile. You can delete your profile whenever you want.

#### Login
With your email address and password.

#### Participate
You can view users' messages, replies, and likes.
You can post a message, reply to a message, like a message or a comment.
You can delete your own message, comment or like.
An administrator can delete your comment, message or account if you don not respect the rules of the forum.


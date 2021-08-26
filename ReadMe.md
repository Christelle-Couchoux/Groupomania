# Groupomania

## OpenClassrooms - Web Developper path - Project 7


### Aim
- Build the MVP for an internal social network for the employees of the company Groupomania. The social network should include two forums; one where employees can share multimdedia content and one where they can share articles.
- Only one of these two functionnalities will be developped.
- The project should be written in JavaScript and work with an SQL database.
- The API should be secured.
- WCAG standards should be respected.

For more details, see the functional specification file.


### How to install the app

- Clone this repo.

#### Database
- Connect to a MySQL client.
- Run `CREATE DATABASE groupomania;`.
- Import database/groupomania.sql.
- To connect to the database, change the values of USER, PASSWORD and PORT in config/db.config.js so they match your MySQL configuration.

#### Back-end
- Install nodemon.
- Run `npm install`.
- Run `npm start`. The server should run on localhost:3000.

#### Front-end
- Install Node.js version 14.0.
- Install Vue.
- Run `npm install`.
- Run `npm run serve`.
- Go to http://localhost:8080/


### Technologies used
- Database: MySQL
- Server: Node.js, Express, Sequelize
- Frontend: Vue.js, Sass


### API Guidelines
See the API guidelines file.


### How to use the app

#### Create an account
You need to provide a pseudo, an email address and a password. You can then also add a photo and a bio to your profile. You can delete your account whenever you want.

#### Login
You need to provide your email address and password.

#### Participate
You can view users' posts, comments, and likes.
You can add a post, comment on a post, and like a post.
You can delete your own post, comment or like.
The administrator can delete your comment, post or account if you do not respect the rules of the forum.

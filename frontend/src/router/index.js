import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Signup from '../views/Signup.vue'
import Forums from '../views/Forums.vue'
import Articles from '../views/Articles.vue'
import EditProfile from '../views/EditProfile.vue'
import UserPosts from '../views/UserPosts.vue'
import UserPostsComments from '../views/UserPostsComments.vue'
import UserLikes from '../views/UserLikes.vue'
import Notifications from '../views/Notifications.vue'
import Search from '../views/Search.vue'
import Posts from '../views/Posts.vue'
import Post from '../views/Post.vue'
import PostLikes from '../views/PostLikes.vue'
import CommentLikes from '../views/CommentLikes.vue'


const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },

  {
    path: '/login',
    name: 'Login',
    component: Login
  },

  {
    path: '/signup',
    name: 'Signup',
    component: Signup
  },

  {
    path: '/forums',
    name: 'Forums',
    component: Forums
  },

  {
    path: '/articles',
    name: 'Articles',
    component: Articles
  },

  {
    path: '/user/:userId/edit',
    name: 'EditProfile',
    component: EditProfile
  },

  {
    path: '/user/:userId/posts',
    name: 'UserPosts',
    component: UserPosts
  },

  {
    path: '/user/:userId/posts-comments',
    name: 'UserPostsComments',
    component: UserPostsComments
  },

  {
    path: '/user/:userId/likes',
    name: 'UserLikes',
    component: UserLikes
  },

  {
    path: '/user/:userId/notifications',
    name: 'Notifications',
    component: Notifications
  },

  {
    path: '/search',
    name: 'Search',
    component: Search
  },

  {
    path: '/posts',
    name: 'Posts',
    component: Posts
  },

  {
    path: '/posts/:postId',
    name: 'Post',
    component: Post
  },

  {
    path: '/posts/:postId/likes',
    name: 'PostLikes',
    component: PostLikes
  },

  {
    path: '/comments/:commentId/likes',
    name: 'CommentLikes',
    component: CommentLikes
  },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router

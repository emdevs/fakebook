# Fakebook

Fakebook, as the name suggests, is a clone of the popular social media website Facebook. It has core features of facebook implemented, namely posting, liking, commenting, and friendships. 
It also includes several real-time features, such as private messaging, chatrooms, as well as online statuses. Styling is done via Sass and Bootstrap. 

[Live App](https://fakebook-site.herokuapp.com/)
*(Please be patient with the intial loading of the site, the heroku app is likely undergoing a cold start)*


## Table of Contents
* [Features](#features)
    * [Login and Signup](#login-and-signup)
    * [Posts](#posts)
    * [Comments and Likes](#comments-and-likes)
    * [Friendships](#friendships)
        * [Private Chat](#private-chat)
    * [Clubs](#clubs)
        * [Chatroom](#chatroom)
    * [Online status](#online-status)
* [Dependencies](#dependencies)
* [Gems](#some-gems-used)
* [Notes](#notes)


## Features
### Login and Signup

Login and registration of accounts are both handled by devise. Optionally, users are 
given the choice of logging into Fakebook via a Facebook account. All other features of Fakebook are only accessible through a signed in account.

### Posts

Users are able to make their own posts, which have basic CRUD (Create, Read, Update, Delete) functionality. Additionally, users have the option of uploading an image for a post. 

### Comments and Likes

Comments and likes allow other users to interact with existing posts. Both posts and comments can be liked by a user. 

### Friendships

Friendships are a central feature of Facebook. Users can have friendships with other users through friend requests. New friendships instantiate a private chat that allows two friends to privately communicate with one another. 

#### Private Chat

Allows for real-time messaging between two friends on the website. Conversation
history will persist after a friendship is terminated, however messaging will be disabled between the two users. 

### Clubs

Clubs are a feature that grants access to a select number of users access, through memberships. Each have their own post wall, which can only be viewed and posted to by their own members. Users can also create their own clubs, and set their own member capacity limit. For particularly annoying users, club owners have the ability to block members from their club, which denies them access to all club posts, as well as the club [chatroom](#chatroom).


#### Chatroom

Chatroom is a designated space only members of a club can view and post messages to. Like private chat, club members are able to send and recieve incoming and outgoing messages in real-time, without the need to refresh the page. 


### Online Status

Fakebook users' online statuses are tracked via a database and channel broadcasts. On select pages, a user will be able to see which friends are currently online/offline via a green/red circle icon. This is immediately updated when the online status of a user changes.


## Dependencies
* rails-actioncable
* rails-activestorage
* rails-ujs
* webpacker
* turbolinks


## Some gems used
* redis
* devise
* omniauth-facebook
* omniauth-rails_csrf_protection
* letter_opener
* faker
* cloudinary
* figaro


## Notes
This project is the final [capstone project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project) of the Rails section of [The Odin Project](https://www.theodinproject.com/), an open source web development course that teaches you full stack web development. 

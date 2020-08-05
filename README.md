# Octo Events

Octo Events is an application that listens to Github Events via webhooks and expose by an api for later use.

This one was built with Ruby on Rails Framework, version 6.0.3.2 and Ruby version 2.6.5p114.

## Get Started

To get it started, there are two main steps. The first is more up to you to set your ngrok host tunel. The second is set properly the application to run.

First of all, let us start by clonning this repository: run in your terminal:

`git clone https://github.com/Pauloparakleto/webhookrails.git`

If your Operational System is Linux, comment the last gem on Gemfile. If it is a Windows System, uncomment it. Then, run:

`bundle` (shortcut for `bundle install`)

Let us now leave your cloned Rails application waiting a bit. Let us turn our attention to the external configuration to reach your local host securely.

## I. Providing your encrypted local host to be exposed

In oder to receive events from Github and saves them locally on your database, you must read the following docs on [ngrok](https://ngrok.com/).

(...)

Now you have an encrypted host pointing to your localhost and a token to submit on the creating webhook page.

1. On Github, select a repository you want to whatch *>> Settings >> Webhook >> click Add webhook button*;
2. Copy and past to **Payload URL** field the encrypted response you generated by running on your command line `./ngrok http 3000` (if your rails server listen on port 3000). Note you have both a http and a https for the same host given. Considering your environment as development which doesn't force https, you must choose `https//*.io` plus the following to that host inside the field: `/webhook`. Your final Payload URL will be as `https//*.io/webhook`;
3. The **Content type** must be `application/json` since we are creating an API only system;
4. **Secret** field is where you must past the token given by [ngrok](https://ngrok.com/). It needs to be present in your **./ngrok token** according to [ngrok](https://ngrok.com/) you already read;
5. Choose *Let me select individual events* and select just **Issues**.
6. Press **Creat webhook** button.

Now this Github repository knows where the host is to send post request.

Your system is not listenning to localhost yet since you have not run `rails server`. But wait the following steps to do so.

Note: you can check the official instructions here:
* Webhooks Overview: https://developer.github.com/webhooks/ 
* Creating Webhooks : https://developer.github.com/webhooks/creating/


## II. Configuring your Rails

Rails need to know the hosts it will be listenning in on.

1. Go to your `config/enviroment/development.rb`. Change the `config.hosts = "localhost"` to `config.hosts = ["localhost", "3xampl3g1v3n.ngrok.io"]`. This is so because Rails need both hosts, the localhost to local get requests to the database. And the encrypted host to receive post request from github. Note "3xampl3g1v3n.ngrok.io" it is jus an *example given". You must past the encrypted host provided by ngrok on your terminal.

ngrok will provide always a new encrypted host for every time you run `./ngrok http port-number`

2. Database settings for postgresql: on `database.yml`, you must have something like this:



```javascript
default: &default
adapter: postgresql
  encoding: unicode
  username: postgres
  password: yourpassword
  host: localhost
```
  
  After this, run on your terminal:

  `rails db:create`, then:

  `rails db:migrate`

  Now you have two tables, the first one to enumerate issues id; the second one to register events (opened, closed, reopened actions).

  The relationship between models issue and event is a has_many belongs_to, in other word, issue has many events, while events belongs just to one issue.



The Events endpoint will expose the persist the events by an api that will filter by issue number

**Request examples:**

List all issues found without show its relation with events.
> GET /issues/

> GET /issue/

Both single and plural mode will point to the same index controller. 

**Response:**

> 200 OK
```javascript
[{"id":49,"created_at":"2020-08-03T06:07:13.265Z","updated_at":"2020-08-03T06:07:13.265Z"},{"id":1,"created_at":"2020-08-03T19:47:05.717Z","updated_at":"2020-08-03T19:47:05.717Z"},{"id":52,"created_at":"2020-08-03T23:44:10.100Z","updated_at":"2020-08-03T23:44:10.100Z"}]
```

Show a specific issue (without any events relationship):
> GET /issue/1

> GET /issues/1

Both single and plural mode will find the show action.

**Response:**

> 200 OK
```javascript
{"id":1,"created_at":"2020-08-03T19:47:05.717Z","updated_at":"2020-08-03T19:47:05.717Z"}
```

Show all events related to a issue:

> GET /issue/1/event

> GET /issue/1/events

> GET /issues/1/event

> GET /issues/1/events

**Response:**

> 200 OK
```javascript
[{"id":1,"issue_id":49,"name":null,"created_at":"2020-08-03T06:07:59.381Z","updated_at":"2020-08-03T06:07:59.381Z"},{"id":7,"issue_id":49,"name":"reopened","created_at":"2020-08-03T06:09:34.872Z","updated_at":"2020-08-03T06:09:34.872Z"},{"id":8,"issue_id":49,"name":"closed","created_at":"2020-08-03T06:10:52.630Z","updated_at":"2020-08-03T06:10:52.630Z"},{"id":9,"issue_id":49,"name":"reopened","created_at":"2020-08-03T06:11:40.990Z","updated_at":"2020-08-03T06:11:40.990Z"},{"id":10,"issue_id":1,"name":"opened","created_at":"2020-08-03T19:49:28.591Z","updated_at":"2020-08-03T19:49:28.591Z"},{"id":11,"issue_id":1,"name":"closed","created_at":"2020-08-03T19:50:43.830Z","updated_at":"2020-08-03T19:50:43.830Z"},{"id":12,"issue_id":52,"name":"opened","created_at":"2020-08-03T23:44:10.465Z","updated_at":"2020-08-03T23:44:10.465Z"},{"id":13,"issue_id":52,"name":"closed","created_at":"2020-08-03T23:51:49.260Z","updated_at":"2020-08-03T23:51:49.260Z"}]
```

Show a specific event related to a specific issue:

> GET /issue/1/event/1

> GET /issue/1/events/1

> GET /issues/1/event/1

> GET /issues/1/events/1

**Response:**

> 200 OK
```javascript
[{"id":7,"issue_id":49,"name":"reopened","created_at":"2020-08-03T06:09:34.872Z","updated_at":"2020-08-03T06:09:34.872Z"}]
```

Now you are ready to check it out, have fun!
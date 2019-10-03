![Icon](README/Assets/Icon.png)

The Design iOS application is a medium of endless inpsiration offerring an infinite scroll through randomly generated images of DESIGN.

# Getting Started

To get up and running with the server that enables Design run `brew bundle`. The server has a dependency on `node` which may be installed via `homebrew`, manually, or via a manager such as [`nvm`](https://github.com/nvm-sh/nvm). Any needed dependencies of Design may be added to the `Podfile`. 

# Infinite Scroll

![infinite_scroll](README/Assets/infinite_scroll.gif)

To ready the server run `make infinite_scroll`. The server provides two endpoints to fetch the images. Below are two `curl` requests to inspect the API.

To fetch a JSON array of image metadata:
```
curl -X GET "http://localhost:8081/inspiration?count=10"
```

To fetch a particular `png`:
```
curl -o D.png "http://localhost:8081/inspiration/image?letter=0&background=%2388afa1&stroke=5&strokeFill=%23db4ffb&fillOne=%23c1b4c5&fillTwo=%23441e16&fillThree=%2328954f"
```

# Signin

To ready the server run `make signin`.

The server supports authentication via a `POST` of a JWT token. Here's an example `curl`:

```
curl -d "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXJuYW1lIiwicGFzc3dvcmQiOiJwYXNzd29yZCIsImNsaWVudF9pZCI6ImNsaWVudF9pZCJ9.-7kGjg539qYRW5OyXgDRGz1lcED7gq4bmsTfHYjN6nE" -X POST "http://localhost:8081/signin"
```

Subsequent fetches of the image metadata and `png`s must be supplied with an Authorization header. For example:

```
curl -H "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NfdG9rZW4iOiJhY2Nlc3NfdG9rZW4iLCJpYXQiOjE1Njk4NTk5MDIxNTB9.54yCQhOL1r7jP6M6BZOiqDF0JLbZbG7Bg1C0hmD85SM" -X GET "http://localhost:8081/inspiration?count=10"
```

A useful dependency or starting point may be [kylef/JSONWebToken.swift](https://github.com/kylef/JSONWebToken.swift).

# Timing Out

To ready the server run `make timeout`.

To simulate authentication timeouts the server will now enforce the JWT `exp` at 10 seconds. How might we refactor the application or request flow to account for authorization expiration?

# Animate!

![splash](README/Assets/splash.gif)

Let's animate the splash screen to captivate the user and perhaps we should animate the presentation of the images?

![easein](README/Assets/easein.gif)

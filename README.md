# Problem

Server gets the following response:
```GET /content.txt6.0.50:8000/content.txt HTTP/1.1```

## Expectation

Server *should* receive the following response:
```GET /content.txt HTTP/1.1```

I suspect that when copying the uri from one buffer to the other, 
a null-terminator is not being added or the _ist_ struct is not having it's _len_ property updated.

# Running this example

```docker-compose up --build```

# The Achitecture

App -> first\_proxy -> second\_proxy -> Server

## App

* Described by `App.Dockerfile`
* A script that calls curl every second 
* Requests "/content.txt"
* Requests $Server with curl's proxy flag (-x) to $first_proxy
* Prints the result

## first\_proxy

* HAProxy instance
* Config file is `first.haproxy.cfg`
* Has a single frontend and backend that direct requests to second\_proxy

## second\_proxy

* HAProxy instance
* Config file is `second.haproxy.cfg`
* has a single frontend and backend that directs requests to $Server
* **has option http_proxy**

## Server

* Described by `Server.Dockerfile`
* A script that starts python http.server with "content.txt" in the directory
* Prints the requests as they come


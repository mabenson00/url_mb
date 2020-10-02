URL Shortener: Back End

Your task is to build the back end of a web service for shortening URLs. This will be an API service that a client would communicate with. The deliverable is the source code, written in Ruby, using whichever libraries, tools, database(s), and development methodologies you choose.

The requirements intentionally leave out many details. This is an opportunity for you to make decisions about the design of the service. What you leave out is just as important as what you include!

Product Requirements:

- Clients should be able to create a shortened URL from a longer URL.
- Clients should be able to specify a custom slug.
- Clients should be able to expire / delete previous URLs.
    - I'm going to skip delete because that'd require log-in or authorization of some sort.
- Users should be able to open the URL and get redirected.

Project Requirements:

- The project should include an automated test suite.
- The project should include a README file with instructions for running the web service and its tests. You should also use the README to provide context on choices made during development.
- The project should be packaged as a zip file or submitted via a hosted git platform (Github, Gitlab, etc).

rails g model link full_url:string slug:string
# URL Backend

## Set Up
`bundle install` 
`rake db:create && rake db:migrate`
Download Redis from brew if you don't have it already.
`brew services start redis`

## Tests
`spec/requests/links_request_spec.rb`
I created only the tests that were necessary to make sure my code worked. With no front-end, this was my way of testing.

## Choices
- The directions specified that you should be able to delete or expire files. I decided to go with expire to save time on coding, as deleting would require log-in or authorization token of some sort. I set a default of 30 days, if one wasn't specified
- I used Redis for the expiration. I also used it for actually retrieving the URLs, because it's faster and auto implements the expiration. 
	> I kept the information in the database as well, because having data == money. If that's not the case in this situation, I had implemented the validations etc in the db.
- My research said the best way to shorten URLs was using Base62, so that's what I did when the slug isn't specified.
- I thought about validating URLs, but it didn't seem like a good use of time. Theoretically, `espn.com` isn't a valid URL, however the browser will still redirect you correctly. 
- Not knowing what the front-end would do, I put in basic JSON responses that should allow the front-end to display any useful data.
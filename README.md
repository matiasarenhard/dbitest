# Setup
   ```
  git clone git@github.com:matiasarenhard/dbitest.git
 cd dbitest
 bundle install
 rake db:create
 rake db:migrate
```
# Create User
run `rails c` and if want create user with this api_key run :
```
  User.create(name: "user", api_key: "slSuiDLWgHxdnSVQdzW8kwtt")
```
or if you want generate new api_key run :
```
  User.create(name: 'user', api_key: SecureRandom.base64.tr('+/=', 'Qrt'))
```
# Test
1 - exit of rails console using `exit` and then run :
```
rails s
```
2 - go your postman and set `get request` using this url:
```
 http://localhost:3000/api/v1/quotes/index?token=slSuiDLWgHxdnSVQdzW8kwtt&tag=tea
 ```
Url Configs :
```
 token: your Token
 tag: you can pass more tags using `,` example: `tag=tea,books`.
 http://localhost:3000/api/v1/quotes/index?token=slSuiDLWgHxdnSVQdzW8kwtt&tag=tea,books
 ```

# snow_trails

## Architecture

The core of **SnowTrails** is the `App` entity who starts the app and manage the dependencies used round the project.

```
let app = App()
app.run()
```
Inside `App` I initialize a `MenuController` and its dependencies like `LoginController` that requires a `LoginService` and a `UserDataLoader`.

I have **controllers** to interact whit the user, these controllers uses **services** to manage domain logic and comunicate with the **data loaders**. All of them are _clases_.

## Sequence diagram

At the moment the diagram includes the **Login** flow, ignore the override them entities I wanted to put them somewhere.
![](Images/snow_trails_sequence.png)

## Obligatory functionality

✅ Login Menu

I coded he Login flow using a `LoginController`, a `LoginService`, a `UserDataLoader` and a `user.json` file to host two default users: regular and admin. Throw a delegate called `LoginControllerDelegate` that implement the `MenuController` I close the login menu to start the corresponding user one. Previously I provided feedback to the user for a login sucess. Finally I configured **testing** to add a Login suite.

😮‍💨 Problems everywhere

When I was programming the Logout functionality, I figured out that the app's flow **had a problem**: When the user closed their session and tried to login/logout again, the **menu was broken**. The main problem as [@tecosabri](https://github.com/tecosabri) said, was that there was no more code to execute since the last option selected by the user in Login menu was `.Quit`, so the app's flow was terminated every time we open for a second time that controller. 

The first thing I realized was I needed to reset the data of `LoginController` before evaluating again. I applied this solution:  [7e8e576](https://github.com/anagumo/snow_trails/commit/7e8e5765e2f052c47239cb5469f57562f379acad) and [c79dc70](https://github.com/anagumo/snow_trails/commit/c79dc708c8cbed3ef1b2acc6ff014309ffabd3a6) for `RegularUserController` too, and it worked. Also, I attached the validation to the user sesion insted to the selected option to have better control over the app's flow.

| Issue | Fix |
|--------|------|
| <img src="Images/flow_issue.png" width="300"/>  | <img src="Images/flow_fixed.png" width="250"/> |


## Complementary functionality

✅ Login Menu
I coded an option to get the user role using a `UserType`, this enum is created when the `users.json` file is decoded to a `User` entity:

```
enum UserType: String, Codable {
    case regular
    case admin
    
    // It was great create an enum from a JSON response :P
    init?(from decoder: Decoder?) throws {
        let container = try decoder?.singleValueContainer()
        let userRole = try container?.decode(String.self)
        
        switch userRole {
        case UserType.regular.rawValue:
            self = .regular
        case UserType.admin.rawValue:
            self = .admin
        default:
            return nil
        }
    }
}
```
Also I manage the `getUser` response using an `onSuccess` and `onError` closure. Finally the feedback when the login is success includes if is a **regular** or **admin** user.

Continue...
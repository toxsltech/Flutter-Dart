# Flutter Code Base

The main objective of this project is to demonstrate the basic use of Flutter with MVC architecture.

## How to Use

**Step 1:**

Download or clone this repository.

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:
```
flutter pub get
```


## Build With flutter

for android

```
flutter build apk release
```

for ios

```
flutter build ios --release

```


#### MVC Architecture

 - `Model`[data]
 - `View` [ui]
 - `Controller`[logic & operation]

#### Flow of The App

 - `Binding` [It binds the Controller, Provider and Repository in self to observe changes]
 - `GetMaterialAPP` [GetMaterialController]
 - `Controller` [Invoke API]
 - `Repository` [Fired and return response or error]
 - `Provider` [Set data in model]
 - `Controller` [update dependencies]

#### Http Response Codes Summary

    200: OK. Everything worked as expected.
    201: A resource was successfully created in response to a POST request. The Location header contains the URL pointing to the newly created resource.
    204: The request was handled successfully and the response contains no body content (like a DELETE request).
    304: The resource was not modified. You can use the cached version.
    400: Bad request. This could be caused by various actions by the user, such as providing invalid JSON data in the request body, providing invalid action parameters, etc.
    401: Authentication failed.
    403: The authenticated user is not allowed to access the specified API endpoint.
    404: The requested resource does not exist.
    405: Method not allowed. Please check the Allow header for the allowed HTTP methods.
    415: Unsupported media type. The requested content type or version number is invalid.
    422: Data validation failed (in response to a POST request, for example). Please check the response body for detailed error messages.
    429: Too many requests. The request was rejected due to rate limiting.
    500: Internal server error. This could be caused by internal program errors.

## Authors

```
  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
  All Rights Reserved.
  Proprietary and confidential :  All information contained herein is, and remains
  the property of ToXSL Technologies Pvt. Ltd. and its partners.
  Unauthorized copying of this file, via any medium is strictly prohibited.
```
[![Build Status](https://travis-ci.org/surfstudio/CoreEvents.svg?branch=master)](https://travis-ci.org/surfstudio/CoreEvents)
[![codebeat badge](https://codebeat.co/badges/4ced5e8d-8d44-4111-81df-0fb2012cbbb1)](https://codebeat.co/projects/github-com-surfstudio-coreevents-master)
[![codecov](https://codecov.io/gh/surfstudio/CoreEvents/branch/master/graph/badge.svg)](https://codecov.io/gh/surfstudio/CoreEvents/branch/master/graph/badge.svg)

# CoreEvents
Small Swift events kit that provides some base types of events:
- [`FutureEvent`](#futureevent)
- [`PresentEvent`](#presentevent)
- [`PastEvent`](#pastevent)

## FutureEvent

Simple event. 
Provides classic behaviour.

### Description

This is classic event (like C# `event`) that can contains many listners and multicast each new message for this listners.
This event emit **only** new messages. It means that if you add new listner to existed event this event doesn't emit previous messages to new listner.

### Types
- `FutureEvent: Event`

### Example

```swift
var event = FutureEvent<Int>()

event += { value in
  print("Awesome int: \(value)")
}

event.invoke(with: 42)

```

will print `Awesome int: 42`

## PresentEvent

### Description

This event provide all `Future` logic, but additionally provide emits last emited value for new listner.
It means if your event already emits value and you add new listener then yout listener handles previous emited value in the same time.

### Types
- `PresentEvent: Event`

### Example

```swift
var event = PresentEvent<Int>()

event += { value in
  print("Awesome int: \(value)")
}

event.invoke(with: 42)

event += {
    print("Old awesome int: \(value)")
}

```

will print:

`Awesome int: 42`

`Old awesome int: 42`

## PastEvent

### Description

This event like Present, but emits all previous messages for new listner

### Types

- `PastEvent: Event`

### Example

```swift
var event = PastEvent<Int>()

event.invoke(with: 0)
event.invoke(with: 1)

event += { value in
  print("Awesome int: \(value)")
}

event.invoke(with: 2)

```

Will print:

`Awesome int: 0`

`Awesome int: 1`
 
`Awesome int: 2`

## How to install

`pod 'CoreEvents', '~> 2.0.0'`

## Warning 

In one file you can not use just `add`, you chould specify a key - `add(key: String, _ listener: Closure)`

## Versioning

Version format is `x.y.z` where
- x is major version number. Bumped only in major updates (implementaion changes, adding new functionality)
- y is minor version number. Bumped only in minor updates (interface changes)
- z is minor version number. Bumped in case of bug fixes and e.t.c.

## Author

[Kravchenkov Alexander](https://github.com/LastSprint)

[MIT License](https://github.com/surfstudio/CoreEvents/blob/master/LICENSE)

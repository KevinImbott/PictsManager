PICTSMANAGER:
====================

## Useful links
---

WEBSITE: http://pictsmanager.v6.rocks/

Pannel admin: http://54.36.191.51:3000/admin/

Swagger: http://54.36.191.51:3000/api-docs


## Environnement
---
```
RUBY: 3.1.1

Rails: 7.0.2.3

Flutter: 3.0.4
```

## Getting Started
---

You just have to install docker
```
https://docs.docker.com/desktop/windows/install/
```

Install flutter dependencies:
```
flutter pub get
```

Run project:
```
sh ./start.sh
```

To start emulator see [this page](https://tutorial.tips/create-android-emulator-for-flutter/)

## Others:
---

Launch Tests:

```
docker exec -it api rspec ./spec
```

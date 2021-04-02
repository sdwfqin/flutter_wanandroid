# flutter_wanandroid

玩Android-Flutter版

TODO: 开发中～

# 注意⚠️

### 对象序列化生成Dart代码

```
flutter packages pub run build_runner build
```

### 空安全
> Cannot run with sound null safety because dependencies don't support null safety

https://stackoverflow.com/questions/64917744/cannot-run-with-sound-null-safety-because-dependencies-dont-support-null-safety

1. Debug运行

```
Run --> Edit Configurations --> Add Additional Run args --> --no-sound-null-safety
or
flutter run --no-sound-null-safety
```

2. 打包

```
flutter build apk --no-sound-null-safety
```

# 截图

| ![](./screenshot/home_light.jpg)  | ![](./screenshot/me_light.jpg) | ![](./screenshot/login_light.jpg) |
|  ----  | ----  | ----  |
| ![](./screenshot/home_dark.jpg)  | ![](./screenshot/me_dark.jpg) | ![](./screenshot/login_dark.jpg) |

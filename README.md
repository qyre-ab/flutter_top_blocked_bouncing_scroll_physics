Flutter scroll-physics which behaves like `BouncingScrollPhysics`,
except doesn't let you to over-scroll on top.

## Usage

If you want over-scroll on bottom only when the content is longer than
max scroll extent, use `TopBlockedBouncingScrollPhysics`:

```dart
return ListView(
  physics: const TopBlockedBouncingScrollPhysics(),
);
```

If you always want over-scroll on the bottom, use `AlwaysScrollableScrollPhysics`
with `TopBlockedBouncingScrollPhysics` as a parent:

```dart
return ListView(
  physics: const AlwaysScrollableScrollPhysics(
    parent: TopBlockedBouncingScrollPhysics(),
  ),
);
```

## Demo

![](https://github.com/qyre-ab/flutter_top_blocked_bouncing_scroll_physics/raw/main/media/preview.gif)
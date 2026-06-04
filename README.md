# Houxuan & Linsan Travel Memory Site

个人旅行相册网站，主题是“我们去过的地方”。网站包含首页视觉、旅行地图、地点相册、照片预览，以及基于 Supabase 的共享照片/描述编辑能力。

线上地址：

- https://selfwebsite.pages.dev/

## 当前版本说明

这个版本重点优化了 Codrops 风格滚动照片区的加载和运行时体验：

- 为滚动动效单独生成 `picture/codrops-thumbs/` 缩略图。
- Codrops 滚动区使用缩略图，49 张滚动图从原图约 `157MB` 降到约 `7.78MB`。
- 原始高清照片仍保留在 `picture/`，相册和大图预览继续使用原图。
- 滚动照片不再逐帧执行 blur、brightness、contrast 等 filter 动画，改用轻量 opacity 遮罩保留暗入暗出的观感。
- 桌面端 Lenis 平滑滚动调得更跟手，触屏设备和 reduced motion 场景使用原生滚动。
- 地图、相册结构、Supabase 共享编辑功能保持不变。

## 已解决的问题

- 解决了滚动照片区使用原始大图导致的加载慢、照片迟迟显示不出来的问题。
- 线上滚动区现在加载的是轻量缩略图，首屏和滚动照片出现速度比之前明显改善。
- 降低了 Codrops 滚动动效的运行时成本，解决了逐帧 filter 导致的操作迟钝和滚动偏重问题。

## 仍然存在的限制

这个版本已经移除了最重的滚动 filter 动画，但 Codrops 区仍然是比较丰富的视觉动效。

如果低性能设备仍有压力，主要剩余成本来自：

- 多个 ScrollTrigger 动画在滚动时持续 scrub。
- 滚动照片包含 3D transform、skew、scale 等逐帧变化。

下一步优化方向：

- 减少每张照片单独绑定 ScrollTrigger 的数量。
- 为移动端提供更轻量的动效版本。

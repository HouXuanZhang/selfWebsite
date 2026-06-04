# Houxuan & Linsan Travel Memory Site

个人旅行相册网站，主题是“我们去过的地方”。网站包含首页视觉、旅行地图、地点相册、照片预览，以及基于 Supabase 的共享照片/描述编辑能力。

线上地址：

- https://selfwebsite.pages.dev/

## 当前版本说明

这个版本重点优化了 Codrops 风格滚动照片区的加载体验：

- 为滚动动效单独生成 `picture/codrops-thumbs/` 缩略图。
- Codrops 滚动区使用缩略图，49 张滚动图从原图约 `157MB` 降到约 `7.78MB`。
- 原始高清照片仍保留在 `picture/`，相册和大图预览继续使用原图。
- 地图、相册结构、Supabase 共享编辑功能保持不变。

## 已解决的问题

- 解决了滚动照片区使用原始大图导致的加载慢、照片迟迟显示不出来的问题。
- 线上滚动区现在加载的是轻量缩略图，首屏和滚动照片出现速度比之前明显改善。

## 仍然存在的限制

这个版本还没有完全解决“动效本身重”的问题。

原因是 Codrops 原动效仍然保留了较高的运行时成本：

- 多个 ScrollTrigger 动画在滚动时持续 scrub。
- 滚动照片包含 3D transform、skew、scale 等逐帧变化。
- 照片层仍有 blur、brightness、contrast 等 filter 动画，这类效果比普通 transform 更容易造成滚动卡顿。
- Lenis 平滑滚动会持续驱动 requestAnimationFrame，低性能设备上会更明显。

下一步优化方向：

- 保留整体视觉，但降低或移除滚动照片上的 filter 动画。
- 减少每张照片单独绑定 ScrollTrigger 的数量。
- 为移动端提供更轻量的动效版本。

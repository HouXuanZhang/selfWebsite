// Initializes smooth scrolling with Lenis and integrates it with GSAP's ScrollTrigger.
// Function to set up smooth scrolling.
const initSmoothScrolling = () => {
  if (!window.Lenis || !window.ScrollTrigger || !window.gsap) return;

  const shouldUseNativeScroll = window.matchMedia('(prefers-reduced-motion: reduce), (hover: none), (pointer: coarse)').matches;
  if (shouldUseNativeScroll) {
    ScrollTrigger.update();
    return;
  }

  // Initialize Lenis for smooth scroll effects. Lerp value controls the smoothness.
  const lenis = new Lenis({ lerp: 0.22 });
  
  // Sync ScrollTrigger with Lenis' scroll updates.
  lenis.on('scroll', ScrollTrigger.update);
  
  // Ensure GSAP animations are in sync with Lenis' scroll frame updates.
  gsap.ticker.add(time => {
      lenis.raf(time * 1000); // Convert GSAP's time to milliseconds for Lenis.
  });
  
  // Turn off GSAP's default lag smoothing to avoid conflicts with Lenis.
  gsap.ticker.lagSmoothing(0);
};

// Activate the smooth scrolling feature.
initSmoothScrolling();

/**
 * metaball_utils.wasm.js
 * ----------------------
 * WASM loader for metaball particle precomputation.
 * Fetches metaball_utils.wasm and exposes MetaballUtils global.
 *
 * Exports global: MetaballUtils
 *   await MetaballUtils.load()
 *   MetaballUtils.fillParticles(t, duration, dMax, n,
 *                               startRadius, endRadius, power, evo)
 *     → Float32Array of length n*4  (x, y, mbRadius, distRatio per particle)
 *
 * WASM source: metaball_utils.wat
 * Imports required: Math.sin, Math.cos, Math.floor
 */
(function (global) {
  const MetaballUtils = {
    _instance: null,
    _memory: null,

    async load(wasmUrl) {
      if (this._instance) return this;
      const url = wasmUrl || "./metaball_utils.wasm";
      const { instance } = await WebAssembly.instantiateStreaming(fetch(url), {
        Math: { sin: Math.sin, cos: Math.cos, floor: Math.floor }
      });
      this._instance = instance.exports;
      this._memory   = instance.exports.memory;
      return this;
    },

    /**
     * Precompute n particle positions/radii for the current frame.
     * Returns a *copied* Float32Array of length n*4:
     *   [i*4+0] x
     *   [i*4+1] y
     *   [i*4+2] mbRadius
     *   [i*4+3] distRatio
     */
    fillParticles(t, duration, dMax, n, startRadius, endRadius, power, evo) {
      const PTR = 0;
      this._instance.fill_particles(
        PTR, t, duration, dMax, n, startRadius, endRadius, power, evo
      );
      const raw = new Float32Array(this._memory.buffer, PTR, n * 4);
      return new Float32Array(raw); // copy — safe across frames
    },
  };

  global.MetaballUtils = MetaballUtils;
})(typeof globalThis !== 'undefined' ? globalThis : window);

# mika-wasm-shader

用 Rust/C++ 编写计算逻辑（如噪声函数、SDF等）→ 编译为 WASM

在 Three.js 中，WASM 在 CPU 侧运行（生成纹理数据/Uniform参数）

GLSL 着色器在 GPU 侧运行，读取 WASM 输出的数据进行渲染


<div id="vis-container"><svg viewBox="0 0 760 220" xmlns="http://www.w3.org/2000/svg" style="width:100%;font-family:var(--font-mono)">
  <defs>
    <marker id="arr" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="#888780"></path>
    </marker>
  <mask id="imagine-text-gaps-v69zq8" maskUnits="userSpaceOnUse"><rect x="0" y="0" width="760" height="220" fill="white"></rect><rect x="28.857257843017578" y="88.33244323730469" width="92.2854995727539" height="19.834458351135254" fill="black" rx="2"></rect><rect x="28.96446990966797" y="106.38806915283203" width="92.07107543945312" height="18.778827667236328" fill="black" rx="2"></rect><rect x="47.00914764404297" y="122.38807678222656" width="55.98170852661133" height="18.778827667236328" fill="black" rx="2"></rect><rect x="54.497528076171875" y="49.443695068359375" width="41.004947662353516" height="16.667566299438477" fill="black" rx="2"></rect><rect x="126.90823364257812" y="91.49933624267578" width="62.183536529541016" height="15.611936569213867" fill="black" rx="2"></rect><rect x="135.93882751464844" y="113.49932861328125" width="44.12236022949219" height="15.611936569213867" fill="black" rx="2"></rect><rect x="187.42868041992188" y="88.33244323730469" width="109.1426010131836" height="19.834458351135254" fill="black" rx="2"></rect><rect x="173.02098083496094" y="106.38806915283203" width="137.95802307128906" height="18.778827667236328" fill="black" rx="2"></rect><rect x="179.07435607910156" y="122.38807678222656" width="125.85125732421875" height="18.778827667236328" fill="black" rx="2"></rect><rect x="215.99668884277344" y="49.443695068359375" width="52.00659942626953" height="16.667566299438477" fill="black" rx="2"></rect><rect x="299.9286193847656" y="91.49933624267578" width="50.14274978637695" height="15.611936569213867" fill="black" rx="2"></rect><rect x="287.8960876464844" y="106.49932861328125" width="74.20783233642578" height="15.611936569213867" fill="black" rx="2"></rect><rect x="367.071533203125" y="85.33244323730469" width="83.85694885253906" height="19.834458351135254" fill="black" rx="2"></rect><rect x="346.07440185546875" y="103.38806915283203" width="125.85125732421875" height="18.778827667236328" fill="black" rx="2"></rect><rect x="349.6866149902344" y="119.38806915283203" width="118.62678527832031" height="18.778836250305176" fill="black" rx="2"></rect><rect x="349.8268127441406" y="49.443695068359375" width="118.34638214111328" height="16.844324111938477" fill="black" rx="2"></rect><rect x="460.9082946777344" y="91.49933624267578" width="62.183536529541016" height="15.611936569213867" fill="black" rx="2"></rect><rect x="466.92864990234375" y="106.49932861328125" width="50.14274978637695" height="15.611936569213867" fill="black" rx="2"></rect><rect x="525.6430053710938" y="85.33244323730469" width="100.71405029296875" height="19.834458351135254" fill="black" rx="2"></rect><rect x="521.4534301757812" y="103.38806915283203" width="109.09312438964844" height="18.778827667236328" fill="black" rx="2"></rect><rect x="510.625" y="119.38806915283203" width="130.75003814697266" height="18.778836250305176" fill="black" rx="2"></rect><rect x="553.2543334960938" y="49.443695068359375" width="45.49137878417969" height="16.667566299438477" fill="black" rx="2"></rect><rect x="684.7144165039062" y="91.33244323730469" width="58.5713005065918" height="19.834458351135254" fill="black" rx="2"></rect><rect x="686.0092163085938" y="109.38806915283203" width="55.98170852661133" height="18.778827667236328" fill="black" rx="2"></rect><rect x="693.49755859375" y="49.443695068359375" width="41.004947662353516" height="16.667566299438477" fill="black" rx="2"></rect><rect x="34.88589859008789" y="158.4993438720703" width="80.22822570800781" height="15.648436546325684" fill="black" rx="2"></rect><rect x="195.865478515625" y="158.4993438720703" width="92.26901245117188" height="15.611936569213867" fill="black" rx="2"></rect><rect x="341.8023681640625" y="158.4993438720703" width="134.395263671875" height="15.611936569213867" fill="black" rx="2"></rect><rect x="553.9388427734375" y="158.4993438720703" width="44.12236022949219" height="15.611936569213867" fill="black" rx="2"></rect></mask></defs>

  <!-- Box 1: Rust/C++ -->
  <g class="c-coral">
    <rect x="10" y="70" width="130" height="80" rx="6"></rect>
    <text x="75" y="103" text-anchor="middle" font-size="13" font-weight="500" class="t">Rust / C++</text>
    <text x="75" y="120" text-anchor="middle" font-size="11" class="ts">噪声/SDF/数学</text>
    <text x="75" y="136" text-anchor="middle" font-size="11" class="ts">计算逻辑</text>
  </g>
  <text x="75" y="62" text-anchor="middle" font-size="11" style="fill:var(--color-text-secondary)">源码层</text>

  <!-- Arrow 1 -->
  <line x1="142" y1="110" x2="175" y2="110" stroke="#888780" stroke-width="1.5" marker-end="url(#arr)" mask="url(#imagine-text-gaps-v69zq8)"></line>
  <text x="158" y="103" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">wasm-pack</text>
  <text x="158" y="125" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">/ emcc</text>

  <!-- Box 2: WASM -->
  <g class="c-purple">
    <rect x="177" y="70" width="130" height="80" rx="6"></rect>
    <text x="242" y="103" text-anchor="middle" font-size="13" font-weight="500" class="t">.wasm Module</text>
    <text x="242" y="120" text-anchor="middle" font-size="11" class="ts">exports: compute()</text>
    <text x="242" y="136" text-anchor="middle" font-size="11" class="ts">返回 Float32Array</text>
  </g>
  <text x="242" y="62" text-anchor="middle" font-size="11" style="fill:var(--color-text-secondary)">编译产物</text>

  <!-- Arrow 2 -->
  <line x1="309" y1="110" x2="342" y2="110" stroke="#888780" stroke-width="1.5" marker-end="url(#arr)" mask="url(#imagine-text-gaps-v69zq8)"></line>
  <text x="325" y="103" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">fetch /</text>
  <text x="325" y="118" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">instantiate</text>

  <!-- Box 3: JS Bridge -->
  <g class="c-amber">
    <rect x="344" y="70" width="130" height="80" rx="6"></rect>
    <text x="409" y="100" text-anchor="middle" font-size="13" font-weight="500" class="t">JS Bridge</text>
    <text x="409" y="117" text-anchor="middle" font-size="11" class="ts">调用 WASM exports</text>
    <text x="409" y="133" text-anchor="middle" font-size="11" class="ts">写入 DataTexture</text>
  </g>
  <text x="409" y="62" text-anchor="middle" font-size="11" style="fill:var(--color-text-secondary)">CPU 侧 · Three.js</text>

  <!-- Arrow 3 -->
  <line x1="476" y1="110" x2="509" y2="110" stroke="#888780" stroke-width="1.5" marker-end="url(#arr)" mask="url(#imagine-text-gaps-v69zq8)"></line>
  <text x="492" y="103" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">uniform /</text>
  <text x="492" y="118" text-anchor="middle" font-size="10" style="fill:var(--color-text-secondary)">texture</text>

  <!-- Box 4: GLSL -->
  <g class="c-teal">
    <rect x="511" y="70" width="130" height="80" rx="6"></rect>
    <text x="576" y="100" text-anchor="middle" font-size="13" font-weight="500" class="t">GLSL Shader</text>
    <text x="576" y="117" text-anchor="middle" font-size="11" class="ts">ShaderMaterial</text>
    <text x="576" y="133" text-anchor="middle" font-size="11" class="ts">vertex + fragment</text>
  </g>
  <text x="576" y="62" text-anchor="middle" font-size="11" style="fill:var(--color-text-secondary)">GPU 侧</text>

  <!-- Arrow 4 -->
  <line x1="643" y1="110" x2="676" y2="110" stroke="#888780" stroke-width="1.5" marker-end="url(#arr)"></line>

  <!-- Box 5: Render -->
  <g class="c-blue">
    <rect x="678" y="70" width="72" height="80" rx="6"></rect>
    <text x="714" y="106" text-anchor="middle" font-size="13" font-weight="500" class="t">Canvas</text>
    <text x="714" y="123" text-anchor="middle" font-size="11" class="ts">渲染输出</text>
  </g>
  <text x="714" y="62" text-anchor="middle" font-size="11" style="fill:var(--color-text-secondary)">输出层</text>

  <!-- Bottom labels -->
  <text x="75" y="170" text-anchor="middle" font-size="10" style="fill:var(--color-text-tertiary)">wasm-bindgen</text>
  <text x="242" y="170" text-anchor="middle" font-size="10" style="fill:var(--color-text-tertiary)">memory: linear</text>
  <text x="409" y="170" text-anchor="middle" font-size="10" style="fill:var(--color-text-tertiary)">DataTexture / uniform</text>
  <text x="576" y="170" text-anchor="middle" font-size="10" style="fill:var(--color-text-tertiary)">WebGL2</text>
</svg>
</div>

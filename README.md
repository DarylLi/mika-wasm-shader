# mika-wasm-shader

用 Rust/C++ 编写计算逻辑（如噪声函数、SDF等）→ 编译为 WASM

在 Three.js 中，WASM 在 CPU 侧运行（生成纹理数据/Uniform参数）

GLSL 着色器在 GPU 侧运行，读取 WASM 输出的数据进行渲染


| 阶段 | 组件 | 说明 |
|------|------|------|
| 源码层 | Rust / C++ | 噪声/SDF/数学计算逻辑 |
| 编译产物 | .wasm Module | memory: linear |
| CPU 侧 | JS Bridge | DataTexture / uniform |
| GPU 侧 | GLSL Shader | WebGL2 |
| 输出层 | Canvas | 渲染输出 |

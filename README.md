# mika-wasm-shader

## threejs中的GLSL是否可以拆分一部分出来（如噪声函数、SDF等）通过wasm进行逻辑优化

## 可行性分析：

### WASM 侧（CPU）做什么

fbm 分形布朗运动：多倍频叠加 value noise
fill_texture：逐像素写入线性内存，返回给 JS 的 Uint8Array
每帧（或定时）以新的 seed 重新生成，驱动动态变化

### GLSL 侧（GPU）做什么

uNoiseTex uniform 接收 WASM 产生的 DataTexture
域变形（Domain Warping）：用噪声纹理扭曲采样坐标，产生流体感
SDF 模式：噪声驱动圆形边界变形 + fresnel 高光
Plasma 模式：noise 调制波函数相位


## 核心思路：

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

- **Shader 示例地址**: [Shadertoy - MddGWN](https://www.shadertoy.com/view/MddGWN)

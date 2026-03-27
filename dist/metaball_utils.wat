(module
  (import "Math" "sin"   (func $js_sin   (param f32) (result f32)))
  (import "Math" "cos"   (func $js_cos   (param f32) (result f32)))
  (import "Math" "floor" (func $js_floor (param f32) (result f32)))

  (memory (export "memory") 1)

  ;; fract(x) = x - floor(x)
  (func $fract (param $x f32) (result f32)
    (f32.sub
      (local.get $x)
      (call $js_floor (local.get $x))
    )
  )

  ;; mix(a, b, t) = a + (b - a) * t
  (func $mix (param $a f32) (param $b f32) (param $t f32) (result f32)
    (f32.add
      (local.get $a)
      (f32.mul
        (f32.sub (local.get $b) (local.get $a))
        (local.get $t)
      )
    )
  )

  ;; fill_particles(ptr, t, duration, dMax, n, startRadius, endRadius, power, evo)
  ;; Writes n particles into memory at ptr, each particle is 4 x f32 (16 bytes):
  ;;   [0] x
  ;;   [4] y
  ;;   [8] mbRadius
  ;;  [12] distRatio
  (func (export "fill_particles")
    (param $ptr         i32)
    (param $t           f32)
    (param $duration    f32)
    (param $dMax        f32)
    (param $n           i32)
    (param $startRadius f32)
    (param $endRadius   f32)
    (param $power       f32)
    (param $evo         f32)

    (local $i         i32)
    (local $fi        f32)
    (local $fn        f32)
    (local $d         f32)
    (local $a         f32)
    (local $x         f32)
    (local $y         f32)
    (local $distRatio f32)
    (local $mbRadius  f32)
    (local $offset    i32)

    (local.set $fn (f32.convert_i32_s (local.get $n)))
    (local.set $i  (i32.const 0))

    (block $break
      (loop $loop
        (br_if $break (i32.ge_s (local.get $i) (local.get $n)))

        (local.set $fi (f32.convert_i32_s (local.get $i)))

        ;; d = fract(t * power + 48934.4238 * sin(floor(fi / evo) * 692.7398))
        (local.set $d
          (call $fract
            (f32.add
              (f32.mul (local.get $t) (local.get $power))
              (f32.mul
                (f32.const 48934.4238)
                (call $js_sin
                  (f32.mul
                    (call $js_floor
                      (f32.div (local.get $fi) (local.get $evo))
                    )
                    (f32.const 692.7398)
                  )
                )
              )
            )
          )
        )

        ;; a = 6.28318 * fi / n
        (local.set $a
          (f32.div
            (f32.mul (f32.const 6.28318) (local.get $fi))
            (local.get $fn)
          )
        )

        ;; x = d * cos(a) * duration
        (local.set $x
          (f32.mul
            (f32.mul (local.get $d) (call $js_cos (local.get $a)))
            (local.get $duration)
          )
        )

        ;; y = d * sin(a) * duration
        (local.set $y
          (f32.mul
            (f32.mul (local.get $d) (call $js_sin (local.get $a)))
            (local.get $duration)
          )
        )

        ;; distRatio = d / dMax
        (local.set $distRatio
          (f32.div (local.get $d) (local.get $dMax))
        )

        ;; mbRadius = mix(startRadius, endRadius, distRatio)
        (local.set $mbRadius
          (call $mix
            (local.get $startRadius)
            (local.get $endRadius)
            (local.get $distRatio)
          )
        )

        ;; offset = ptr + i * 16
        (local.set $offset
          (i32.add
            (local.get $ptr)
            (i32.mul (local.get $i) (i32.const 16))
          )
        )

        ;; store x, y, mbRadius, distRatio as f32
        (f32.store (local.get $offset)                           (local.get $x))
        (f32.store (i32.add (local.get $offset) (i32.const 4))  (local.get $y))
        (f32.store (i32.add (local.get $offset) (i32.const 8))  (local.get $mbRadius))
        (f32.store (i32.add (local.get $offset) (i32.const 12)) (local.get $distRatio))

        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop)
      )
    )
  )
)

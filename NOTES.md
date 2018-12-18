# WebGL Fundamentals
From the [Web GL fundamentals site](https://webglfundamentals.org/webgl/lessons/webgl-fundamentals.html), and [Book of Shaders](https://thebookofshaders.com)

## What is WebGL?
* WebGL is a rasterization engine which runs on the GPU of your computer
* You provide code directly to the GPU in the form of pairs of functions
  1. A vertex shader, which computes vertex positions to rasterize shapdes
  2. a fragment shader to compute the color for each pixel
* For anything youw ant to draw, you set up a bunch of state then execute a pair of functions by calling `gl.drawArrays` or `gl.drawElements`, which executes your shaders on the gpu

## What is a Shader?
* A shader is a set of instructions, executed simultaneously for every pixel on the screen
* There are four ways a shader can receive data
  1. Attributes and Buffers
    * Buffers are arrays of binary data, which contain things like positions, normals (a line or vector that is perpendicular to a given object), texture coordinates, vertext colors.
    * Attributes are used to specify how you pull data out of buffers and provide them to your shaders. Normally these tend to be instructions on where in the buffer information should be extracted (i.e. what position)
    * Buffers are not random access
  2. Uniforms - Global variables you set before you execute your shader (same for every pixel on the screen)
  3. Textures
    * Arrays of data you can randomly access
    * Mostly used to contain image/color data
  4. Varyings
    * A way for a vertex shader to pass data to a fragment shader
* One difficulty of shaders has to do with the notion of parallel processing
  * Each thread (pixel) is blind (unaware of the state of its siblings) and memoryless (unaware of its previous state)

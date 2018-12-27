<template>
  <div class="code-block">
      <pre><code class="language-glsl" :contenteditable="isEditable" @keyup.esc="blur" v-on:blur="onChangeCodeBlock" v-html="$options.filters.highlight(code, 'glsl')"/></pre>
  </div>
</template>

<script>
import Vue from 'vue'
import Prism from 'prismjs'

Prism.languages.glsl = Prism.languages.extend('clike', { comment: [/\/\*[\s\S]*?\*\//, /\/\/(?:\\(?:\r\n|[\s\S])|[^\\\r\n])*/], number: /(?:\b0x[\da-f]+|(?:\b\d+\.?\d*|\B\.\d+)(?:e[+-]?\d+)?)[ulf]*/i, keyword: /\b(?:attribute|const|uniform|varying|buffer|shared|coherent|volatile|restrict|readonly|writeonly|atomic_uint|layout|centroid|flat|smooth|noperspective|patch|sample|break|continue|do|for|while|switch|case|default|if|else|subroutine|in|out|inout|float|double|int|void|bool|true|false|invariant|precise|discard|return|d?mat[234](?:x[234])?|[ibdu]?vec[234]|uint|lowp|mediump|highp|precision|[iu]?sampler[123]D|[iu]?samplerCube|sampler[12]DShadow|samplerCubeShadow|[iu]?sampler[12]DArray|sampler[12]DArrayShadow|[iu]?sampler2DRect|sampler2DRectShadow|[iu]?samplerBuffer|[iu]?sampler2DMS(?:Array)?|[iu]?samplerCubeArray|samplerCubeArrayShadow|[iu]?image[123]D|[iu]?image2DRect|[iu]?imageCube|[iu]?imageBuffer|[iu]?image[12]DArray|[iu]?imageCubeArray|[iu]?image2DMS(?:Array)?|struct|common|partition|active|asm|class|union|enum|typedef|template|this|resource|goto|inline|noinline|public|static|extern|external|interface|long|short|half|fixed|unsigned|superp|input|output|hvec[234]|fvec[234]|sampler3DRect|filter|sizeof|cast|namespace|using)\b/ }), Prism.languages.insertBefore('glsl', 'comment', { preprocessor: { pattern: /(^[ \t]*)#(?:(?:define|undef|if|ifdef|ifndef|else|elif|endif|error|pragma|extension|version|line)\b)?/m, lookbehind: !0, alias: 'builtin' } })

// Highlight some code
Vue.filter('highlight', (code, lang = 'glsl') => {
  return Prism.highlight(code, Prism.languages[lang], lang)
})

export default {
  name: 'CodeBlock',
  props: ['code', 'isEditable', 'onChange'],
  methods: {
    blur: function (event) {
      event.target.blur()
    },
    onChangeCodeBlock: function (event) {
      this.onChange && this.onChange(event.target.outerText)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

.code-block {
  margin: 16px;
  padding: 16px 16px;
  text-align: left;
  background: rgba(0,0,0,0.05);
}
code {
   white-space: pre;
}

code:focus {
  outline: none;
}

code[class*="language-"],
 pre[class*="language-"] {
   color: black;
   background: none;
   text-shadow: 0 1px white;
   font-family: Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
   text-align: left;
   white-space: pre-wrap;
   word-spacing: normal;
   word-break: normal;
   word-wrap: normal;
   line-height: 1.5;

   -moz-tab-size: 4;
   -o-tab-size: 4;
   tab-size: 4;

   -webkit-hyphens: none;
   -moz-hyphens: none;
   -ms-hyphens: none;
   hyphens: none;
 }

 pre[class*="language-"]::-moz-selection, pre[class*="language-"] ::-moz-selection,
 code[class*="language-"]::-moz-selection, code[class*="language-"] ::-moz-selection {
   text-shadow: none;
   background: #b3d4fc;
 }

 pre[class*="language-"]::selection, pre[class*="language-"] ::selection,
 code[class*="language-"]::selection, code[class*="language-"] ::selection {
   text-shadow: none;
   background: #b3d4fc;
 }

 @media print {
   code[class*="language-"],
   pre[class*="language-"] {
     text-shadow: none;
   }
 }

 /* Code blocks */
 pre[class*="language-"] {
   padding: 1em;
   margin: .5em 0;
   overflow: auto;
 }

 :not(pre) > code[class*="language-"],
 pre[class*="language-"] {
   background: #f5f2f0;
 }

 /* Inline code */
 :not(pre) > code[class*="language-"] {
   padding: .1em;
   border-radius: .3em;
   white-space: normal;
 }

 .token.comment,
 .token.prolog,
 .token.doctype,
 .token.cdata {
   color: slategray;
 }

 .token.punctuation {
   color: #999;
 }

 .namespace {
   opacity: .7;
 }

 .token.property,
 .token.tag,
 .token.boolean,
 .token.number,
 .token.constant,
 .token.symbol,
 .token.deleted {
   color: #905;
 }

 .token.selector,
 .token.attr-name,
 .token.string,
 .token.char,
 .token.builtin,
 .token.inserted {
   color: #690;
 }

 .token.operator,
 .token.entity,
 .token.url,
 .language-css .token.string,
 .style .token.string {
   color: #9a6e3a;
   background: hsla(0, 0%, 100%, .5);
 }

 .token.atrule,
 .token.attr-value,
 .token.keyword {
   color: #07a;
 }

 .token.function,
 .token.class-name {
   color: #DD4A68;
 }

 .token.regex,
 .token.important,
 .token.variable {
   color: #e90;
 }

 .token.important,
 .token.bold {
   font-weight: bold;
 }
 .token.italic {
   font-style: italic;
 }

 .token.entity {
   cursor: help;
 }

</style>

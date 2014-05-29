require({
  paths: {
    'scribe': './bower_components/scribe/scribe',
    'scribe-plugin-blockquote-command': './bower_components/scribe-plugin-blockquote-command/scribe-plugin-blockquote-command',
    'scribe-plugin-curly-quotes': './bower_components/scribe-plugin-curly-quotes/scribe-plugin-curly-quotes',
    'scribe-plugin-formatter-plain-text-convert-new-lines-to-html': './bower_components/scribe-plugin-formatter-plain-text-convert-new-lines-to-html/scribe-plugin-formatter-plain-text-convert-new-lines-to-html',
    'scribe-plugin-heading-command': './bower_components/scribe-plugin-heading-command/scribe-plugin-heading-command',
    'scribe-plugin-intelligent-unlink-command': './bower_components/scribe-plugin-intelligent-unlink-command/scribe-plugin-intelligent-unlink-command',
    'scribe-plugin-sanitizer': './bower_components/scribe-plugin-sanitizer/scribe-plugin-sanitizer',
    'scribe-plugin-smart-lists': './bower_components/scribe-plugin-smart-lists/scribe-plugin-smart-lists'
  }
}, [
  'scribe',
  'scribe-plugin-blockquote-command',
  'scribe-plugin-curly-quotes',
  'scribe-plugin-formatter-plain-text-convert-new-lines-to-html',
  'scribe-plugin-heading-command',
  'scribe-plugin-intelligent-unlink-command',
  'scribe-plugin-sanitizer',
  'scribe-plugin-smart-lists'
], function (
  Scribe,
  scribePluginBlockquoteCommand,
  scribePluginCurlyQuotes,
  scribePluginFormatterPlainTextConvertNewLinesToHtml,
  scribePluginHeadingCommand,
  scribePluginIntelligentUnlinkCommand,
  scribePluginSanitizer,
  scribePluginSmartLists
) {

  'use strict';

  var scribe = new Scribe(document.querySelector('.scribe'), { allowBlockElements: true });

//  scribe.on('content-changed', updateHTML);
//
//  function updateHTML() {
//    document.querySelector('.scribe-html').value = scribe.getHTML();
//  }

  /**
   * Plugins
   */

  scribe.use(scribePluginBlockquoteCommand());
  scribe.use(scribePluginHeadingCommand(2));
  scribe.use(scribePluginIntelligentUnlinkCommand());
  scribe.use(scribePluginSmartLists());
  scribe.use(scribePluginCurlyQuotes());

  // Formatters
  scribe.use(scribePluginSanitizer({
    tags: {
      p: {},
      br: {},
      b: {},
      strong: {},
      i: {},
      strike: {},
      blockquote: {},
      ol: {},
      ul: {},
      li: {},
      a: { href: true },
      h2: {}
    }
  }));
  scribe.use(scribePluginFormatterPlainTextConvertNewLinesToHtml());
});

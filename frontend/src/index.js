require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./index.html');

const Elm = require('./Main.elm');

const mountNode = document.getElementById('main');

Elm.Main.embed(mountNode);

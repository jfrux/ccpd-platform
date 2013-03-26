'use strict';


//
// Require some modules
//


var fs      = require('fs');
var path    = require('path');
var jade    = require('jade');
var express = require('express');
var app = express();
var Mincer  = require('mincer');


//
// Get Mincer environment
//


var environment = require('./environment');


//
// Create connect application
//



//
// Attach assets server
//
var vJavascripts;
var vStylesheets;

try {
  vJavascripts = "!=javascript_include_tag('application.js')";
  vJavascripts = jade.compile(vJavascripts);
} catch (err) {
  console.error("Failed compile view: " + (err.message || err.toString()));
  process.exit(128);
}

try {
  vStylesheets = "!=stylesheet_link_tag('application.css')";
  vStylesheets = jade.compile(vStylesheets);
} catch (err) {
  console.error("Failed compile view: " + (err.message || err.toString()));
  process.exit(128);
}


app.use('/assets/', Mincer.createServer(environment));


var viewHelpers = {};


// dummy helper that injects extension
function rewrite_extension(source, ext) {
  var source_ext = path.extname(source);
  return (source_ext === ext) ? source : (source + ext);
}


// returns a list of asset paths
function find_asset_paths(logicalPath, ext) {
  var asset = environment.findAsset(logicalPath),
      paths = [];

  if (!asset) {
    return null;
  }

  if ('production' !== process.env.NODE_ENV && asset.isCompiled) {
    asset.toArray().forEach(function (dep) {
      paths.push('/assets/' + rewrite_extension(dep.logicalPath, ext) + '?body=1');
    });
  } else {
    paths.push('/assets/' + rewrite_extension(asset.digestPath, ext));
  }

  return paths;
}


viewHelpers.javascript_include_tag = function javascript(logicalPath) {
  var paths = find_asset_paths(logicalPath, '.js');

  if (!paths) {
    // this will help us notify that given logicalPath is not found
    // without "breaking" view renderer
    return '<script type="application/javascript">alert("Javascript file ' +
           JSON.stringify(logicalPath).replace(/"/g, '\\"') +
           ' not found.")</script>';
  }

  return paths.map(function (path) {
    return '<script type="application/javascript" src="' + path + '"></script>';
  }).join('\n');
};


viewHelpers.stylesheet_link_tag = function stylesheet(logicalPath) {
  var paths = find_asset_paths(logicalPath, '.css');

  if (!paths) {
    // this will help us notify that given logicalPath is not found
    // without "breaking" view renderer
    return '<script type="application/javascript">alert("Stylesheet file ' +
           JSON.stringify(logicalPath).replace(/"/g, '\\"') +
           ' not found.")</script>';
  }

  return paths.map(function (path) {
    return '<link rel="stylesheet" type="text/css" href="' + path + '" />';
  }).join('\n');
};



//
// Attach some dummy handler, that simply renders layout
//
// app.get('/stylesheet_tags/',function (req, res) {
//   environment.precompile(['application.css'], function (err) {
//     if (err) {
//       next(err);
//       return;
//     }

//     res.end(vStylesheets(viewHelpers));
//   });
// }

// app.get('/javascript_tags/',function (req, res) {
//   environment.precompile(['application.js','vendor.js'], function (err) {
//     if (err) {
//       next(err);
//       return;
//     }

//     res.end(vJavascripts(viewHelpers));
//   });
// }

// app.use(function (req, res, next) {
//   // make sure our assets were compiled, so their `digestPath`
//   // will be 100% correct, otherwise first request will produce
//   // wrong digestPath. That's not a big deal, as assets will be
//   // served anyway, but to keep everything correct, we use this
//   // precompilation, which is similar to using manifest, but
//   // without writing files on disk.
//   //
//   // See [[Base#precompile]] for details,
//   environment.precompile(['application.js', 'application.css', 'vendors.js'], function (err) {
//     if (err) {
//       next(err);
//       return;
//     }

//     res.end(view(viewHelpers));
//   });
// });


//
// Start listening
//


app.listen(3000, function (err) {
  if (err) {
    console.error("Failed start server: " + (err.message || err.toString()));
    process.exit(128);
  }

  console.info('Listening on localhost:3000');
});

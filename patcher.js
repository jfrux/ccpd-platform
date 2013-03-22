var walk    = require('walk');
var csv = require("fast-csv");
var async = require('async');
var mkdirp = require("mkdirp");
var path = require("path");
var fs = require("fs");
var files   = [];
var walker  = walk.walk('./_com', { followLinks: false });

var tables = [];

get_table_names = function(callback) {
  var cb = callback;
  csv("ccpd_table_synonyms.csv", { headers: true})
   .on("data", function(data){
      tables.push(data);
   })
   .on("end", function(){
    cb(null, 'one');
   })
   .parse();;
}

get_files_list = function(callback) {
  var cb = callback;
  walker.on('file', function(root, stat, next) {
      // Add this file to the list of files
      files.push(root + '/' + stat.name);
      next();
  });

  walker.on('end', function() {
    cb(null, 'two');
  });
}

loop_files = function(callback) {
  var cb = callback;
  async.each(files, process_file, function(err){
    //cb();
      // if any of the saves produced an error, err would equal that error
  });
}

process_file = function(file) {
  var theFile = file;
  fs.readFile(theFile, 'utf8', function (err,data) {
    var theData = data;
    if (err) {
      return console.log(err);
    }

    async.eachSeries(tables,function(table,callback) {
      var cb = callback;
      var regEx = new RegExp(table.old_name, "ig");
      var result = theData.replace(regEx, table.new_name);
      var fileDir = path.dirname(theFile);
      var fileDir = path.resolve('/home/joshua/Projects','ccpd-platform',fileDir);
      var fileDir = fileDir.replace('_com/','_com_new/');
      //console.log(fileDir);
      var filePath = path.resolve(fileDir,path.basename(theFile));
      console.log("table: " + table.old_name + ' - ' + table.new_name);
      console.log("new file: " + filePath);
      mkdirp(fileDir, function (err) {
        fs.writeFile(filePath, result, 'utf8',function() {
          cb(null);
        });
      });
      
    },function(err) {
      console.log(err);
    })
  });
}



async.series([
  get_table_names,
  get_files_list,
  loop_files
]);
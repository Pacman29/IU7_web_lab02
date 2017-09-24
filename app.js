var express = require('express');
var path = require('path');
var fs = require('fs');
var bodyParser = require('body-parser');
var app = express();

app.use(express.static(path.join(__dirname,'public')));
app.set('views', __dirname + '/public/templates');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');

app.use(bodyParser.json());

app.get('/',function (req,res) {
    res.sendFile(__dirname+'/public/templates/hack.txt');
});

app.get('/hack', function (req,res) {
    res.render('index')
});

app.post('/tofile', function (req,res) {
    let pathtofile = __dirname+'/public/file/test.txt';

    fs.writeFile(pathtofile,req.body, (err) => {
        if (err) throw err;
    });

    res.send("file created");
});

app.get('/getfile', function (req,res) {
    res.sendFile(__dirname+'/public/file/test.txt');
});

app.set('port', (process.env.PORT || 8080));
app.listen(app.get('port'), function() {
    console.log('server on ' + app.get('port'));
});
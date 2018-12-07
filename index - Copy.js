const express = require("express");
const rscript = require("r-script");
const cookieParser = require("cookie-parser");
 const app  = express();
const path = require("path");
const bodyParser = require('body-parser');


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/assets/css', express.static('views/assets/css'));
app.use('/assets/images', express.static('views/assets/images'));
app.use('/assets/fonts', express.static('views/assets/fonts'));
app.use('/assets/js', express.static('views/assets/js'));

app.get('/', (req,res)=>{
    res.render('dashboard', {page:'Home', menuId:'home'});
 }) 


app.post('/',(req,res)=>{

var hashtag = req.body.todo;

var FetchTweets = require('fetch-tweets');
  var apiKeys = {
    consumer_key : 'Fj8yUEjD6o8a5GWFaJB5rUM6T',
    consumer_secret : 'FI0S8MWF7NutgNa98jbOUTTb7dfpQXLI9mN6tiBy4YPyxsFkoG'
  };
    
    var fetchTweets = new FetchTweets(apiKeys); 

    fetchTweets.byTopic(hashtag, function(results){	
		var out = rscript("ex-sync - Copy.R")
        .data(results)
        .callSync();
       
        res.render('dashboard',{page:'Home', menuId:'home',feedback : out});

     });
});

app.listen(3000, ()=>{
	
     console.log("server running...");
 });


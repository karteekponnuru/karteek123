//dependencies
const express = require("express");
const rscript = require("r-script");
const cookieParser = require("cookie-parser");
const app  = express();
const path = require("path");
const bodyParser = require('body-parser');
const sentimental = require('Sentimental');
const fs = require('fs');
var test = 0;
var search_hashtag = '';
var arr = 0;
var arr1 = 0;


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

//Default page
app.get('/', (req,res)=>{
  res.render('index', {page:'Home', menuId:'home'});
}); 

//Default page
app.get('/test', (req,res)=>{
  res.render('search', {page:'Home', menuId:'home'});
}); 


//on pressing login
app.get('/login', (req,res) =>{
  res.render('login', {page:'Home', menuId:'home'});
});

//on pressing login
app.get('/pricing', (req,res) =>{
  res.render('pricing', {page:'Home', menuId:'home'});
});

//on pressing login
app.get('/signup', (req,res) =>{
  res.render('search', {page:'Home', menuId:'home'});
});

app.get('/back', (req, res) =>{
  res.render('search', {page:'Home', menuId:'home'});
});



app.post('/logincred',(req,res)=>{
  var username = req.body.doto;
  var pwd = req.body.doto1;
  if((username == "ramalingakarteek@gmail.com") && (pwd == "test@123")){
    res.render('search', {page:'Home', menuId:'home'});
  }else{
    res.render('search', {page:'Home', menuId:'home'});
  }
});


//Connect with Twitter, R , Text classifier API
app.post('/home',(req,res)=>{
  var hashtag = req.body.todo;
  search_hashtag = hashtag;
  var tweetcount = 100;
  var Twit = require('twit')
  var score = 0;
 
  var T = new Twit({
    consumer_key:         '1wjtMrEze2zwFQmupP56GPAsG',
    consumer_secret:      'kNQ1eKBRZK7bzg1j0CVyzBd8lzxXcIOrVhYmzoJRBHwTOXGRMI',
    access_token:         '2524611181-R4KLFbsa7ZcVcbc1kgGkq6VTkILGYiCPv9fpvi3',
    access_token_secret:  'mBHEDyi5ujkvhIbe7riThrErDmm11OlMQ4jEA07yScGZP',
    timeout_ms:           60*1000,  // optional HTTP request timeout to apply to all requests.
    strictSSL:            true,     // optional - requires SSL certificates to be valid.
  })

  //Fetch Tweets
  T.get('search/tweets', { q: hashtag, count: tweetcount}, function(err, data, response) { 
      var out = rscript("new1.R")
      .data(data.statuses, data.search_metadata)
      .callSync();

      let rawdata = fs.readFileSync('C:/Users/vidyush.bakshi/Desktop/data/tweet_count.json');  
      let student = JSON.parse(rawdata);  
      
      var data1 = [];
      data1[0] = student[0].total_tweets;
      data1[1] = student[0].total_retweets;
      data1[2] = student[0].engagement_level;
      data1[3] = student[0].total_fav;
      data1[4] = student[0].fav_per;
      data1[5] = student[0].pos;
      data1[6] = student[0].neu;
      data1[7] = student[0].neg;
      data1[8] = search_hashtag;
      test = data1;

      let rawdata1 = fs.readFileSync('C:/Users/vidyush.bakshi/Desktop/data/overall_data.json');  
      let student1 = JSON.parse(rawdata1); 

      var totalMessages = Object.keys(student1).length;
           
      let array = new Array(totalMessages);   
      for(let i = 0; i < totalMessages; i++) {
        array[i] = new Array(); 
        
      }

      for(let a = 0;a<totalMessages;a++){       
          array[a][0]=student1[a].Date_full;
          array[a][1]=student1[a].text;
          array[a][2]=student1[a].retweet_count;
          array[a][3]=student1[a].user_name;
          array[a][4]=student1[a].fav_count;
          array[a][5]=student1[a].user_location;
          array[a][6]=student1[a].Score;
      }
      arr = array;


      let rawdata2 = fs.readFileSync('C:/Users/vidyush.bakshi/Desktop/data/tweet_count_datewise.json');  
      let student2 = JSON.parse(rawdata2); 

      var totalMessages1 = Object.keys(student2).length;
           
      let array1 = new Array(totalMessages1);   
      for(let i = 0; i < totalMessages1; i++) {
        array1[i] = new Array();         
      }

      for(let a = 0;a<totalMessages1;a++){       
          array1[a][0]=student2[a].V1;
          array1[a][1]=student2[a].V2;
          array1[a][2]=student2[a].V3;
          array1[a][3]=student2[a].V4;
          array1[a][4]=student2[a].V5;
          array1[a][5]=student2[a].V6;
          array1[a][6]=student2[a].V7;
          array1[a][7]=student2[a].V8;
          array1[a][8]=student2[a].V9;
          array1[a][9]=student2[a].V10;
          array1[a][10]=student2[a].V11;
          array1[a][11]=student2[a].V12;
      }
      arr1 = array1;

      res.render('dashboard',{page:'Home', menuId:'home',feedback : test, feedb : arr, feedb1: arr1});
  })
});

//GO to dashboard
app.get('/dashboard', (req, res)=>{
  res.render('dashboard',{page:'Home', menuId:'home',feedback : test, feedb : arr, feedb1: arr1});
});

//View Sentiments rab
app.get('/sentiment',(req,res)=>{
  res.render('sentiment',{page:'Home', menuId:'home',feedback1 : test[5], feedback2 :test[6], feedback3: test[7], feedback4: test[8], feedb: arr, feedb1: arr1});
});

//Is the server connected or not
app.listen(3000, ()=>{	
     console.log("server running...");
 });

 
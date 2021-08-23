function quest_86983_features () {
    let actionAnims = {};
    let scrollTriggersFired = [];
    let fireScrollOffTriggers = [];
    let questVars = {};
  let actualInput = null;let actualCheckbox = null;
    let checkDiv = null;
  
        document.getElementById("R-side").addEventListener("click",function () {
          
     document.getElementById("menu").style.visibility = "visible";
    
        });
      
        document.getElementById("cancel-btn").addEventListener("click",function () {
          
     document.getElementById("menu").style.visibility = "hidden";
    
        });
      
        document.getElementById("signup-button").addEventListener("mouseenter",function () {
          
        questVars["prevColor_" + "86983_7" + "_" + "86983_3"] = getComputedStyle(document.getElementById("signup-button")).backgroundColor;
      
      document.getElementById("signup-button").style.backgroundColor = "rgba(197, 224, 178, 1)";
    
        });
      
        document.getElementById("signup-button").addEventListener("mouseleave",function () {
          
          document.getElementById("signup-button").style.backgroundColor =  questVars["prevColor_" + "86983_7" + "_" + "86983_3"];
      
        });
      
        document.getElementById("signup-button-1").addEventListener("mouseenter",function () {
          
        questVars["prevColor_" + "86983_8" + "_" + "86983_4"] = getComputedStyle(document.getElementById("signup-button-1")).backgroundColor;
      
      document.getElementById("signup-button-1").style.backgroundColor = "rgba(197, 224, 178, 1)";
    
        });
      
        document.getElementById("signup-button-1").addEventListener("mouseleave",function () {
          
          document.getElementById("signup-button-1").style.backgroundColor =  questVars["prevColor_" + "86983_8" + "_" + "86983_4"];
      
        });
      
        document.getElementById("signup-button-3").addEventListener("mouseenter",function () {
          
        questVars["prevColor_" + "86983_11" + "_" + "86983_5"] = getComputedStyle(document.getElementById("signup-button-3")).backgroundColor;
      
      document.getElementById("signup-button-3").style.backgroundColor = "rgba(197, 224, 178, 1)";
    
        });
      
        document.getElementById("signup-button-3").addEventListener("mouseleave",function () {
          
          document.getElementById("signup-button-3").style.backgroundColor =  questVars["prevColor_" + "86983_11" + "_" + "86983_5"];
      
        });
      
        document.getElementById("signup-button-2").addEventListener("mouseenter",function () {
          
        questVars["prevColor_" + "86983_12" + "_" + "86983_6"] = getComputedStyle(document.getElementById("signup-button-2")).backgroundColor;
      
      document.getElementById("signup-button-2").style.backgroundColor = "rgba(197, 224, 178, 1)";
    
        });
      
        document.getElementById("signup-button-2").addEventListener("mouseleave",function () {
          
          document.getElementById("signup-button-2").style.backgroundColor =  questVars["prevColor_" + "86983_12" + "_" + "86983_6"];
      
        });
      
  };
  
      document.addEventListener("DOMContentLoaded", quest_86983_features);
    0
0

/////////////////////////
// Hotkeys definitions //
/////////////////////////

;(function(){
    //
    var special_keys =  {
			8: "backspace", 9: "tab", 10: "return", 13: "return", 16: "shift", 17: "ctrl", 18: "alt", 19: "pause",
			20: "capslock", 27: "esc", 32: "space", 33: "pageup", 34: "pagedown", 35: "end", 36: "home",
			37: "left", 38: "up", 39: "right", 40: "down", 45: "insert", 46: "del", 
			96: "0", 97: "1", 98: "2", 99: "3", 100: "4", 101: "5", 102: "6", 103: "7",
			104: "8", 105: "9", 106: "*", 107: "+", 109: "-", 110: ".", 111 : "/", 
			112: "f1", 113: "f2", 114: "f3", 115: "f4", 116: "f5", 117: "f6", 118: "f7", 119: "f8", 
			120: "f9", 121: "f10", 122: "f11", 123: "f12", 144: "numlock", 145: "scroll", 186: ";", 191: "/",
			220: "\\", 222: "'", 224: "meta"
		};

    //
    var base_action = "Annotatit:Event";
    //codes to call 
    // keycode:event to launch
    var alt_action = "create";
    var ctrl_action = "startSection";
    var esc_action = "reset";
    var action_note = "Note";
    var action_mplayer = "MediaPlayerFacade";
    var key_number = {
                    "48": "0", "96": "0", //0
                    "49": "1", "97": "1", //1
                    "50": "2", "98": "2", //2
                    "51": "3", "99": "3", //3
                    "52": "4", "100": "4", //4
                    "53": "5", "101": "5", //5
                    "54": "6", "102": "6", //6
                    "55": "7", "103": "7", //7
                    "56": "8", "104": "8", //8
                    "57": "9", "105": "9" //9
                };
    
    var keyHandler = function(event){
        //check characters
        var action = false;
        var number = false;
        var numberSet = false;
        var special = false;
        if(event.keyCode in key_number){
            number = key_number[event.keyCode];
            numberSet = true;
        }
        if(event.keyCode in special_keys){
            special = special_keys[event.keyCode];
        }
        
        if(special ==="esc"){
            //ESC == cancel current note
            action = base_action+":"+action_note+":"+esc_action;
        }else if ( event.metaKey  && special === "space" || event.ctrlKey && special === "space" ){
            //ctrl+space = togglePlay
             action = base_action+":"+action_mplayer+":togglePlay";
        }else if (event.metaKey && numberSet || event.ctrlKey && numberSet ){
            //ctrl+NUMBER = startsection
            action = base_action+":"+action_note+":"+ctrl_action;
        }else if (event.altKey && numberSet){
            //ALT+NUMBER == create point note
            action = base_action+":"+action_note+":"+alt_action;
        }
        
        
        //event.stopPropagation();
        //launch event now
        if(action){
            //console.log("Launching Event:");
            //console.log(action);
            //console.log(number);
            if ( event.metaKey || event.ctrlKey || event.altKey ){
                event.preventDefault();
            }
            if(numberSet){
                jQuery.event.trigger(action, {"color":number});
            }else{
                jQuery.event.trigger(action, {"color":number});
            }
        }
        //TODO relaunch the event
        //jQuery.event.trigger(event);
    };
    
    $(document).on("keypress keydown", keyHandler);
})();

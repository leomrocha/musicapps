package
{
	import __AS3__.vec.Vector;
        import flash.display.Sprite;
        import flash.events.*;
        import flash.text.*;
        import flash.display.Shape;

        //import flash.utils.*;
	/**
	* A mapper between the frequency and the note,
	* also gives the error in Hz and cents
	*/
	public class NoteMapper extends Sprite
	{
            private const NOTES:Vector.<String> = new <String>[ 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", 
                "C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", 
                "A", "A#/Bb", "B", "C", "C#/Db", "D", "D#/Eb", "E", "F", 
                "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B", "C", "C#/Db", "D", 
                "D#/Eb"
                ];

            private const FREQS:Vector.<Number> = new <Number>[
                16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 
                27.50, 29.14, 30.87, 32.70, 34.65, 36.71, 38.89, 41.20, 43.65, 
                46.25, 49.00, 51.91, 55.00, 58.27, 61.74, 65.41, 69.30, 73.42, 
                77.78, 82.41, 87.31, 92.50, 98.00, 103.83, 110.00, 116.54, 123.47, 
                130.81, 138.59, 146.83, 155.56, 164.81, 174.61, 185.00, 196.00, 207.65, 
                220.00, 233.08, 246.94, 261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 
                369.99, 392.00, 415.30, 440.00, 466.16, 493.88, 523.25, 554.37, 587.33, 
                622.25, 659.26, 698.46, 739.99, 783.99, 830.61, 880.00, 932.33, 987.77, 
                1046.50, 1108.73, 1174.66, 1244.51, 1318.51, 1396.91, 1479.98, 1567.98, 1661.22, 
                1760.00, 1864.66, 1975.53, 2093.00, 2217.46, 2349.32, 2489.02, 2637.02, 2793.83, 
                2959.96, 3135.96, 3322.44, 3520.00, 3729.31, 3951.07, 4186.01, 4434.92, 4698.64, 
                4978.03
                ];
            private const LEN_NOTES:uint = 100;
            
            //current state, working vars
            private var currNote:String = ""; //note, description name
            private var currPos:uint = 0; // position in the array of the note
            private var currErrorHz:Number = 0; // errors
            //private var currErrorPerc:Number;
            private var currErrorCents:Number;
            
            //current state text that will be shown in text to the user
            private var note:TextField; 
            private var octave:TextField; 
            private var error:TextField;
            private var errorHz:TextField;
            private var txtEhz:TextField;
            private var currF0:TextField;
            private var txtF0:TextField;            
            private var errorCents:TextField;
            private var txtCents:TextField;
            private var ok_light:Shape; // will display color according to the state of the tunning

            
            private var f0:Number;
            private var txtHz:TextField;

            public function NoteMapper()
            {
            
                note = new TextField();
                //note.width = 50;
                //note.height = 15;
                note.x = 10;
                note.y = 10;
                note.maxChars = 5;
                note.text = "None";
                addChild(note);

                octave = new TextField();
                octave.x = 50;
                octave.y = 10;
                octave.maxChars = 2;
                octave.text = "None";
                addChild(octave);

                currF0 = new TextField();
                //currF0.width = 200;
                //currF0.height = 15;
                currF0.x = 15;
                currF0.y = 45;
                currF0.maxChars = 5;
                currF0.text = "inf";
                addChild(currF0);

                txtHz = new TextField();
                txtHz.x = 60;
                txtHz.y = 45;
                txtHz.maxChars = 5;
                txtHz.text = "Hz";
                addChild(txtHz);

                error = new TextField();
                error.x = 60;
                error.y = 70;
                error.text = "Error";
                addChild(error);

                errorHz = new TextField();
                //errorHz.width = 200;
                //errorHz.height = 15;
                errorHz.x = 60;
                errorHz.y = 85;
                errorHz.maxChars = 4;
                errorHz.text = "inf";
                addChild(errorHz);

                txtEhz = new TextField();
                txtEhz.x = 90;
                txtEhz.y = 85;
                txtEhz.maxChars = 5;
                txtEhz.text = "Hz";
                addChild(txtEhz);                
                
                errorCents = new TextField();
                errorCents.width = 200;
                errorCents.height = 15;
                errorCents.x = 60;
                errorCents.y = 100;
                errorCents.maxChars = 4;
                errorCents.text = "inf";
                addChild(errorCents);

                txtCents = new TextField();
                txtCents.x = 90;
                txtCents.y = 100;
                txtCents.maxChars = 5;
                txtCents.text = "Cents";
                addChild(txtCents);
                
                //OK light
                ok_light = new Shape( ); 
                // starting color filling
                ok_light.graphics.beginFill( 0xff0000 , 1 );
                ok_light.graphics.drawCircle( 0 , 0 , 15 );
                ok_light.graphics.endFill( );
                // repositioning shape
                ok_light.x = 30;                                 
                ok_light.y = 100;
                // adding displayobject to the display list
                addChild( ok_light ); 
                
            }

            public function updateFreq( freq:Number):void
            {
                f0 = freq;
                var i:uint;
                var color:uint = 0xff0000;
                var oc:uint = 10;
                var prevError:Number = -1000000000.0;
                var currError:Number = 0.0;
                //look for the closest frequency
                for(i=1; i< LEN_NOTES; i++) // I don't really care for 16 hz, and so avoid problems
                {
                    currError = freq-FREQS[i];
                    //check if I already passed the point where I should be
                    if(Math.abs(currError) >Math.abs(prevError))
                    {
                        currNote = NOTES[i-1];
                        currPos = i-1;
                        currErrorHz = prevError;
                        //currErrorPerc = (prevError/FREQS[i-1] )*100;
                        currErrorCents = prevError/( (FREQS[i]-FREQS[i-1])/100);// 100s part of the range between notes .. this is a rough approximation, but anyway the error is way below human hearing sensitivity
                        break;
                    }

                    prevError = currError;
                }
            //update values 
            oc = LEN_NOTES/currPos;
            if (Math.abs(currErrorCents) > 10 && Math.abs(currErrorCents) < 15)
            {
                color = 0x931f00;
            }
            else if (Math.abs(currErrorCents) > 7 && Math.abs(currErrorCents) <= 10)
            {
                color = 0xff5511;
            }
            else if (Math.abs(currErrorCents) > 4 && Math.abs(currErrorCents) <= 7 )
            {
                color = 0xffdd00;
            }
            else if (Math.abs(currErrorCents) <= 4 )
            {
                color = 0x00ff00;
            }
            else 
            {
                color = 0xff0000;
            }
            //color update
            ok_light.graphics.beginFill( color , 1 );
            ok_light.graphics.drawCircle( 0 , 0 , 15 );
            ok_light.graphics.endFill( );
            //update the things for the user to see on screen
            note.text = currNote;
            octave.text = oc.toString();
            currF0.text = f0.toString().substr(0,6);
            errorHz.text= currErrorHz.toString().substr(0,4);
            errorCents.text = currErrorCents.toString().substr(0,4);
            }
                
                
	}
}
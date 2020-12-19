package capstone.dev.customkeyboard;

import android.content.ClipDescription;
import android.content.Context;
import android.inputmethodservice.InputMethodService;
import android.inputmethodservice.Keyboard;
import android.inputmethodservice.KeyboardView;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Build;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

//import com.bumptech.glide.Glide;
//import com.google.firebase.storage.FirebaseStorage;
import androidx.annotation.NonNull;
import androidx.annotation.RawRes;
import androidx.core.content.FileProvider;
import androidx.core.view.inputmethod.InputConnectionCompat;
import androidx.core.view.inputmethod.InputContentInfoCompat;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;

import static java.sql.DriverManager.println;


public class CustomKeyboard extends InputMethodService implements KeyboardView.OnKeyboardActionListener {

    //Keyboard variables
    private RelativeLayout kl;
    private KeyboardView kv;
    private LinearLayout iv;
//    private LinearLayout toolb;
    private Keyboard keyboard;
    private boolean isSymbolVisible = false;
    private boolean isImageViewVisible = false;
    private boolean isCaps = false;

    //ImageKeyboard Variables
    private static final String AUTHORITY = "com.capstone.customkeyboard.inputcontent";
    private static final String MIME_TYPE_PNG = "image/png";
    private String[] rawFiles;
    private boolean pngSupported;

//    private boolean imageButtonPressed = false;




    @Override
    public View onCreateInputView() {
        kl = (RelativeLayout) getLayoutInflater().inflate(R.layout.keyboard_layout_image, null);
        kv = kl.findViewById(R.id.keyboard_view);
        iv = kl.findViewById(R.id.images_view);


        final File imagesDir = new File(getFilesDir(), "images");
        imagesDir.mkdirs();
        LinearLayout ImageContainer = (LinearLayout) kl.findViewById(R.id.imageContainer);
//
        LinearLayout ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);

        for (int i = 0; i < rawFiles.length; i++) {
            System.out.println(i);
            if ((i % 2) == 0) {
                ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);
            }

            // Creating button
            ImageButton ImgButton = (ImageButton) getLayoutInflater().inflate(R.layout.image_button, ImageContainerColumn, false);
            ImgButton.setImageResource(getResources().getIdentifier(rawFiles[i], "raw", getPackageName()));
            ImgButton.setTag(rawFiles[i]);
            ImgButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    String emojiName = view.getTag().toString().replaceAll("_", "-");


                    //DEBUG
//                    String shakeel = "${view.getTag().toString()}.png";
//                    Log.i("test1", "value: " + R.raw.analyzeloop);
//                    final File file = getFileForResource(CustomKeyboard.this, R.raw.analyzeloop, imagesDir, "image.png");
//                    if (file == null)
//                    {
//                        Log.i("fileIs", "NULL!");
//
//                    }
//                    else{
//                        Log.i("fileIs", "NOT NULL!");
//                    }



                    final File file = getFileForResource(CustomKeyboard.this, getResources().getIdentifier(view.getTag().toString(), "raw", getPackageName()), imagesDir, "image.png");

                    CustomKeyboard.this.commitImage("A ${emojiName} logo", MIME_TYPE_PNG, file);
                }
            });



            ImageContainerColumn.addView(ImgButton);

            if ((i % 2) == 0) {
                ImageContainer.addView(ImageContainerColumn);
            }
        }

        this.isSymbolVisible = false;
        setMainView();
        return kl;

    }





    /**
     * Commits a PNG image
     *
     * @param mimeType
     * @param imageDescription Description of the PNG image to be sent
     */
    public void commitImage(String imageDescription, String mimeType,
                            File file)
    {

        //Content URI of the PNG image to be sent
        final Uri contentUri = FileProvider.getUriForFile(this, AUTHORITY, file);



        InputContentInfoCompat inputContentInfo = new InputContentInfoCompat(
                contentUri,
                new ClipDescription(imageDescription, new String[]{MIME_TYPE_PNG}),
                null
        );
        InputConnection inputConnection = getCurrentInputConnection();
        EditorInfo editorInfo = getCurrentInputEditorInfo();
        int flags = 0;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            flags |= InputConnectionCompat.INPUT_CONTENT_GRANT_READ_URI_PERMISSION;
        }
        InputConnectionCompat.commitContent(
                inputConnection, editorInfo, inputContentInfo, flags, null);
    }





    @Override
    public void onCreate() {
        super.onCreate();
        rawFiles = getAllRawResources();
    }

















    public void onKey(int i, int[] ints) {
        InputConnection ic = getCurrentInputConnection();
        playClick(i);

        switch (i)
        {

            //Symbols Key is set to KEYCODE_ALT [-6]
            case Keyboard.KEYCODE_ALT:
                if(this.isSymbolVisible)
                    this.setMainView();
                else{
                    this.setSymbolView();
                }
                break;

            case Keyboard.KEYCODE_DELETE:
                 ic.deleteSurroundingText(1,0);
                break;

            case Keyboard.KEYCODE_SHIFT:
                isCaps = !isCaps;
                keyboard.setShifted(isCaps);

                kv.invalidateAllKeys();
                break;




            //Emoji Key is set to KEYCODE_MODE_CHANGE [-2]
            //Section to implement Emoji button
            case Keyboard.KEYCODE_MODE_CHANGE:
                changeToImageView();  //Call function to show image view
                break;



            case Keyboard.KEYCODE_DONE:
                ic.sendKeyEvent(new KeyEvent (KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_ENTER));
                break;
            default:
                char code = (char)i;
                if(Character.isLetter(code) && isCaps)
                    code = Character.toUpperCase(code);
                ic.commitText(String.valueOf(code), 1);




        }
    }










    /*
    Symbols Layout View

     */
    private void setSymbolView(){
        keyboard = new Keyboard(this, R.xml.symbols);
        kv.setKeyboard(keyboard);
        kv.setOnKeyboardActionListener(this);
        this.isSymbolVisible = true;
    }

    /*
  Qwerty layout view

   */
    private void setMainView(){
        keyboard = new Keyboard(this, R.xml.qwerty);
        kv.setKeyboard(keyboard);
        kv.setOnKeyboardActionListener(this);
        this.isSymbolVisible = false;
    }


//    public void showKeys()
//    {
//
//        Button button = (Button) findViewById(R.id.return_to_keys);
//        button.setOnClickListener(new View.OnClickListener() {
//            public void onClick(View v) {
//                // Do something in response to button click
//            }
//        });
//    }



    /** Called when return button is pressed on image view
     * This is tied to the keyboard_layout_image which is where this function is called. Kinda
     * it is not called by anything within this file
     * */
    public void showKeys(View view) {
        // Do something in response to button click
        kv.setVisibility(View.VISIBLE);
        iv.setVisibility(View.GONE);
    }



    /*
    Image View Function
   TODO: implement Emoji/sticker upload function
    */
    private void changeToImageView()
    {
        kv.setVisibility(View.GONE);
        iv.setVisibility(View.VISIBLE);
    }




    private static File getFileForResource(
            @NonNull Context context, @RawRes int res, @NonNull File outputDir,
            @NonNull String filename) {
        final File outputFile = new File(outputDir, filename);
        final byte[] buffer = new byte[4096];
        InputStream resourceReader = null;
        try {
            try {
                resourceReader = context.getResources().openRawResource(res);
                OutputStream dataWriter = null;
                try {
                    dataWriter = new FileOutputStream(outputFile);
                    while (true) {
                        final int numRead = resourceReader.read(buffer);
                        if (numRead <= 0) {
                            break;
                        }
                        dataWriter.write(buffer, 0, numRead);
                    }
                    return outputFile;
                } finally {
                    if (dataWriter != null) {
                        dataWriter.flush();
                        dataWriter.close();
                    }
                }
            } finally {
                if (resourceReader != null) {
                    resourceReader.close();
                }
            }
        }

        catch (IOException e)
        {
            return null;
        }
    }




    /**
     * Gets all resources names from the raw folder
     * @return String []
     */
    private String[] getAllRawResources() {
        Field fields[] = R.raw.class.getDeclaredFields() ;
        String[] names = new String[fields.length] ;

        try {
            for( int i=0; i< fields.length; i++ ) {
                Field f = fields[i] ;
                names[i] = f.getName();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return names ;
    }







    private void playClick(int i) {

        AudioManager am = (AudioManager)getSystemService(AUDIO_SERVICE);
        switch(i)
        {
            case 32:
                am.playSoundEffect(AudioManager.FX_KEYPRESS_SPACEBAR);
                break;
            case Keyboard.KEYCODE_DONE:
            case 10:
                am.playSoundEffect(AudioManager.FX_KEYPRESS_DELETE);
                break;
            default: am.playSoundEffect(AudioManager.FX_KEYPRESS_STANDARD);
        }
    }






    @Override
    public void onPress(int primaryCode) {

    }

    @Override
    public void onRelease(int primaryCode) {

    }


    @Override
    public void onText(CharSequence text) {

    }

    @Override
    public void swipeLeft() {

    }

    @Override
    public void swipeRight() {

    }

    @Override
    public void swipeDown() {

    }

    @Override
    public void swipeUp() {

    }
}






//Emojibutton variables
//    FirebaseStorage firebaseStorage;
//    StorageReference storageReference;







//    @Override
//    public void onCreate() {
//        StorageReference mStorageRef;
//        mStorageRef = FirebaseStorage.getInstance().getReference();
//
//    }




//    @Override
//    public void onCreate(Bundle savedInstanceState)
//    {
////        dubBus = (ImageButton) findViewById(R.id.dubBus);
////        //dubBus.setOnClickListener(new View.OnClickListener() {public void onClick(View v){System.out.println("Dublin Bus");}});
////
////        View rootView = inflater.inflate(R.layout.fragment_buy, container, false);
////        return rootView;
//    }



//       super.onCreate();
//       kv.findViewById(R.id.)

//        File localFile = File.createTempFile("images", "jpg");
//        riversRef.getFile(localFile)
//                .addOnSuccessListener(new OnSuccessListener<FileDownloadTask.TaskSnapshot>() {
//                    @Override
//                    public void onSuccess(FileDownloadTask.TaskSnapshot taskSnapshot) {
//                        // Successfully downloaded data to local file
//                        // ...
//                    }
//                }).addOnFailureListener(new OnFailureListener() {
//            @Override
//            public void onFailure(@NonNull Exception exception) {
//                // Handle failed download
//                // ...
//            }
//        });







// Create a reference with an initial file path and name
//        StorageReference pathReference = storageRef.child("images/stars.jpg");




//        // Reference to an image file in Cloud Storage
//        StorageReference storageReference = FirebaseStorage.getInstance().getReference();
//
//        // ImageView in your Activity
//        ImageView imageView = findViewById(R.id.imageView);
//
//        // Download directly from StorageReference using Glide
//        // (See MyAppGlideModule for Loader registration)
//        Glide.with(this /* context */)
//                .load(storageReference)
//                .into(imageView);




//DEBUGGING CODE
//    @Override
//    public View onCreateInputView() {
//        kl = (RelativeLayout) getLayoutInflater().inflate(R.layout.keyboard_layout_image, null);
//        kv = kl.findViewById(R.id.keyboard_view);
//        iv = kl.findViewById(R.id.images_view);
////        toolb = kl.findViewById(R.id.toolbar);
////        toolb.setVisibility(View.VISIBLE);
//        Log.i("gggggg", "yeeeeee");
//
//
//        final File imagesDir = new File(getFilesDir(), "images");
//        LinearLayout ImageContainer = (LinearLayout) kl.findViewById(R.id.imageContainer);
////
//        LinearLayout ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);
//
//        for (int i = 0; i < rawFiles.length; i++) {
//            System.out.println(i);
//            if ((i % 2) == 0) {
//                ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);
//            }
//
//            // Creating button
//            ImageButton ImgButton = (ImageButton) getLayoutInflater().inflate(R.layout.image_button, ImageContainerColumn, false);
//            ImgButton.setImageResource(getResources().getIdentifier(rawFiles[i], "raw", getPackageName()));
//            ImgButton.setTag(rawFiles[i]);
//            ImgButton.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
//                    String emojiName = view.getTag().toString().replaceAll("_", "-");
//                    String shakeel = "${view.getTag().toString()}.png";
////
//                    Log.i("test1", "value: " + R.raw.analyzeloop);
//
//                    final File file = getFileForResource(CustomKeyboard.this, R.raw.analyzeloop, imagesDir, "image.png");
//                    CustomKeyboard.this.commitImage("A ${emojiName} logo", MIME_TYPE_PNG, file);
//                }
//            });
//
//
//
//            ImageContainerColumn.addView(ImgButton);
//
//            if ((i % 2) == 0) {
//                ImageContainer.addView(ImageContainerColumn);
//            }
//        }
//
//        this.isSymbolVisible = false;
//        setMainView();
//        return kl;
//
//    }
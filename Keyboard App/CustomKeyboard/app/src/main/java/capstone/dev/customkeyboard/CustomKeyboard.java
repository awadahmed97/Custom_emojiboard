package capstone.dev.customkeyboard;

import android.app.AppOpsManager;
import android.content.ClipDescription;
import android.content.Context;
import android.content.pm.PackageManager;
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
import android.view.inputmethod.InputBinding;
import android.view.inputmethod.InputConnection;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Toast;

//import com.bumptech.glide.Glide;
//import com.google.firebase.storage.FirebaseStorage;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RawRes;
import androidx.core.content.FileProvider;
import androidx.core.view.inputmethod.EditorInfoCompat;
import androidx.core.view.inputmethod.InputConnectionCompat;
import androidx.core.view.inputmethod.InputContentInfoCompat;

import com.bumptech.glide.Glide;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FileDownloadTask;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;


public class CustomKeyboard extends InputMethodService implements KeyboardView.OnKeyboardActionListener {

    //Keyboard variables
    private RelativeLayout KeyboardLayout;
    private KeyboardView keyboardView;
    private RelativeLayout ImageView;
    private Keyboard keyboard;
    private LinearLayout ImageContainer;
    private boolean isSymbolVisible = false;
    private boolean isImageViewVisible = false;
    private boolean isCaps = false;

    //ImageKeyboard Variables
    private static final String TAG = "ImageKeyboard";
    private static final String AUTHORITY = "capstone.dev.customkeyboard.inputcontent";
    private static final String MIME_TYPE_PNG = "image/png";
    private static final String MIME_TYPE_JPG = "image/jpg";

    private String[] rawFiles;
    private boolean pngSupported;

    ///////////////////////////////////////////////////////////////////////////////////////////////
    //****Firebase

    // Folder path for Firebase Storage.
    String Storage_Path = "All_Emoji_Uploads/";

    // Root Database Name for Firebase Database.
    public static final String Database_Path = "All_Emoji_Uploads_Database/";    //"All_Emoji_Uploads_Database";

    // Creating StorageReference and DatabaseReference object.
    StorageReference storageReference;
    DatabaseReference databaseReference;

    StorageReference myStorageRef;  //second storage reference for testing purposes

    // Creating URI.
    Uri FilePathUri;

    // Creating List of ImagesModel class.
    List<ImageModel> list = new ArrayList<>();

    //string variables to hold image name and url
    String imgUrl, imgName;

    File localFile;







    @Override
    public View onCreateInputView() {

        // Inflate main layout (KeyboardLayout) and children layouts under it
        KeyboardLayout = (RelativeLayout) getLayoutInflater().inflate(R.layout.keyboard_layout_image, null);
        keyboardView = KeyboardLayout.findViewById(R.id.keyboard_view);
        ImageView = KeyboardLayout.findViewById(R.id.images_view);
        ImageContainer = (LinearLayout) KeyboardLayout.findViewById(R.id.imageContainer);


        //
        final File imagesDir = new File(getFilesDir(), "images");
        imagesDir.mkdirs();


        // Assign FirebaseStorage instance to storageReference.
        storageReference = FirebaseStorage.getInstance().getReference();

        // Assign FirebaseDatabase instance with root database name.
        // Setting up Firebase image upload folder path in databaseReference.
        databaseReference = FirebaseDatabase.getInstance().getReference().child(Database_Path);


        // Create temp file to store image data from firebase
        try {
            localFile = File.createTempFile("images", "jpg");
        } catch (IOException e) {
            e.printStackTrace();
        }



        // Make Realtime Database connection.
        // Listen for changes in data at given database location (in Realtime Database)
        databaseReference.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot ) {
                // This method is called once with the initial value and again
                // whenever data at this location is updated.


                // Clear the image container layout and the array list before its repopulated to avoid duplicates.
                ImageContainer.removeAllViews();
                list.clear();
//                Log.i("gg1", Integer.toString(list.size()));



                //Get all objects in realtime database into ImagesModel class List
                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {

                    ImageModel imagesModel = postSnapshot.getValue(ImageModel.class);

                    list.add(imagesModel);  //List is an array of ImagesModel objects. contains names and url's of all objects in RT database

//                    Log.i("gg2", Integer.toString(list.size()));


                }


                // Inflate image container column layout
                LinearLayout ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);


//                Log.i("gg3", Integer.toString(list.size()));


                // For each ImagesModel object, get url's of images in firebase storage to display on image button using Glide method
                for (int i = 0; i < list.size(); i++)
                {
                    System.out.println(i);
                    if ((i % 2) == 0)    // Each image column contains 2 image button. Create a column after every 2 iterations
                    {
                        ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);
                    }

                    // Creating button
                    ImageButton ImgButton = (ImageButton) getLayoutInflater().inflate(R.layout.image_button, ImageContainerColumn, false);

                    // Get url of image from the realtime database. (URL points to actual image in Firebase Storage)
                    imgUrl = list.get(i).getUrl();


                    //Cast image into ImgButton view.
                    Glide.with(CustomKeyboard.this)
                            .load(imgUrl)
                            .into(ImgButton);




                    //Set image tag using image name
                    imgName = list.get(i).getName();
                    ImgButton.setTag(imgName);


                    //** Now Download actual image and commit as MIME type object

                    String secName = imgName;







//                    myStorageRef = storageReference.child("All_Emoji_Uploads/" + imgName);
                    //TODO: Using specific image in storage for now. Awaiting database creation from Flutter app
                    //TODO: When done, names of each specific image can be obtained in a
                    // loop using realtime database methods and ImagesModel class






//                    ImgButton.setImageResource(getResources().getIdentifier(rawFiles[i], "raw", getPackageName()));




                    // Callback to be called when image button is pressed. Download actual image here to pass to doCommitContent()
                    ImgButton.setOnClickListener(view -> {


                        //Second storage reference to hold full image location in the storage.
                        //      using specific name of image being viewed on image button
                        myStorageRef = storageReference.child("All_Emoji_Uploads/" + ImgButton.getTag());




                        String emojiName = view.getTag().toString().replaceAll("_", "-");
//
//                        file = getFileForResource(ImageKeyboard.this,
//                                getResources().getIdentifier(view.getTag().toString(), "raw", getPackageName()),
//                                imagesDir, "${view.getTag().toString()}.png");


                        // Put image into localFile. If successful, pass it over to doCommitContent()
                        myStorageRef.getFile(localFile).addOnSuccessListener(new OnSuccessListener<FileDownloadTask.TaskSnapshot>()
                        {
                            @Override
                            public void onSuccess(FileDownloadTask.TaskSnapshot taskSnapshot) {
                                // Local temp file has been created
//                                localFile = getFileForResource(ImageKeyboard.this,
//                                getResources().getIdentifier(view.getTag().toString(), null, null),
//                                imagesDir, "${view.getTag().toString()}.png");

                                // Pass Image file to doCommitContent()
                                CustomKeyboard.this.doCommitContent("A ${emojiName} logo", MIME_TYPE_PNG, localFile);

                            }
                        }).addOnFailureListener(new OnFailureListener() {
                            @Override
                            public void onFailure(@NonNull Exception exception) {
                                //TODO: Handle any errors if failure
                            }
                        });


//                        ImageKeyboard.this.doCommitContent("A ${emojiName} logo", MIME_TYPE_PNG, localFile);
                    });

                    // Add image to view
                    ImageContainerColumn.addView(ImgButton);

                    if ((i % 2) == 0) {
                        ImageContainer.addView(ImageContainerColumn);
                    }
                }

            }

            //TODO: Handle errors
            @Override
            public void onCancelled(DatabaseError error) {
                // Failed to read value
                Log.w(TAG, "Failed to read value.", error.toException());
            }
        });




        this.isSymbolVisible = false;
        setMainView();
        return KeyboardLayout;

    }














    @Override
    public void onCreate() {
        super.onCreate();
        rawFiles = getAllRawResources();


        //firebase storage reference initialization
//        mStorageRef = FirebaseStorage.getInstance().getReference();
    }





    @Override
    public void onStartInputView(EditorInfo info, boolean restarting) {
        pngSupported = isCommitContentSupported(info, MIME_TYPE_PNG);
        if(!pngSupported) {
            Toast.makeText(getApplicationContext(),
                    "Images not supported here. Please use standard keyboard.",
                    Toast.LENGTH_SHORT).show();
        }

        //TODO: Maybe instead of the above, let is input the
        // //URL or File path of the image selected into the text field
    }







    private boolean isCommitContentSupported(
            @Nullable EditorInfo editorInfo, @NonNull String mimeType) {
        if (editorInfo == null) {
            return false;
        }

        final InputConnection ic = getCurrentInputConnection();
        if (ic == null) {
            return false;
        }

        if (!validatePackageName(editorInfo)) {
            return false;
        }

        final String[] supportedMimeTypes = EditorInfoCompat.getContentMimeTypes(editorInfo);
        for (String supportedMimeType : supportedMimeTypes) {
            if (ClipDescription.compareMimeTypes(mimeType, supportedMimeType)) {
                return true;
            }
        }
        return false;
    }




    private boolean validatePackageName(@Nullable EditorInfo editorInfo) {
        if (editorInfo == null) {
            return false;
        }
        final String packageName = editorInfo.packageName;
        if (packageName == null) {
            return false;
        }

        // In Android L MR-1 and prior devices, EditorInfo.packageName is not a reliable identifier
        // of the target application because:
        //   1. the system does not verify it [1]
        //   2. InputMethodManager.startInputInner() had filled EditorInfo.packageName with
        //      view.getContext().getPackageName() [2]
        // [1]: https://android.googlesource.com/platform/frameworks/base/+/a0f3ad1b5aabe04d9eb1df8bad34124b826ab641
        // [2]: https://android.googlesource.com/platform/frameworks/base/+/02df328f0cd12f2af87ca96ecf5819c8a3470dc8
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return true;
        }

        final InputBinding inputBinding = getCurrentInputBinding();
        if (inputBinding == null) {
            // Due to b.android.com/225029, it is possible that getCurrentInputBinding() returns
            // null even after onStartInputView() is called.
            // TODO: Come up with a way to work around this bug....
            Log.e(TAG, "inputBinding should not be null here. "
                    + "You are likely to be hitting b.android.com/225029");
            return false;
        }
        final int packageUid = inputBinding.getUid();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            final AppOpsManager appOpsManager =
                    (AppOpsManager) getSystemService(Context.APP_OPS_SERVICE);
            try {
                appOpsManager.checkPackage(packageUid, packageName);
            } catch (Exception e) {
                return false;
            }
            return true;
        }

        final PackageManager packageManager = getPackageManager();
        final String possiblePackageNames[] = packageManager.getPackagesForUid(packageUid);
        for (final String possiblePackageName : possiblePackageNames) {
            if (packageName.equals(possiblePackageName)) {
                return true;
            }
        }
        return false;
    }






    /**
     * Commits a PNG image
     *
     * @param mimeType
     * @param imageDescription Description of the PNG image to be sent
     */
    public void doCommitContent(String imageDescription, String mimeType,
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





















    /**
     * what to do when certain special keys are pressed
     */
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

                keyboardView.invalidateAllKeys();
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
        keyboardView.setKeyboard(keyboard);
        keyboardView.setOnKeyboardActionListener(this);
        this.isSymbolVisible = true;
    }



    /**
     * Qwerty layout view
   */
    private void setMainView(){
        keyboard = new Keyboard(this, R.xml.qwerty);
        keyboardView.setKeyboard(keyboard);
        keyboardView.setOnKeyboardActionListener(this);
        this.isSymbolVisible = false;
    }




    /** Called when return button is pressed on image view
     * This is tied to the keyboard_layout_image which is where this function is called. Kinda
     * it is not called by anything within this file
     * */
    public void showKeys(View view) {
        // Do something in response to button click
        keyboardView.setVisibility(View.VISIBLE);
        ImageView.setVisibility(View.GONE);
    }



    /**
     * Image View Function
     * Sets image view to visible
    */
    private void changeToImageView()
    {
        keyboardView.setVisibility(View.GONE);
        ImageView.setVisibility(View.VISIBLE);
    }





    /**
     *
     */
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
//
//                    //DEBUG
//                    Log.i("test1", "value: " + R.raw.analyzeloop);

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






//    LinearLayout ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);

//for (int i = 0; i < rawFiles.length; i++) {
//        System.out.println(i);
//        if ((i % 2) == 0) {
//        ImageContainerColumn = (LinearLayout) getLayoutInflater().inflate(R.layout.image_container_column, ImageContainer, false);
//        }
//
//        // Creating button
//        ImageButton ImgButton = (ImageButton) getLayoutInflater().inflate(R.layout.image_button, ImageContainerColumn, false);
//        ImgButton.setImageResource(getResources().getIdentifier(rawFiles[i], "raw", getPackageName()));
//        ImgButton.setTag(rawFiles[i]);
//        ImgButton.setOnClickListener(new View.OnClickListener() {
//@Override
//public void onClick(View view) {
//        String emojiName = view.getTag().toString().replaceAll("_", "-");
//
//
//final File file = getFileForResource(CustomKeyboard.this, getResources().getIdentifier(view.getTag().toString(), "raw", getPackageName()), imagesDir, "image.png");
//
//        CustomKeyboard.this.doCommitContent("A ${emojiName} logo", MIME_TYPE_PNG, file);
//
//        }
//        });
//
//
//
//        ImageContainerColumn.addView(ImgButton);
//
//        if ((i % 2) == 0) {
//        ImageContainer.addView(ImageContainerColumn);
//        }
////        }